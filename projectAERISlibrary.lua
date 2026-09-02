local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")

local Player=Players.LocalPlayer
local PG=Player:WaitForChild("PlayerGui")

local UI={}
UI.Theme="Midnight"
UI.CustomColor=Color3.new(1,1,1)

local Themes={
	Midnight={Background=Color3.fromRGB(8,8,10),Panel=Color3.fromRGB(15,15,18),Text=Color3.new(1,1,1),Accent=Color3.new(1,1,1)},
	Ocean={Background=Color3.fromRGB(5,12,22),Panel=Color3.fromRGB(10,25,40),Text=Color3.new(1,1,1),Accent=Color3.fromRGB(70,170,255)},
	Purple={Background=Color3.fromRGB(15,8,22),Panel=Color3.fromRGB(28,15,40),Text=Color3.new(1,1,1),Accent=Color3.fromRGB(180,90,255)},
	Emerald={Background=Color3.fromRGB(5,18,13),Panel=Color3.fromRGB(10,30,22),Text=Color3.new(1,1,1),Accent=Color3.fromRGB(60,220,140)},
	Crimson={Background=Color3.fromRGB(22,6,8),Panel=Color3.fromRGB(38,12,15),Text=Color3.new(1,1,1),Accent=Color3.fromRGB(255,70,85)},
	Sunset={Background=Color3.fromRGB(25,12,5),Panel=Color3.fromRGB(42,20,8),Text=Color3.new(1,1,1),Accent=Color3.fromRGB(255,150,60)},
	Pink={Background=Color3.fromRGB(22,7,16),Panel=Color3.fromRGB(38,12,27),Text=Color3.new(1,1,1),Accent=Color3.fromRGB(255,100,190)},
	Cyan={Background=Color3.fromRGB(4,18,20),Panel=Color3.fromRGB(8,32,35),Text=Color3.new(1,1,1),Accent=Color3.fromRGB(70,230,240)},
	Gold={Background=Color3.fromRGB(20,16,5),Panel=Color3.fromRGB(36,29,8),Text=Color3.new(1,1,1),Accent=Color3.fromRGB(255,210,70)},
	Ice={Background=Color3.fromRGB(8,16,22),Panel=Color3.fromRGB(14,28,38),Text=Color3.new(1,1,1),Accent=Color3.fromRGB(150,220,255)}
}

local Old=PG:FindFirstChild("ModernUI")
if Old then Old:Destroy() end

local Gui=Instance.new("ScreenGui")
Gui.Name="ModernUI"
Gui.ResetOnSpawn=false
Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
Gui.Parent=PG
UI.Gui=Gui

local Main=Instance.new("Frame")
Main.Name="Main"
Main.Size=UDim2.fromOffset(400,300)
Main.Position=UDim2.fromScale(.5,.5)
Main.AnchorPoint=Vector2.new(.5,.5)
Main.BackgroundColor3=Themes.Midnight.Background
Main.BorderSizePixel=0
Main.ClipsDescendants=true
Main.Parent=Gui
UI.Main=Main

local Corner=Instance.new("UICorner")
Corner.CornerRadius=UDim.new(0,14)
Corner.Parent=Main

local Shadow=Instance.new("UIShadow")
Shadow.BlurRadius=UDim.new(0,18)
Shadow.Offset=UDim2.fromOffset(0,5)
Shadow.Spread=UDim2.fromOffset(2,2)
Shadow.Transparency=.45
Shadow.Color=Color3.new(0,0,0)
Shadow.Parent=Main

local Top=Instance.new("Frame")
Top.Size=UDim2.new(1,0,0,48)
Top.BackgroundColor3=Themes.Midnight.Panel
Top.BorderSizePixel=0
Top.Parent=Main

local TopCorner=Instance.new("UICorner")
TopCorner.CornerRadius=UDim.new(0,14)
TopCorner.Parent=Top

local Cover=Instance.new("Frame")
Cover.Size=UDim2.new(1,0,0,14)
Cover.Position=UDim2.new(0,0,1,-14)
Cover.BackgroundColor3=Themes.Midnight.Panel
Cover.BorderSizePixel=0
Cover.Parent=Top

local Title=Instance.new("TextLabel")
Title.BackgroundTransparency=1
Title.Position=UDim2.fromOffset(12,0)
Title.Size=UDim2.new(1,-230,1,0)
Title.Font=Enum.Font.GothamBold
Title.Text="Project AERIS"
Title.TextSize=15
Title.TextXAlignment=Enum.TextXAlignment.Left
Title.TextColor3=Color3.new(1,1,1)
Title.Parent=Top

local function TopButton(Text,X,W)
	local B=Instance.new("TextButton")
	B.Size=UDim2.fromOffset(W,34)
	B.Position=UDim2.new(1,X,0,7)
	B.AnchorPoint=Vector2.new(1,0)
	B.BackgroundColor3=Themes.Midnight.Background
	B.BorderSizePixel=0
	B.Text=Text
	B.TextColor3=Color3.new(1,1,1)
	B.TextSize=13
	B.Font=Enum.Font.GothamBold
	B.AutoButtonColor=false
	B.Parent=Top

	local C=Instance.new("UICorner")
	C.CornerRadius=UDim.new(0,8)
	C.Parent=B

	return B
end

local Key=TopButton("Key",-190,42)
local Min=TopButton("—",-144,34)
local Max=TopButton("□",-104,34)
local Close=TopButton("×",-64,34)

local TabBar=Instance.new("ScrollingFrame")
TabBar.Name="Tabs"
TabBar.Position=UDim2.fromOffset(8,56)
TabBar.Size=UDim2.new(1,-16,0,38)
TabBar.BackgroundTransparency=1
TabBar.BorderSizePixel=0
TabBar.ScrollBarThickness=0
TabBar.ScrollingDirection=Enum.ScrollingDirection.X
TabBar.ElasticBehavior=Enum.ElasticBehavior.Always
TabBar.AutomaticCanvasSize=Enum.AutomaticSize.X
TabBar.CanvasSize=UDim2.new()
TabBar.Parent=Main

local TabLayout=Instance.new("UIListLayout")
TabLayout.FillDirection=Enum.FillDirection.Horizontal
TabLayout.Padding=UDim.new(0,6)
TabLayout.VerticalAlignment=Enum.VerticalAlignment.Center
TabLayout.Parent=TabBar

local Content=Instance.new("Frame")
Content.Position=UDim2.fromOffset(8,100)
Content.Size=UDim2.new(1,-16,1,-108)
Content.BackgroundTransparency=1
Content.Parent=Main

local Pages={}
local CurrentPage

function UI:AddTab(Name)
	local Page={}
	Page.Name=Name

	local Button=Instance.new("TextButton")
	Button.Name=Name.."Tab"
	Button.Size=UDim2.fromOffset(math.max(70,#Name*8+28),32)
	Button.BackgroundColor3=Themes.Midnight.Background
	Button.BorderSizePixel=0
	Button.Text=Name
	Button.TextColor3=Color3.new(1,1,1)
	Button.TextSize=12
	Button.Font=Enum.Font.GothamMedium
	Button.AutoButtonColor=false
	Button.Parent=TabBar

	local BC=Instance.new("UICorner")
	BC.CornerRadius=UDim.new(0,8)
	BC.Parent=Button

	local Scroll=Instance.new("ScrollingFrame")
	Scroll.Name=Name.."Page"
	Scroll.Size=UDim2.fromScale(1,1)
	Scroll.BackgroundTransparency=1
	Scroll.BorderSizePixel=0
	Scroll.ScrollBarThickness=3
	Scroll.ScrollingDirection=Enum.ScrollingDirection.Y
	Scroll.ElasticBehavior=Enum.ElasticBehavior.Never
	Scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
	Scroll.CanvasSize=UDim2.new()
	Scroll.Visible=false
	Scroll.Parent=Content

	local Layout=Instance.new("UIListLayout")
	Layout.Padding=UDim.new(0,7)
	Layout.HorizontalAlignment=Enum.HorizontalAlignment.Center
	Layout.Parent=Scroll

	local Pad=Instance.new("UIPadding")
	Pad.PaddingTop=UDim.new(0,4)
	Pad.PaddingBottom=UDim.new(0,8)
	Pad.PaddingLeft=UDim.new(0,3)
	Pad.PaddingRight=UDim.new(0,3)
	Pad.Parent=Scroll

	Page.Button=Button
	Page.Page=Scroll
	Page.Layout=Layout

	function Page:Show()
		for _,P in pairs(Pages) do
			P.Page.Visible=false
			P.Button.BackgroundColor3=Themes[UI.Theme].Background
			P.Button.TextColor3=Color3.new(1,1,1)
		end

		Scroll.Visible=true
		Button.BackgroundColor3=Color3.new(1,1,1)
		Button.TextColor3=Color3.new(0,0,0)
		CurrentPage=Page
	end

	Button.Activated:Connect(function()
		Page:Show()
	end)

	table.insert(Pages,Page)

	if not CurrentPage then
		Page:Show()
	end

	return Page
end

local function Holder(Page,H,Height)
	H.BackgroundColor3=Themes.Midnight.Panel
	H.BorderSizePixel=0
	H.Size=UDim2.new(1,-6,0,Height)
	H.Parent=Page.Page

	H:SetAttribute("AERISPanel",true)

	local C=Instance.new("UICorner")
	C.CornerRadius=UDim.new(0,9)
	C.Parent=H
end

function UI:AddHeader(Page,Text)
	local H=Instance.new("TextLabel")
	H.BackgroundTransparency=1
	H.Size=UDim2.new(1,-10,0,30)
	H.Font=Enum.Font.GothamBold
	H.Text=Text
	H.TextSize=17
	H.TextXAlignment=Enum.TextXAlignment.Left
	H.TextColor3=Color3.new(1,1,1)
	H.Parent=Page.Page
	return H
end

function UI:AddSection(Page,Text)
	local H=Instance.new("TextLabel")
	H.BackgroundTransparency=1
	H.Size=UDim2.new(1,-10,0,25)
	H.Font=Enum.Font.GothamSemibold
	H.Text=Text
	H.TextSize=13
	H.TextXAlignment=Enum.TextXAlignment.Left
	H.TextColor3=Color3.fromRGB(180,180,180)
	H.Parent=Page.Page
	return H
end

function UI:AddLabel(Page,Text)
	local H=Instance.new("TextLabel")
	Holder(Page,H,32)
	H.Text=Text
	H.Font=Enum.Font.Gotham
	H.TextSize=12
	H.TextColor3=Color3.new(1,1,1)
	H.TextXAlignment=Enum.TextXAlignment.Left
	H.TextWrapped=true

	local Padding=Instance.new("UIPadding")
	Padding.PaddingLeft=UDim.new(0,10)
	Padding.PaddingRight=UDim.new(0,10)
	Padding.Parent=H

	return H
end

function UI:AddButton(Page,Text,Callback)
	local B=Instance.new("TextButton")
	Holder(Page,B,38)
	B.Text=Text
	B.Font=Enum.Font.GothamMedium
	B.TextSize=12
	B.TextColor3=Color3.new(1,1,1)
	B.AutoButtonColor=false

	B.Activated:Connect(function()
		if Callback then
			Callback()
		end
	end)

	return B
end

function UI:AddToggle(Page,Text,Default,Callback)
	local H=Instance.new("Frame")
	Holder(Page,H,42)

	local L=Instance.new("TextLabel")
	L.BackgroundTransparency=1
	L.Position=UDim2.fromOffset(10,0)
	L.Size=UDim2.new(1,-70,1,0)
	L.Text=Text
	L.Font=Enum.Font.GothamMedium
	L.TextSize=12
	L.TextColor3=Color3.new(1,1,1)
	L.TextXAlignment=Enum.TextXAlignment.Left
	L.Parent=H

	local B=Instance.new("TextButton")
	B.Size=UDim2.fromOffset(42,24)
	B.Position=UDim2.new(1,-52,.5,-12)
	B.BackgroundColor3=Color3.fromRGB(45,45,48)
	B.Text=""
	B.BorderSizePixel=0
	B.Parent=H

	local BC=Instance.new("UICorner")
	BC.CornerRadius=UDim.new(1,0)
	BC.Parent=B

	local Knob=Instance.new("Frame")
	Knob.Size=UDim2.fromOffset(18,18)
	Knob.Position=UDim2.fromOffset(3,3)
	Knob.BackgroundColor3=Color3.new(1,1,1)
	Knob.BorderSizePixel=0
	Knob.Parent=B

	local KC=Instance.new("UICorner")
	KC.CornerRadius=UDim.new(1,0)
	KC.Parent=Knob

	local State=Default==true

	local function Set(V)
		State=V

		Knob:TweenPosition(
			V and UDim2.new(1,-21,0,3) or UDim2.fromOffset(3,3),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quad,
			.15,
			true
		)

		if Callback then
			Callback(V)
		end
	end

	B.Activated:Connect(function()
		Set(not State)
	end)

	Set(State)

	return H
end

function UI:AddSlider(Page,Text,MinValue,MaxValue,Default,Callback)
	local H=Instance.new("Frame")
	Holder(Page,H,55)

	local L=Instance.new("TextLabel")
	L.BackgroundTransparency=1
	L.Position=UDim2.fromOffset(10,4)
	L.Size=UDim2.new(1,-80,0,20)
	L.Text=Text
	L.Font=Enum.Font.GothamMedium
	L.TextSize=12
	L.TextColor3=Color3.new(1,1,1)
	L.TextXAlignment=Enum.TextXAlignment.Left
	L.Parent=H

	local V=Instance.new("TextLabel")
	V.BackgroundTransparency=1
	V.Position=UDim2.new(1,-65,0,4)
	V.Size=UDim2.fromOffset(55,20)
	V.Text=tostring(Default)
	V.Font=Enum.Font.GothamMedium
	V.TextSize=12
	V.TextColor3=Color3.new(1,1,1)
	V.TextXAlignment=Enum.TextXAlignment.Right
	V.Parent=H

	local Bar=Instance.new("Frame")
	Bar.Position=UDim2.new(0,10,1,-17)
	Bar.Size=UDim2.new(1,-20,0,5)
	Bar.BackgroundColor3=Color3.fromRGB(45,45,48)
	Bar.BorderSizePixel=0
	Bar.Parent=H

	local BC=Instance.new("UICorner")
	BC.CornerRadius=UDim.new(1,0)
	BC.Parent=Bar

	local Fill=Instance.new("Frame")
	Fill.Size=UDim2.new(0,0,1,0)
	Fill.BackgroundColor3=Color3.new(1,1,1)
	Fill.BorderSizePixel=0
	Fill.Parent=Bar

	local FC=Instance.new("UICorner")
	FC.CornerRadius=UDim.new(1,0)
	FC.Parent=Fill

	local Knob=Instance.new("Frame")
	Knob.Size=UDim2.fromOffset(13,13)
	Knob.AnchorPoint=Vector2.new(.5,.5)
	Knob.Position=UDim2.new(0,0,.5,0)
	Knob.BackgroundColor3=Color3.new(1,1,1)
	Knob.BorderSizePixel=0
	Knob.Parent=Bar

	local KC=Instance.new("UICorner")
	KC.CornerRadius=UDim.new(1,0)
	KC.Parent=Knob

	local Drag=false

	local function Set(Value)
		Value=math.clamp(Value,MinValue,MaxValue)

		local Alpha=(Value-MinValue)/(MaxValue-MinValue)

		Fill.Size=UDim2.new(Alpha,0,1,0)
		Knob.Position=UDim2.new(Alpha,0,.5,0)
		V.Text=tostring(math.floor(Value))

		if Callback then
			Callback(Value)
		end
	end

	local function Update(X)
		local Alpha=math.clamp(
			(X-Bar.AbsolutePosition.X)/Bar.AbsoluteSize.X,
			0,
			1
		)

		Set(MinValue+(MaxValue-MinValue)*Alpha)
	end

	Bar.InputBegan:Connect(function(I)
		if I.UserInputType==Enum.UserInputType.MouseButton1
		or I.UserInputType==Enum.UserInputType.Touch then
			Drag=true
			Update(I.Position.X)
		end
	end)

	UIS.InputChanged:Connect(function(I)
		if Drag and (
			I.UserInputType==Enum.UserInputType.MouseMovement
			or I.UserInputType==Enum.UserInputType.Touch
		) then
			Update(I.Position.X)
		end
	end)

	UIS.InputEnded:Connect(function(I)
		if I.UserInputType==Enum.UserInputType.MouseButton1
		or I.UserInputType==Enum.UserInputType.Touch then
			Drag=false
		end
	end)

	Set(Default)

	return H
end

function UI:AddDropdown(Page,Text,Options,Callback)
	local H=Instance.new("Frame")
	Holder(Page,H,42)

	local B=Instance.new("TextButton")
	B.Size=UDim2.new(1,-12,0,32)
	B.Position=UDim2.fromOffset(6,5)
	B.BackgroundTransparency=1
	B.Text=Text
	B.TextColor3=Color3.new(1,1,1)
	B.TextSize=12
	B.Font=Enum.Font.GothamMedium
	B.TextXAlignment=Enum.TextXAlignment.Left
	B.Parent=H

	local Open=false

	B.Activated:Connect(function()
		Open=not Open

		local Extra=Open and (#Options*30+8) or 0
		H.Size=UDim2.new(1,-6,0,42+Extra)

		for _,C in ipairs(H:GetChildren()) do
			if C:GetAttribute("AERISOption") then
				C:Destroy()
			end
		end

		if Open then
			for I,Option in ipairs(Options) do
				local O=Instance.new("TextButton")
				O:SetAttribute("AERISOption",true)
				O.Size=UDim2.new(1,-12,0,27)
				O.Position=UDim2.fromOffset(6,40+(I-1)*30)
				O.BackgroundColor3=Themes[UI.Theme].Background
				O.BorderSizePixel=0
				O.Text=tostring(Option)
				O.TextColor3=Color3.new(1,1,1)
				O.TextSize=11
				O.Font=Enum.Font.Gotham
				O.Parent=H

				local C=Instance.new("UICorner")
				C.CornerRadius=UDim.new(0,7)
				C.Parent=O

				O.Activated:Connect(function()
					B.Text=Text..": "..tostring(Option)
					Open=false
					H.Size=UDim2.new(1,-6,0,42)

					if Callback then
						Callback(Option)
					end
				end)
			end
		end
	end)

	return H
end

function UI:AddColorPicker(Page,Text,Default,Callback)
	local H=Instance.new("Frame")
	Holder(Page,H,145)

	local L=Instance.new("TextLabel")
	L.BackgroundTransparency=1
	L.Position=UDim2.fromOffset(10,4)
	L.Size=UDim2.new(1,-20,0,24)
	L.Text=Text
	L.Font=Enum.Font.GothamMedium
	L.TextSize=12
	L.TextColor3=Color3.new(1,1,1)
	L.TextXAlignment=Enum.TextXAlignment.Left
	L.Parent=H

	local R=Instance.new("TextBox")
	R.Size=UDim2.fromOffset(65,30)
	R.Position=UDim2.fromOffset(8,35)
	R.Text="255"
	R.PlaceholderText="R"
	R.Font=Enum.Font.Gotham
	R.TextSize=12
	R.TextColor3=Color3.new(1,1,1)
	R.BackgroundColor3=Themes.Midnight.Background
	R.BorderSizePixel=0
	R.Parent=H

	local G=R:Clone()
	G.Position=UDim2.fromOffset(78,35)
	G.Text="255"
	G.PlaceholderText="G"
	G.Parent=H

	local B=R:Clone()
	B.Position=UDim2.fromOffset(148,35)
	B.Text="255"
	B.PlaceholderText="B"
	B.Parent=H

	local Apply=Instance.new("TextButton")
	Apply.Size=UDim2.fromOffset(80,30)
	Apply.Position=UDim2.new(1,-90,0,35)
	Apply.Text="Apply"
	Apply.Font=Enum.Font.GothamMedium
	Apply.TextSize=11
	Apply.TextColor3=Color3.new(1,1,1)
	Apply.BackgroundColor3=Themes.Midnight.Background
	Apply.BorderSizePixel=0
	Apply.Parent=H

	local C=Instance.new("UICorner")
	C.CornerRadius=UDim.new(0,7)
	C.Parent=Apply

	local Reset=Apply:Clone()
	Reset.Position=UDim2.fromOffset(8,75)
	Reset.Text="Reset"
	Reset.Parent=H

	local function ApplyColor()
		local Rv=math.clamp(tonumber(R.Text) or 255,0,255)
		local Gv=math.clamp(tonumber(G.Text) or 255,0,255)
		local Bv=math.clamp(tonumber(B.Text) or 255,0,255)

		local Color=Color3.fromRGB(Rv,Gv,Bv)

		UI.CustomColor=Color

		if Callback then
			Callback(Color)
		end
	end

	Apply.Activated:Connect(ApplyColor)

	Reset.Activated:Connect(function()
		R.Text="255"
		G.Text="255"
		B.Text="255"
		UI.CustomColor=Color3.new(1,1,1)

		if Callback then
			Callback(UI.CustomColor)
		end
	end)

	return H
end

function UI:Notify(Text)
	local N=Instance.new("TextLabel")
	N.Size=UDim2.fromOffset(260,42)
	N.Position=UDim2.new(1,280,1,-55)
	N.AnchorPoint=Vector2.new(1,0)
	N.BackgroundColor3=Themes[UI.Theme].Panel
	N.BorderSizePixel=0
	N.Text=tostring(Text)
	N.TextColor3=Color3.new(1,1,1)
	N.TextSize=12
	N.Font=Enum.Font.GothamMedium
	N.Parent=Gui

	local C=Instance.new("UICorner")
	C.CornerRadius=UDim.new(0,9)
	C.Parent=N

	N:TweenPosition(
		UDim2.new(1,-12,1,-55),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quart,
		.3,
		true
	)

	task.delay(2.5,function()
		N:TweenPosition(
			UDim2.new(1,280,1,-55),
			Enum.EasingDirection.In,
			Enum.EasingStyle.Quart,
			.3,
			true
		)

		task.wait(.35)

		if N then
			N:Destroy()
		end
	end)
end

function UI:SetTheme(Name)
	local T=Themes[Name]
	if not T then return end

	UI.Theme=Name

	Main.BackgroundColor3=T.Background
	Top.BackgroundColor3=T.Panel
	Cover.BackgroundColor3=T.Panel

	for _,P in ipairs(Pages) do
		P.Button.BackgroundColor3=T.Background
	end

	for _,Obj in ipairs(Gui:GetDescendants()) do
		if Obj:IsA("Frame") and Obj:GetAttribute("AERISPanel") then
			Obj.BackgroundColor3=T.Panel
		end
	end
end

local Minimized=false
local Maximized=false

Min.Activated:Connect(function()
	Minimized=not Minimized

	if Minimized then
		Content.Visible=false
		TabBar.Visible=false

		Main:TweenSize(
			UDim2.fromOffset(400,48),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quart,
			.25,
			true
		)
	else
		Content.Visible=true
		TabBar.Visible=true

		Main:TweenSize(
			Maximized and UDim2.new(.85,0,.8,0)
			or UDim2.fromOffset(400,300),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quart,
			.25,
			true
		)
	end
end)

Max.Activated:Connect(function()
	Maximized=not Maximized

	if Maximized then
		Main:TweenSize(
			UDim2.new(.85,0,.8,0),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quart,
			.25,
			true
		)
	else
		Main:TweenSize(
			UDim2.fromOffset(400,300),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quart,
			.25,
			true
		)
	end
end)

Close.Activated:Connect(function()
	Gui:Destroy()
end)

local Capturing=false

Key.Activated:Connect(function()
	if Capturing then return end

	Capturing=true
	Key.Text="..."

	local Connection

	Connection=UIS.InputBegan:Connect(function(I)
		if I.UserInputType==Enum.UserInputType.Keyboard then
			Key.Text=I.KeyCode.Name
			Capturing=false
			Connection:Disconnect()
		end
	end)
end)

local Dragging=false
local DragStart
local StartPosition

Top.InputBegan:Connect(function(I)
	if I.UserInputType==Enum.UserInputType.MouseButton1
	or I.UserInputType==Enum.UserInputType.Touch then
		Dragging=true
		DragStart=I.Position
		StartPosition=Main.Position
	end
end)

UIS.InputChanged:Connect(function(I)
	if Dragging and (
		I.UserInputType==Enum.UserInputType.MouseMovement
		or I.UserInputType==Enum.UserInputType.Touch
	) then
		local D=I.Position-DragStart

		Main.Position=UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset+D.X,
			StartPosition.Y.Scale,
			StartPosition.Y.Offset+D.Y
		)
	end
end)

UIS.InputEnded:Connect(function(I)
	if I.UserInputType==Enum.UserInputType.MouseButton1
	or I.UserInputType==Enum.UserInputType.Touch then
		Dragging=false
	end
end)

return UI

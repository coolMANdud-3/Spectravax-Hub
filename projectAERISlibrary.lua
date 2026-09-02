local P=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")

local L={}
local G=Instance.new("ScreenGui")
G.Name="ModernUI"
G.ResetOnSpawn=false
G.Parent=P.LocalPlayer:WaitForChild("PlayerGui")

local function tw(o,t,p)
	TS:Create(o,TweenInfo.new(t,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),p):Play()
end

local function corner(o,r)
	local c=Instance.new("UICorner")
	c.CornerRadius=UDim.new(0,r)
	c.Parent=o
end

local Themes={
	Midnight={M=Color3.fromRGB(5,5,7),P=Color3.fromRGB(15,15,18),A=Color3.fromRGB(255,255,255),T=Color3.fromRGB(255,255,255),S=Color3.fromRGB(155,155,160)},
	Ocean={M=Color3.fromRGB(5,10,15),P=Color3.fromRGB(10,25,35),A=Color3.fromRGB(100,200,255),T=Color3.fromRGB(255,255,255),S=Color3.fromRGB(150,180,195)},
	Purple={M=Color3.fromRGB(10,5,15),P=Color3.fromRGB(25,12,35),A=Color3.fromRGB(190,120,255),T=Color3.fromRGB(255,255,255),S=Color3.fromRGB(175,155,190)},
	Emerald={M=Color3.fromRGB(5,12,8),P=Color3.fromRGB(10,28,18),A=Color3.fromRGB(100,255,170),T=Color3.fromRGB(255,255,255),S=Color3.fromRGB(155,185,165)},
	Crimson={M=Color3.fromRGB(15,5,7),P=Color3.fromRGB(32,10,14),A=Color3.fromRGB(255,100,115),T=Color3.fromRGB(255,255,255),S=Color3.fromRGB(190,155,160)},
	Sunset={M=Color3.fromRGB(18,8,5),P=Color3.fromRGB(35,18,10),A=Color3.fromRGB(255,165,80),T=Color3.fromRGB(255,255,255),S=Color3.fromRGB(195,165,145)},
	Pink={M=Color3.fromRGB(15,5,10),P=Color3.fromRGB(32,10,22),A=Color3.fromRGB(255,130,200),T=Color3.fromRGB(255,255,255),S=Color3.fromRGB(190,155,175)},
	Cyan={M=Color3.fromRGB(4,12,14),P=Color3.fromRGB(8,27,31),A=Color3.fromRGB(80,240,255),T=Color3.fromRGB(255,255,255),S=Color3.fromRGB(150,190,195)},
	Gold={M=Color3.fromRGB(14,11,5),P=Color3.fromRGB(30,23,8),A=Color3.fromRGB(255,215,90),T=Color3.fromRGB(255,255,255),S=Color3.fromRGB(190,175,135)},
	Ice={M=Color3.fromRGB(7,11,16),P=Color3.fromRGB(15,25,35),A=Color3.fromRGB(170,220,255),T=Color3.fromRGB(255,255,255),S=Color3.fromRGB(160,180,195)}
}

L.Theme=Themes.Midnight
L.CustomColor=Color3.new(1,1,1)

local Main=Instance.new("Frame")
Main.Size=UDim2.fromOffset(400,300)
Main.Position=UDim2.new(.5,-200,.5,-150)
Main.BackgroundColor3=L.Theme.M
Main.BorderSizePixel=0
Main.ClipsDescendants=true
Main.Parent=G
corner(Main,14)

local Sh=Instance.new("UIShadow")
Sh.BlurRadius=UDim.new(0,18)
Sh.Offset=UDim2.fromOffset(0,5)
Sh.Spread=UDim2.fromOffset(2,2)
Sh.Transparency=.45
Sh.Color=Color3.new(0,0,0)
Sh.Parent=Main

local Top=Instance.new("Frame")
Top.Size=UDim2.new(1,0,0,48)
Top.BackgroundColor3=L.Theme.P
Top.BorderSizePixel=0
Top.Parent=Main
corner(Top,14)

local Cover=Instance.new("Frame")
Cover.Size=UDim2.new(1,0,0,14)
Cover.Position=UDim2.fromOffset(0,34)
Cover.BackgroundColor3=L.Theme.P
Cover.BorderSizePixel=0
Cover.Parent=Top

local Title=Instance.new("TextLabel")
Title.Size=UDim2.new(1,-190,0,24)
Title.Position=UDim2.fromOffset(12,5)
Title.BackgroundTransparency=1
Title.Text="Modern UI"
Title.Font=Enum.Font.GothamBold
Title.TextSize=16
Title.TextColor3=L.Theme.T
Title.TextXAlignment=Enum.TextXAlignment.Left
Title.Parent=Top

local Sub=Instance.new("TextLabel")
Sub.Size=UDim2.new(1,-190,0,16)
Sub.Position=UDim2.fromOffset(12,27)
Sub.BackgroundTransparency=1
Sub.Text="Modern interface"
Sub.Font=Enum.Font.Gotham
Sub.TextSize=10
Sub.TextColor3=L.Theme.S
Sub.TextXAlignment=Enum.TextXAlignment.Left
Sub.Parent=Top

local function topBtn(text,x,w)
	local b=Instance.new("TextButton")
	b.Size=UDim2.fromOffset(w,30)
	b.Position=UDim2.new(1,x,0,9)
	b.BackgroundColor3=L.Theme.M
	b.Text=text
	b.TextColor3=L.Theme.T
	b.Font=Enum.Font.GothamBold
	b.TextSize=12
	b.BorderSizePixel=0
	b.Parent=Top
	corner(b,8)
	return b
end

local Close=topBtn("×",-40,32)
local Max=topBtn("□",-76,32)
local Min=topBtn("—",-112,32)
local Key=topBtn("Key",-160,42)

local Content=Instance.new("Frame")
Content.Size=UDim2.new(1,0,1,-48)
Content.Position=UDim2.fromOffset(0,48)
Content.BackgroundTransparency=1
Content.Parent=Main

local Tabs=Instance.new("ScrollingFrame")
Tabs.Size=UDim2.new(1,-20,0,38)
Tabs.Position=UDim2.fromOffset(10,5)
Tabs.BackgroundTransparency=1
Tabs.BorderSizePixel=0
Tabs.ScrollBarThickness=0
Tabs.ScrollingDirection=Enum.ScrollingDirection.X
Tabs.ElasticBehavior=Enum.ElasticBehavior.Always
Tabs.AutomaticCanvasSize=Enum.AutomaticSize.X
Tabs.CanvasSize=UDim2.new()
Tabs.Parent=Content

local TabLayout=Instance.new("UIListLayout")
TabLayout.FillDirection=Enum.FillDirection.Horizontal
TabLayout.Padding=UDim.new(0,6)
TabLayout.Parent=Tabs

local Pages=Instance.new("Frame")
Pages.Size=UDim2.new(1,-20,1,-48)
Pages.Position=UDim2.fromOffset(10,43)
Pages.BackgroundTransparency=1
Pages.Parent=Content

local TabsList={}
local currentPage

local function pageScroll()
	local s=Instance.new("ScrollingFrame")
	s.Size=UDim2.new(1,0,1,0)
	s.BackgroundTransparency=1
	s.BorderSizePixel=0
	s.ScrollBarThickness=3
	s.ScrollingDirection=Enum.ScrollingDirection.Y
	s.ElasticBehavior=Enum.ElasticBehavior.Never
	s.AutomaticCanvasSize=Enum.AutomaticSize.Y
	s.CanvasSize=UDim2.new()
	s.Visible=false
	s.Parent=Pages

	local l=Instance.new("UIListLayout")
	l.Padding=UDim.new(0,7)
	l.HorizontalAlignment=Enum.HorizontalAlignment.Center
	l.Parent=s

	local p=Instance.new("UIPadding")
	p.PaddingTop=UDim.new(0,4)
	p.PaddingBottom=UDim.new(0,12)
	p.Parent=s

	return s
end

local function selectTab(page,button)
	for p,b in pairs(TabsList) do
		p.Visible=false
		b.BackgroundColor3=L.Theme.M
		b.TextColor3=L.Theme.T
	end

	page.Visible=true
	button.BackgroundColor3=L.Theme.T
	button.TextColor3=L.Theme.M
	currentPage=page
end

function L:AddTab(name)
	local b=Instance.new("TextButton")
	b.Size=UDim2.fromOffset(100,32)
	b.BackgroundColor3=L.Theme.M
	b.Text=name
	b.TextColor3=L.Theme.T
	b.Font=Enum.Font.GothamBold
	b.TextSize=12
	b.BorderSizePixel=0
	b.Parent=Tabs
	corner(b,8)

	local p=pageScroll()
	TabsList[p]=b

	b.Activated:Connect(function()
		selectTab(p,b)
	end)

	if not currentPage then
		selectTab(p,b)
	end

	return p
end

local function holder(parent,h)
	local f=Instance.new("Frame")
	f.Size=UDim2.new(1,-8,0,h)
	f.BackgroundColor3=L.Theme.P
	f.BorderSizePixel=0
	f.Parent=parent
	corner(f,9)
	return f
end

function L:AddHeader(parent,text)
	local f=holder(parent,30)

	local t=Instance.new("TextLabel")
	t.Size=UDim2.new(1,-16,1,0)
	t.Position=UDim2.fromOffset(8,0)
	t.BackgroundTransparency=1
	t.Text=text
	t.TextColor3=L.Theme.T
	t.Font=Enum.Font.GothamBold
	t.TextSize=13
	t.TextXAlignment=Enum.TextXAlignment.Left
	t.Parent=f

	return f
end

function L:AddSection(parent,text)
	local f=holder(parent,26)

	local t=Instance.new("TextLabel")
	t.Size=UDim2.new(1,-16,1,0)
	t.Position=UDim2.fromOffset(8,0)
	t.BackgroundTransparency=1
	t.Text=text
	t.TextColor3=L.Theme.A
	t.Font=Enum.Font.GothamBold
	t.TextSize=11
	t.TextXAlignment=Enum.TextXAlignment.Left
	t.Parent=f

	return f
end

function L:AddLabel(parent,text)
	local f=holder(parent,32)

	local t=Instance.new("TextLabel")
	t.Size=UDim2.new(1,-16,1,0)
	t.Position=UDim2.fromOffset(8,0)
	t.BackgroundTransparency=1
	t.Text=text
	t.TextColor3=L.Theme.S
	t.Font=Enum.Font.Gotham
	t.TextSize=11
	t.TextXAlignment=Enum.TextXAlignment.Left
	t.Parent=f

	return f
end

function L:AddButton(parent,text,callback)
	local f=holder(parent,34)

	local b=Instance.new("TextButton")
	b.Size=UDim2.new(1,-10,1,-6)
	b.Position=UDim2.fromOffset(5,3)
	b.BackgroundColor3=L.Theme.M
	b.Text=text
	b.TextColor3=L.Theme.T
	b.Font=Enum.Font.GothamBold
	b.TextSize=11
	b.BorderSizePixel=0
	b.Parent=f
	corner(b,7)

	b.Activated:Connect(function()
		if callback then
			callback()
		end
	end)

	return f
end

function L:AddToggle(parent,text,value,callback)
	local f=holder(parent,38)

	local t=Instance.new("TextLabel")
	t.Size=UDim2.new(1,-65,1,0)
	t.Position=UDim2.fromOffset(9,0)
	t.BackgroundTransparency=1
	t.Text=text
	t.TextColor3=L.Theme.T
	t.Font=Enum.Font.Gotham
	t.TextSize=11
	t.TextXAlignment=Enum.TextXAlignment.Left
	t.Parent=f

	local track=Instance.new("TextButton")
	track.Size=UDim2.fromOffset(42,22)
	track.Position=UDim2.new(1,-51,.5,-11)
	track.BackgroundColor3=L.Theme.M
	track.Text=""
	track.BorderSizePixel=0
	track.Parent=f
	corner(track,11)

	local knob=Instance.new("Frame")
	knob.Size=UDim2.fromOffset(18,18)
	knob.Position=value and UDim2.new(1,-20,.5,-9) or UDim2.fromOffset(2,2)
	knob.BackgroundColor3=L.Theme.T
	knob.BorderSizePixel=0
	knob.Parent=track
	corner(knob,9)

	local on=value

	track.Activated:Connect(function()
		on=not on

		tw(knob,.18,{
			Position=on and UDim2.new(1,-20,.5,-9) or UDim2.fromOffset(2,2)
		})

		if callback then
			callback(on)
		end
	end)

	return f
end

function L:AddSlider(parent,text,min,max,value,callback)
	local f=holder(parent,48)

	local t=Instance.new("TextLabel")
	t.Size=UDim2.new(1,-20,0,18)
	t.Position=UDim2.fromOffset(9,3)
	t.BackgroundTransparency=1
	t.Text=text.." : "..tostring(value)
	t.TextColor3=L.Theme.T
	t.Font=Enum.Font.Gotham
	t.TextSize=11
	t.TextXAlignment=Enum.TextXAlignment.Left
	t.Parent=f

	local bar=Instance.new("Frame")
	bar.Size=UDim2.new(1,-20,0,5)
	bar.Position=UDim2.fromOffset(10,31)
	bar.BackgroundColor3=L.Theme.M
	bar.BorderSizePixel=0
	bar.Parent=f
	corner(bar,4)

	local fill=Instance.new("Frame")
	fill.Size=UDim2.new((value-min)/(max-min),0,1,0)
	fill.BackgroundColor3=L.Theme.T
	fill.BorderSizePixel=0
	fill.Parent=bar
	corner(fill,4)

	local knob=Instance.new("Frame")
	knob.Size=UDim2.fromOffset(14,14)
	knob.Position=UDim2.new((value-min)/(max-min),-7,.5,-7)
	knob.BackgroundColor3=L.Theme.T
	knob.BorderSizePixel=0
	knob.Parent=bar
	corner(knob,7)

	local drag=false

	bar.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			drag=true
		end
	end)

	UIS.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			drag=false
		end
	end)

	UIS.InputChanged:Connect(function(i)
		if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
			local x=math.clamp((i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
			local v=math.floor(min+(max-min)*x+.5)

			t.Text=text.." : "..tostring(v)
			fill.Size=UDim2.new(x,0,1,0)
			knob.Position=UDim2.new(x,-7,.5,-7)

			if callback then
				callback(v)
			end
		end
	end)

	return f
end

function L:AddDropdown(parent,text,options,callback)
	local open=false
	local f=holder(parent,36)

	local b=Instance.new("TextButton")
	b.Size=UDim2.new(1,-10,1,-6)
	b.Position=UDim2.fromOffset(5,3)
	b.BackgroundColor3=L.Theme.M
	b.Text=text.."  ▼"
	b.TextColor3=L.Theme.T
	b.Font=Enum.Font.GothamBold
	b.TextSize=11
	b.BorderSizePixel=0
	b.Parent=f
	corner(b,7)

	local list=Instance.new("Frame")
	list.Size=UDim2.new(1,-10,0,0)
	list.Position=UDim2.fromOffset(5,40)
	list.BackgroundColor3=L.Theme.M
	list.BorderSizePixel=0
	list.Visible=false
	list.ClipsDescendants=true
	list.Parent=f
	corner(list,7)

	local layout=Instance.new("UIListLayout")
	layout.Padding=UDim.new(0,3)
	layout.Parent=list

	for _,v in ipairs(options) do
		local o=Instance.new("TextButton")
		o.Size=UDim2.new(1,-6,0,28)
		o.BackgroundColor3=L.Theme.P
		o.Text=tostring(v)
		o.TextColor3=L.Theme.T
		o.Font=Enum.Font.Gotham
		o.TextSize=10
		o.BorderSizePixel=0
		o.Parent=list
		corner(o,6)

		o.Activated:Connect(function()
			b.Text=text.."  "..tostring(v)

			if callback then
				callback(v)
			end

			open=false
			tw(list,.18,{Size=UDim2.new(1,-10,0,0)})
			tw(f,.18,{Size=UDim2.new(1,-8,0,36)})

			task.delay(.18,function()
				if not open then
					list.Visible=false
				end
			end)
		end)
	end

	b.Activated:Connect(function()
		open=not open

		if open then
			list.Visible=true
			local h=#options*31+3
			tw(list,.2,{Size=UDim2.new(1,-10,0,h)})
			tw(f,.2,{Size=UDim2.new(1,-8,0,40+h)})
		else
			tw(list,.2,{Size=UDim2.new(1,-10,0,0)})
			tw(f,.2,{Size=UDim2.new(1,-8,0,36)})

			task.delay(.2,function()
				if not open then
					list.Visible=false
				end
			end)
		end
	end)

	return f
end

function L:AddColorPicker(parent,text,color,callback)
	local open=false
	local f=holder(parent,36)

	local b=Instance.new("TextButton")
	b.Size=UDim2.new(1,-10,0,30)
	b.Position=UDim2.fromOffset(5,3)
	b.BackgroundColor3=L.Theme.M
	b.Text=text
	b.TextColor3=L.Theme.T
	b.Font=Enum.Font.GothamBold
	b.TextSize=11
	b.BorderSizePixel=0
	b.Parent=f
	corner(b,7)

	local preview=Instance.new("Frame")
	preview.Size=UDim2.fromOffset(24,18)
	preview.Position=UDim2.new(1,-35,.5,-9)
	preview.BackgroundColor3=color
	preview.BorderSizePixel=0
	preview.Parent=b
	corner(preview,5)

	local box=Instance.new("Frame")
	box.Size=UDim2.new(1,-10,0,0)
	box.Position=UDim2.fromOffset(5,40)
	box.BackgroundColor3=L.Theme.M
	box.BorderSizePixel=0
	box.Visible=false
	box.ClipsDescendants=true
	box.Parent=f
	corner(box,8)

	local info=Instance.new("TextLabel")
	info.Size=UDim2.new(1,-12,0,22)
	info.Position=UDim2.fromOffset(6,5)
	info.BackgroundTransparency=1
	info.Text="RGB Color Picker"
	info.TextColor3=L.Theme.T
	info.Font=Enum.Font.GothamBold
	info.TextSize=11
	info.TextXAlignment=Enum.TextXAlignment.Left
	info.Parent=box

	local inputs={}
	local names={"R","G","B"}

	for i,n in ipairs(names) do
		local tb=Instance.new("TextBox")
		tb.Size=UDim2.new(.3,-2,0,30)
		tb.Position=UDim2.new((i-1)*.34,6,0,32)
		tb.BackgroundColor3=L.Theme.P
		tb.Text=n
		tb.PlaceholderText=n
		tb.TextColor3=L.Theme.T
		tb.Font=Enum.Font.Gotham
		tb.TextSize=11
		tb.ClearTextOnFocus=false
		tb.BorderSizePixel=0
		tb.Parent=box
		corner(tb,6)
		inputs[n]=tb
	end

	local apply=Instance.new("TextButton")
	apply.Size=UDim2.new(.48,-7,0,30)
	apply.Position=UDim2.new(0,6,0,68)
	apply.BackgroundColor3=L.Theme.T
	apply.Text="APPLY RGB"
	apply.TextColor3=L.Theme.M
	apply.Font=Enum.Font.GothamBold
	apply.TextSize=10
	apply.BorderSizePixel=0
	apply.Parent=box
	corner(apply,6)

	local reset=Instance.new("TextButton")
	reset.Size=UDim2.new(.48,-7,0,30)
	reset.Position=UDim2.new(.52,1,0,68)
	reset.BackgroundColor3=L.Theme.P
	reset.Text="RESET"
	reset.TextColor3=L.Theme.T
	reset.Font=Enum.Font.GothamBold
	reset.TextSize=10
	reset.BorderSizePixel=0
	reset.Parent=box
	corner(reset,6)

	local function setColor(c)
		color=c
		preview.BackgroundColor3=c

		if callback then
			callback(c)
		end
	end

	apply.Activated:Connect(function()
		local r=math.clamp(tonumber(inputs.R.Text) or 255,0,255)
		local g=math.clamp(tonumber(inputs.G.Text) or 255,0,255)
		local bl=math.clamp(tonumber(inputs.B.Text) or 255,0,255)

		setColor(Color3.fromRGB(r,g,bl))
	end)

	reset.Activated:Connect(function()
		inputs.R.Text="255"
		inputs.G.Text="255"
		inputs.B.Text="255"
		setColor(Color3.new(1,1,1))
	end)

	b.Activated:Connect(function()
		open=not open

		if open then
			box.Visible=true
			tw(box,.22,{Size=UDim2.new(1,-10,0,105)})
			tw(f,.22,{Size=UDim2.new(1,-8,0,149)})
		else
			tw(box,.22,{Size=UDim2.new(1,-10,0,0)})
			tw(f,.22,{Size=UDim2.new(1,-8,0,36)})

			task.delay(.22,function()
				if not open then
					box.Visible=false
				end
			end)
		end
	end)

	return f
end

function L:Notify(text,duration)
	local n=Instance.new("Frame")
	n.Size=UDim2.fromOffset(230,48)
	n.Position=UDim2.new(1,10,1,-60)
	n.BackgroundColor3=L.Theme.P
	n.BorderSizePixel=0
	n.Parent=G
	corner(n,9)

	local t=Instance.new("TextLabel")
	t.Size=UDim2.new(1,-16,1,0)
	t.Position=UDim2.fromOffset(8,0)
	t.BackgroundTransparency=1
	t.Text=text
	t.TextColor3=L.Theme.T
	t.Font=Enum.Font.Gotham
	t.TextSize=11
	t.TextXAlignment=Enum.TextXAlignment.Left
	t.Parent=n

	tw(n,.25,{Position=UDim2.new(1,-240,1,-60)})

	task.delay(duration or 2,function()
		tw(n,.25,{Position=UDim2.new(1,10,1,-60)})
		task.wait(.25)
		n:Destroy()
	end)
end

local function applyTheme()
	Main.BackgroundColor3=L.Theme.M
	Top.BackgroundColor3=L.Theme.P
	Cover.BackgroundColor3=L.Theme.P
	Title.TextColor3=L.Theme.T
	Sub.TextColor3=L.Theme.S

	for _,b in pairs(TabsList) do
		b.BackgroundColor3=L.Theme.M
		b.TextColor3=L.Theme.T
	end

	for p,b in pairs(TabsList) do
		if p==currentPage then
			b.BackgroundColor3=L.Theme.T
			b.TextColor3=L.Theme.M
		end
	end
end

function L:SetTheme(name)
	if Themes[name] then
		L.Theme=Themes[name]
		applyTheme()
	end
end

local MainPage=L:AddTab("Main")
local SettingsPage=L:AddTab("Settings")

local minimized=false
local maximized=false
local normalSize=UDim2.fromOffset(400,300)

Min.Activated:Connect(function()
	minimized=not minimized

	if minimized then
		Content.Visible=false
		tw(Main,.2,{Size=UDim2.fromOffset(400,48)})
	else
		Content.Visible=true
		tw(Main,.2,{Size=normalSize})
	end
end)

Max.Activated:Connect(function()
	if minimized then
		minimized=false
		Content.Visible=true
	end

	maximized=not maximized

	if maximized then
		tw(Main,.25,{
			Size=UDim2.new(.85,0,.8,0),
			Position=UDim2.new(.075,0,.1,0)
		})
	else
		tw(Main,.25,{
			Size=normalSize,
			Position=UDim2.new(.5,-200,.5,-150)
		})
	end
end)

Close.Activated:Connect(function()
	G:Destroy()
end)

local listening=false

Key.Activated:Connect(function()
	if listening then return end

	listening=true
	Key.Text="..."

	local c

	c=UIS.InputBegan:Connect(function(i,gp)
		if gp then return end

		if i.UserInputType==Enum.UserInputType.Keyboard then
			Key.Text=i.KeyCode.Name
			listening=false
			c:Disconnect()
		end
	end)
end)

local dragging=false
local dragStart
local startPos

Top.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
		dragging=true
		dragStart=i.Position
		startPos=Main.Position
	end
end)

UIS.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
		dragging=false
	end
end)

UIS.InputChanged:Connect(function(i)
	if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
		local d=i.Position-dragStart

		Main.Position=UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset+d.X,
			startPos.Y.Scale,
			startPos.Y.Offset+d.Y
		)
	end
end)

L.MainPage=MainPage
L.SettingsPage=SettingsPage

return L

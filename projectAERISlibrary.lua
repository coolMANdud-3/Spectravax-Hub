local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")

local Player=Players.LocalPlayer
local GUI=Instance.new("ScreenGui")
GUI.ResetOnSpawn=false
GUI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
GUI.Parent=Player:WaitForChild("PlayerGui")

local UI={}

local Themes={
Ocean={8,20,32,16,38,55,0,170,255,240,250,255,145,185,205},
Purple={22,12,32,40,20,55,175,80,255,250,240,255,185,155,205},
Emerald={7,25,17,14,48,32,35,215,125,235,255,245,145,190,165},
Crimson={30,8,11,52,15,20,255,55,65,255,240,240,200,150,155},
Sunset={35,17,8,58,29,14,255,125,35,255,245,230,205,170,140},
Pink={32,9,22,55,17,38,255,75,165,255,240,250,200,150,180},
Cyan={6,25,28,12,48,52,25,215,225,235,255,255,145,195,200},
Gold={28,23,6,55,45,12,255,205,45,255,250,225,200,180,120},
Ice={12,22,32,22,42,57,125,215,255,238,250,255,155,190,205},
Midnight={9,9,9,19,19,19,255,255,255,255,255,255,155,155,155}
}

local ThemeObjects={}

local function C(r,g,b)
	return Color3.fromRGB(r,g,b)
end

local function Mark(o,t)
	o:SetAttribute("YTheme",t)
	table.insert(ThemeObjects,o)
	return o
end

local function N(c,p)
	local o=Instance.new(c)
	for k,v in pairs(p or {}) do
		o[k]=v
	end
	return o
end

local W=N("Frame",{
	Name="Window",
	Size=UDim2.new(0.584,0,0.857,0),
	Position=UDim2.new(0.195,0,0.074,0),
	BackgroundColor3=C(19,19,19),
	BorderSizePixel=0,
	ClipsDescendants=true,
	Parent=GUI
})
Mark(W,"M")

N("UICorner",{CornerRadius=UDim.new(0,14),Parent=W})

N("UIShadow",{
	BlurRadius=UDim.new(0,18),
	Color=Color3.new(0,0,0),
	Transparency=.35,
	Offset=UDim2.fromOffset(0,5),
	Spread=UDim2.fromOffset(2,2),
	Parent=W
})

local Top=N("Frame",{
	Size=UDim2.new(1,0,0,50),
	BackgroundTransparency=1,
	Parent=W
})

local Title=N("TextLabel",{
	Size=UDim2.new(1,-150,0,27),
	Position=UDim2.fromOffset(16,6),
	BackgroundTransparency=1,
	Text="Project Aeris",
	Font=Enum.Font.GothamBold,
	TextSize=18,
	TextColor3=C(255,255,255),
	TextXAlignment=Enum.TextXAlignment.Left,
	Parent=Top
})
Mark(Title,"T")

local Sub=N("TextLabel",{
	Size=UDim2.new(1,-150,0,18),
	Position=UDim2.fromOffset(17,28),
	BackgroundTransparency=1,
	Text="First Release",
	Font=Enum.Font.Gotham,
	TextSize=10,
	TextColor3=C(155,155,155),
	TextXAlignment=Enum.TextXAlignment.Left,
	Parent=Top
})
Mark(Sub,"S")

local function TB(text,x)
	local b=N("TextButton",{
		Size=UDim2.fromOffset(32,32),
		Position=UDim2.new(1,x,0,9),
		BackgroundColor3=C(30,30,30),
		Text=text,
		Font=Enum.Font.GothamBold,
		TextSize=16,
		TextColor3=C(220,220,220),
		AutoButtonColor=false,
		Parent=Top
	})
	N("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
	Mark(b,"P")
	return b
end

local Min=TB("−",-112)
local Max=TB("□",-74)
local Close=TB("×",-36)

local Tabs=N("ScrollingFrame",{
	Size=UDim2.new(1,-14,0,38),
	Position=UDim2.fromOffset(7,55),
	BackgroundTransparency=1,
	BorderSizePixel=0,
	ScrollBarThickness=2,
	ScrollingDirection=Enum.ScrollingDirection.X,
	AutomaticCanvasSize=Enum.AutomaticSize.X,
	CanvasSize=UDim2.new(),
	Parent=W
})

N("UIListLayout",{
	FillDirection=Enum.FillDirection.Horizontal,
	Padding=UDim.new(0,5),
	SortOrder=Enum.SortOrder.LayoutOrder,
	Parent=Tabs
})

local Pages=N("Frame",{
	Size=UDim2.new(1,-24,1,-108),
	Position=UDim2.fromOffset(12,97),
	BackgroundTransparency=1,
	Parent=W
})

local function ButtonBase(parent,text,h)
	local b=N("TextButton",{
		Size=UDim2.new(1,0,0,h or 36),
		BackgroundColor3=C(30,30,30),
		Text=text or "",
		Font=Enum.Font.GothamMedium,
		TextSize=12,
		TextColor3=C(230,230,230),
		AutoButtonColor=false,
		Parent=parent
	})
	N("UICorner",{CornerRadius=UDim.new(0,9),Parent=b})
	Mark(b,"P")
	return b
end

local function Layout(parent,pad)
	return N("UIListLayout",{
		Padding=UDim.new(0,pad or 6),
		SortOrder=Enum.SortOrder.LayoutOrder,
		Parent=parent
	})
end

local TabsData={}
local CurrentTab

function UI:CreateTab(name)
	local tab={}

	local page=N("ScrollingFrame",{
		Name=name.."Page",
		Size=UDim2.new(1,0,1,0),
		BackgroundTransparency=1,
		BorderSizePixel=0,
		ScrollBarThickness=3,
		ScrollingDirection=Enum.ScrollingDirection.Y,
		AutomaticCanvasSize=Enum.AutomaticSize.Y,
		CanvasSize=UDim2.new(),
		Visible=false,
		Parent=Pages
	})

	Layout(page,7)

	local tb=ButtonBase(Tabs,name,34)
	tb.Size=UDim2.fromOffset(math.max(75,#name*8+25),34)

	tb.MouseButton1Click:Connect(function()
		for _,v in pairs(TabsData) do
			v.Page.Visible=false
		end
		page.Visible=true
		CurrentTab=tab
	end)

	table.insert(TabsData,{Page=page,Tab=tab})

	if not CurrentTab then
		page.Visible=true
		CurrentTab=tab
	end

	function tab:CreateHeader(text)
		local h=N("TextLabel",{
			Size=UDim2.new(1,0,0,30),
			BackgroundTransparency=1,
			Text=text,
			Font=Enum.Font.GothamBold,
			TextSize=16,
			TextColor3=C(255,255,255),
			TextXAlignment=Enum.TextXAlignment.Left,
			Parent=page
		})
		Mark(h,"T")
		return h
	end

	function tab:CreateSection(text)
		local s=N("TextLabel",{
			Size=UDim2.new(1,0,0,22),
			BackgroundTransparency=1,
			Text=text,
			Font=Enum.Font.GothamSemibold,
			TextSize=11,
			TextColor3=C(155,155,155),
			TextXAlignment=Enum.TextXAlignment.Left,
			Parent=page
		})
		Mark(s,"S")
		return s
	end

	function tab:CreateLabel(text)
		local l=N("TextLabel",{
			Size=UDim2.new(1,0,0,32),
			BackgroundTransparency=1,
			Text=text,
			Font=Enum.Font.Gotham,
			TextSize=12,
			TextColor3=C(220,220,220),
			TextWrapped=true,
			TextXAlignment=Enum.TextXAlignment.Left,
			Parent=page
		})
		Mark(l,"T")

		return {
			SetText=function(_,v)
				l.Text=tostring(v)
			end,
			SetVisible=function(_,v)
				l.Visible=v
			end
		}
	end

	function tab:CreateParagraph(o)
		local text=type(o)=="table" and (o.Text or "") or tostring(o or "")

		local l=N("TextLabel",{
			Size=UDim2.new(1,0,0,60),
			BackgroundColor3=C(25,25,25),
			BorderSizePixel=0,
			Text=text,
			Font=Enum.Font.Gotham,
			TextSize=11,
			TextColor3=C(210,210,210),
			TextWrapped=true,
			TextXAlignment=Enum.TextXAlignment.Left,
			TextYAlignment=Enum.TextYAlignment.Top,
			Parent=page
		})

		N("UIPadding",{
			PaddingLeft=UDim.new(0,10),
			PaddingRight=UDim.new(0,10),
			PaddingTop=UDim.new(0,8),
			PaddingBottom=UDim.new(0,8),
			Parent=l
		})

		N("UICorner",{CornerRadius=UDim.new(0,9),Parent=l})
		Mark(l,"P")

		return {
			SetText=function(_,v)
				l.Text=tostring(v)
			end,
			SetVisible=function(_,v)
				l.Visible=v
			end
		}
	end

	function tab:CreateDivider()
		local d=N("Frame",{
			Size=UDim2.new(1,0,0,1),
			BackgroundColor3=C(55,55,55),
			BorderSizePixel=0,
			Parent=page
		})
		Mark(d,"P")

		return {
			SetVisible=function(_,v)
				d.Visible=v
			end
		}
	end

	function tab:CreateButton(o)
		local b=ButtonBase(page,o.Text or "Button",36)

		b.MouseButton1Click:Connect(function()
			if o.Callback then
				o.Callback()
			end
		end)

		return {
			SetText=function(_,v)
				b.Text=tostring(v)
			end,
			SetVisible=function(_,v)
				b.Visible=v
			end
		}
	end

	function tab:CreateToggle(o)
		local state=o.Default==true

		local b=ButtonBase(
			page,
			(o.Text or "Toggle").." : "..(state and "ON" or "OFF"),
			36
		)

		local function refresh()
			b.Text=(o.Text or "Toggle").." : "..(state and "ON" or "OFF")
		end

		b.MouseButton1Click:Connect(function()
			state=not state
			refresh()

			if o.Callback then
				o.Callback(state)
			end
		end)

		return {
			SetValue=function(_,v)
				state=v==true
				refresh()

				if o.Callback then
					o.Callback(state)
				end
			end,
			GetValue=function()
				return state
			end,
			SetText=function(_,v)
				o.Text=tostring(v)
				refresh()
			end,
			SetVisible=function(_,v)
				b.Visible=v
			end
		}
	end

	function tab:CreateTextBox(o)
		local box=N("TextBox",{
			Size=UDim2.new(1,0,0,36),
			BackgroundColor3=C(30,30,30),
			BorderSizePixel=0,
			Text=o.Default or "",
			PlaceholderText=o.Placeholder or o.Text or "Enter text...",
			Font=Enum.Font.Gotham,
			TextSize=12,
			TextColor3=C(230,230,230),
			PlaceholderColor3=C(130,130,130),
			ClearTextOnFocus=false,
			TextXAlignment=Enum.TextXAlignment.Left,
			Parent=page
		})

		N("UIPadding",{
			PaddingLeft=UDim.new(0,10),
			PaddingRight=UDim.new(0,10),
			Parent=box
		})

		N("UICorner",{CornerRadius=UDim.new(0,9),Parent=box})
		Mark(box,"P")

		box.FocusLost:Connect(function()
			if o.Callback then
				o.Callback(box.Text)
			end
		end)

		return {
			SetText=function(_,v)
				box.Text=tostring(v)
			end,
			SetValue=function(_,v)
				box.Text=tostring(v)
			end,
			GetValue=function()
				return box.Text
			end,
			SetVisible=function(_,v)
				box.Visible=v
			end
		}
	end

	function tab:CreateSlider(o)
		local value=o.Default or o.Min or 0
		local min=o.Min or 0
		local max=o.Max or 100

		local holder=N("Frame",{
			Size=UDim2.new(1,0,0,48),
			BackgroundTransparency=1,
			Parent=page
		})

		local label=N("TextLabel",{
			Size=UDim2.new(1,0,0,20),
			BackgroundTransparency=1,
			Text=(o.Text or "Slider")..": "..tostring(value),
			Font=Enum.Font.GothamMedium,
			TextSize=11,
			TextColor3=C(220,220,220),
			TextXAlignment=Enum.TextXAlignment.Left,
			Parent=holder
		})
		Mark(label,"T")

		local bar=ButtonBase(holder,"",14)
		bar.Position=UDim2.fromOffset(0,25)
		bar.BackgroundColor3=C(38,38,38)

		local fill=N("Frame",{
			Size=UDim2.new((value-min)/(max-min),0,1,0),
			BackgroundColor3=C(120,120,120),
			BorderSizePixel=0,
			Parent=bar
		})

		N("UICorner",{CornerRadius=UDim.new(0,7),Parent=fill})
		Mark(fill,"A")

		local dragging=false

		local function set(v)
			value=math.clamp(v,min,max)

			local a=(value-min)/(max-min)
			fill.Size=UDim2.new(a,0,1,0)
			label.Text=(o.Text or "Slider")..": "..math.floor(value)

			if o.Callback then
				o.Callback(value)
			end
		end

		bar.InputBegan:Connect(function(i)
			if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
				dragging=true
				set(min+(i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X*(max-min))
			end
		end)

		UIS.InputChanged:Connect(function(i)
			if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
				set(min+(i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X*(max-min))
			end
		end)

		UIS.InputEnded:Connect(function(i)
			if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
				dragging=false
			end
		end)

		return {
			SetValue=function(_,v)
				set(v)
			end,
			GetValue=function()
				return value
			end,
			SetText=function(_,v)
				o.Text=tostring(v)
				label.Text=o.Text..": "..math.floor(value)
			end,
			SetVisible=function(_,v)
				holder.Visible=v
			end
		}
	end

	function tab:CreateDropdown(o)
		local open=false
		local value=o.Default or o.Options[1]

		local b=ButtonBase(
			page,
			(o.Text or "Dropdown")..": "..tostring(value),
			36
		)

		local pop=N("Frame",{
			Size=UDim2.new(1,0,0,0),
			BackgroundColor3=C(25,25,25),
			BorderSizePixel=0,
			Visible=false,
			ZIndex=20,
			Parent=page
		})

		N("UICorner",{CornerRadius=UDim.new(0,9),Parent=pop})
		Layout(pop,4)

		local function rebuild()
			for _,v in pairs(pop:GetChildren()) do
				if v:IsA("TextButton") then
					v:Destroy()
				end
			end

			for _,v in ipairs(o.Options or {}) do
				local x=ButtonBase(pop,tostring(v),30)

				x.Size=UDim2.new(1,-8,0,30)
				x.Position=UDim2.fromOffset(4,0)
				x.ZIndex=21

				x.MouseButton1Click:Connect(function()
					value=v
					b.Text=(o.Text or "Dropdown")..": "..tostring(value)
					open=false
					pop.Visible=false

					if o.Callback then
						o.Callback(value)
					end
				end)
			end

			pop.Size=UDim2.new(1,0,0,#(o.Options or {})*34+6)
		end

		local function position()
			pop.Position=UDim2.new(
				0,
				b.Position.X.Offset,
				0,
				b.Position.Y.Offset+b.AbsoluteSize.Y+4
			)
		end

		b.MouseButton1Click:Connect(function()
			open=not open

			if open then
				rebuild()
				position()
				pop.Visible=true
			else
				pop.Visible=false
			end
		end)

		return {
			SetValue=function(_,v)
				value=v
				b.Text=(o.Text or "Dropdown")..": "..tostring(value)
			end,
			GetValue=function()
				return value
			end,
			SetText=function(_,v)
				o.Text=tostring(v)
				b.Text=o.Text..": "..tostring(value)
			end,
			SetVisible=function(_,v)
				b.Visible=v

				if not v then
					pop.Visible=false
				end
			end
		}
	end

	function tab:CreateColorPicker(o)
		local value=o.Default or Color3.new(1,1,1)
		local open=false

		local holder=N("Frame",{
			Size=UDim2.new(1,0,0,36),
			BackgroundTransparency=1,
			Parent=page
		})

		local main=ButtonBase(holder,o.Text or "Color",36)
		main.Size=UDim2.new(1,-48,0,36)

		local preview=N("Frame",{
			Size=UDim2.fromOffset(36,36),
			Position=UDim2.new(1,-36,0,0),
			BackgroundColor3=value,
			BorderSizePixel=0,
			Parent=holder
		})

		N("UICorner",{CornerRadius=UDim.new(0,9),Parent=preview})

		local panel=N("Frame",{
			Size=UDim2.new(1,0,0,0),
			BackgroundColor3=C(24,24,24),
			BorderSizePixel=0,
			Visible=false,
			ClipsDescendants=true,
			Parent=page
		})

		N("UICorner",{CornerRadius=UDim.new(0,10),Parent=panel})
		Mark(panel,"P")

		local rgb={value.R*255,value.G*255,value.B*255}
		local sliders={}

		local function update()
			value=Color3.fromRGB(
				math.floor(rgb[1]+.5),
				math.floor(rgb[2]+.5),
				math.floor(rgb[3]+.5)
			)

			preview.BackgroundColor3=value

			if o.Callback then
				o.Callback(value)
			end
		end

		local function makeRGB(index,name)
			local y=8+(index-1)*40

			local label=N("TextLabel",{
				Size=UDim2.new(1,0,0,18),
				Position=UDim2.fromOffset(8,y),
				BackgroundTransparency=1,
				Text=name..": "..math.floor(rgb[index]),
				Font=Enum.Font.GothamMedium,
				TextSize=10,
				TextColor3=C(220,220,220),
				TextXAlignment=Enum.TextXAlignment.Left,
				Parent=panel
			})
			Mark(label,"T")

			local bar=ButtonBase(panel,"",12)
			bar.Size=UDim2.new(1,-16,0,12)
			bar.Position=UDim2.fromOffset(8,y+21)
			bar.BackgroundColor3=C(42,42,42)

			local fill=N("Frame",{
				Size=UDim2.new(rgb[index]/255,0,1,0),
				BackgroundColor3=C(150,150,150),
				BorderSizePixel=0,
				Parent=bar
			})

			N("UICorner",{CornerRadius=UDim.new(0,6),Parent=fill})
			Mark(fill,"A")

			local dragging=false

			local function set(v)
				rgb[index]=math.clamp(v,0,255)
				fill.Size=UDim2.new(rgb[index]/255,0,1,0)
				label.Text=name..": "..math.floor(rgb[index])
				update()
			end

			bar.InputBegan:Connect(function(i)
				if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
					dragging=true
					set((i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X*255)
				end
			end)

			UIS.InputChanged:Connect(function(i)
				if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
					set((i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X*255)
				end
			end)

			UIS.InputEnded:Connect(function(i)
				if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
					dragging=false
				end
			end)

			sliders[index]={Set=set,Fill=fill,Label=label}
		end

		makeRGB(1,"Red")
		makeRGB(2,"Green")
		makeRGB(3,"Blue")

		local function refresh()
			rgb={
				value.R*255,
				value.G*255,
				value.B*255
			}

			for i=1,3 do
				sliders[i].Fill.Size=UDim2.new(rgb[i]/255,0,1,0)
				sliders[i].Label.Text=({"Red","Green","Blue"})[i]..": "..math.floor(rgb[i])
			end

			preview.BackgroundColor3=value
		end

		local function setOpen(state)
			open=state
			panel.Visible=open

			if open then
				panel.Size=UDim2.new(1,0,0,136)
				panel.Position=UDim2.new(
					0,
					0,
					0,
					main.Position.Y.Offset+main.AbsoluteSize.Y+5
				)
				refresh()
			else
				panel.Size=UDim2.new(1,0,0,0)
			end
		end

		main.MouseButton1Click:Connect(function()
			setOpen(not open)
		end)

		return {
			SetValue=function(_,v)
				if typeof(v)=="Color3" then
					value=v
					refresh()
					update()
				end
			end,
			GetValue=function()
				return value
			end,
			SetText=function(_,v)
				o.Text=tostring(v)
				main.Text=o.Text
			end,
			SetVisible=function(_,v)
				holder.Visible=v
				if not v then
					setOpen(false)
				end
			end
		}
	end

	function tab:CreateKeybind(o)
		local key=o.Default or Enum.KeyCode.RightShift

		local b=ButtonBase(
			page,
			(o.Text or "Keybind")..": "..key.Name,
			36
		)

		b.MouseButton1Click:Connect(function()
			b.Text=(o.Text or "Keybind")..": Press Key"

			local c

			c=UIS.InputBegan:Connect(function(i,g)
				if not g and i.UserInputType==Enum.UserInputType.Keyboard then
					key=i.KeyCode
					b.Text=(o.Text or "Keybind")..": "..key.Name
					c:Disconnect()

					if o.Callback then
						o.Callback(key)
					end
				end
			end)
		end)

		return {
			SetValue=function(_,v)
				key=v
				b.Text=(o.Text or "Keybind")..": "..key.Name
			end,
			GetValue=function()
				return key
			end,
			SetText=function(_,v)
				o.Text=tostring(v)
				b.Text=o.Text..": "..key.Name
			end,
			SetVisible=function(_,v)
				b.Visible=v
			end
		}
	end

	return tab
end

function UI:Notify(text)
	local n=N("TextLabel",{
		Size=UDim2.fromOffset(260,42),
		Position=UDim2.new(1,20,1,-55),
		BackgroundColor3=C(25,25,25),
		Text=tostring(text),
		Font=Enum.Font.GothamMedium,
		TextSize=12,
		TextColor3=C(240,240,240),
		TextWrapped=true,
		Parent=GUI
	})

	N("UICorner",{CornerRadius=UDim.new(0,10),Parent=n})
	Mark(n,"P")

	TS:Create(n,TweenInfo.new(.25,Enum.EasingStyle.Quint),{
		Position=UDim2.new(1,-275,1,-55)
	}):Play()

	task.delay(2,function()
		TS:Create(n,TweenInfo.new(.25),{
			Position=UDim2.new(1,20,1,-55)
		}):Play()

		task.wait(.3)
		n:Destroy()
	end)
end

function UI:ToggleUI()
	GUI.Enabled=not GUI.Enabled
end

function UI:SetVisible(v)
	GUI.Enabled=v==true
end

function UI:SetTheme(name)
	local t=Themes[name]

	if not t then
		return
	end

	for _,o in ipairs(ThemeObjects) do
		if o and o.Parent then
			local k=o:GetAttribute("YTheme")

			if k=="M" then
				o.BackgroundColor3=C(t[1],t[2],t[3])
			elseif k=="P" then
				o.BackgroundColor3=C(t[4],t[5],t[6])
			elseif k=="A" then
				o.BackgroundColor3=C(t[7],t[8],t[9])
			elseif k=="T" then
				o.TextColor3=C(t[10],t[11],t[12])
			elseif k=="S" then
				o.TextColor3=C(t[13],t[14],t[15])
			end
		end
	end
end

local dragging=false
local dragStart
local startPos

Top.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
		dragging=true
		dragStart=i.Position
		startPos=W.Position
	end
end)

UIS.InputChanged:Connect(function(i)
	if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
		local d=i.Position-dragStart

		W.Position=UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset+d.X,
			startPos.Y.Scale,
			startPos.Y.Offset+d.Y
		)
	end
end)

UIS.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
		dragging=false
	end
end)

local minimized=false
local maximized=false

Min.MouseButton1Click:Connect(function()
	minimized=not minimized

	Tabs.Visible=not minimized
	Pages.Visible=not minimized

	if minimized then
		TS:Create(W,TweenInfo.new(.2),{
			Size=UDim2.fromOffset(340,50)
		}):Play()
	else
		TS:Create(W,TweenInfo.new(.2),{
			Size=UDim2.new(0.584,0,0.857,0)
		}):Play()
	end
end)

Max.MouseButton1Click:Connect(function()
	if minimized then
		minimized=false
		Tabs.Visible=true
		Pages.Visible=true
	end

	maximized=not maximized

	if maximized then
		TS:Create(W,TweenInfo.new(.25,Enum.EasingStyle.Quint),{
			Size=UDim2.new(.9,0,.82,0),
			Position=UDim2.new(.05,0,.08,0)
		}):Play()
	else
		TS:Create(W,TweenInfo.new(.25,Enum.EasingStyle.Quint),{
			Size=UDim2.new(0.584,0,0.857,0),
			Position=UDim2.new(0.195,0,0.074,0)
		}):Play()
	end
end)

Close.MouseButton1Click:Connect(function()
	GUI.Enabled=fal

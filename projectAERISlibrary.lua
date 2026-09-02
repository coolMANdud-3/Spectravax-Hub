--[[
    COMPACT MODERN UI LIBRARY
    Under 300 lines
    Raw loadstring compatible
]]

local P=game:GetService("Players")
local U=game:GetService("UserInputService")
local T=game:GetService("TweenService")

local Player=P.LocalPlayer
local PG=Player:WaitForChild("PlayerGui")
local L={Tabs={},Theme={},Config={},_n=0}

L.Config={
    Name="YourHubName",
    LoadingTitle="Loading",
    LoadingSubtitle="Preparing interface",
    LoadingDescription="Please wait...",
    MainSize=UDim2.fromOffset(400,300),
    LoadingSize=UDim2.fromOffset(500,200),
    TweenSpeed=.35
}

L.Theme={
    Background=Color3.fromRGB(22,22,25),
    Surface=Color3.fromRGB(28,28,32),
    Surface2=Color3.fromRGB(35,35,40),
    Element=Color3.fromRGB(40,40,46),
    Hover=Color3.fromRGB(50,50,57),
    Border=Color3.fromRGB(60,60,68),
    Text=Color3.fromRGB(242,242,246),
    SubText=Color3.fromRGB(160,160,170),
    Accent=Color3.fromRGB(225,225,230),
    AccentText=Color3.fromRGB(20,20,22),
    Success=Color3.fromRGB(90,200,120),
    Danger=Color3.fromRGB(225,80,80)
}

local function N(c,p,par)
    local o=Instance.new(c)
    for k,v in pairs(p or {}) do pcall(function() o[k]=v end) end
    o.Parent=par
    return o
end

local function C(o,r)
    local x=Instance.new("UICorner")
    x.CornerRadius=UDim.new(0,r or 8)
    x.Parent=o
end

local function S(o,col)
    local x=Instance.new("UIStroke")
    x.Color=col or L.Theme.Border
    x.Thickness=1
    x.Parent=o
    return x
end

local function Pad(o,n)
    N("UIPadding",{
        PaddingLeft=UDim.new(0,n or 8),
        PaddingRight=UDim.new(0,n or 8),
        PaddingTop=UDim.new(0,n or 8),
        PaddingBottom=UDim.new(0,n or 8)
    },o)
end

local function TW(o,props,time)
    T:Create(o,TweenInfo.new(time or L.Config.TweenSpeed,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),props):Play()
end

local Old=PG:FindFirstChild("ModernLibrary")
if Old then Old:Destroy() end

local GUI=N("ScreenGui",{
    Name="ModernLibrary",
    ResetOnSpawn=false,
    IgnoreGuiInset=true
},PG)

L.ScreenGui=GUI

-- LOADING

local Load=N("Frame",{
    AnchorPoint=Vector2.new(.5,.5),
    Position=UDim2.fromScale(.5,.5),
    Size=UDim2.fromOffset(45,30),
    BackgroundColor3=Color3.new(0,0,0),
    BorderSizePixel=0
},GUI)
C(Load,14)
S(Load,Color3.fromRGB(45,45,45))

local LT=N("TextLabel",{
    BackgroundTransparency=1,
    Position=UDim2.fromOffset(30,30),
    Size=UDim2.new(1,-60,0,35),
    Text=L.Config.Name,
    Font=Enum.Font.GothamBold,
    TextSize=25,
    TextColor3=L.Theme.Text,
    TextXAlignment=Enum.TextXAlignment.Left
},Load)

local LS=N("TextLabel",{
    BackgroundTransparency=1,
    Position=UDim2.fromOffset(30,72),
    Size=UDim2.new(1,-60,0,25),
    Text=L.Config.LoadingTitle,
    Font=Enum.Font.GothamMedium,
    TextSize=17,
    TextColor3=L.Theme.Text,
    TextXAlignment=Enum.TextXAlignment.Left
},Load)

local LD=N("TextLabel",{
    BackgroundTransparency=1,
    Position=UDim2.fromOffset(30,101),
    Size=UDim2.new(1,-60,0,22),
    Text=L.Config.LoadingSubtitle,
    Font=Enum.Font.Gotham,
    TextSize=12,
    TextColor3=L.Theme.SubText,
    TextXAlignment=Enum.TextXAlignment.Left
},Load)

local LDesc=N("TextLabel",{
    BackgroundTransparency=1,
    Position=UDim2.fromOffset(30,127),
    Size=UDim2.new(1,-60,0,35),
    Text=L.Config.LoadingDescription,
    Font=Enum.Font.Gotham,
    TextSize=11,
    TextWrapped=true,
    TextColor3=Color3.fromRGB(110,110,120),
    TextXAlignment=Enum.TextXAlignment.Left
},Load)

TW(Load,{Size=L.Config.LoadingSize},.5)
task.wait(1.5)

-- MAIN

local Main=N("Frame",{
    AnchorPoint=Vector2.new(.5,.5),
    Position=UDim2.fromScale(.5,.5),
    Size=UDim2.fromOffset(45,30),
    BackgroundColor3=L.Theme.Background,
    BorderSizePixel=0,
    Visible=false,
    ClipsDescendants=true
},GUI)
C(Main,14)
local MainStroke=S(Main)

local Top=N("Frame",{
    Position=UDim2.fromOffset(1,1),
    Size=UDim2.new(1,-2,0,43),
    BackgroundColor3=L.Theme.Surface,
    BorderSizePixel=0
},Main)
C(Top,13)

local Title=N("TextLabel",{
    BackgroundTransparency=1,
    Position=UDim2.fromOffset(17,0),
    Size=UDim2.new(1,-125,1,0),
    Text=L.Config.Name,
    Font=Enum.Font.GothamBold,
    TextSize=14,
    TextColor3=L.Theme.Text,
    TextXAlignment=Enum.TextXAlignment.Left
},Top)

local Controls=N("Frame",{
    BackgroundTransparency=1,
    AnchorPoint=Vector2.new(1,.5),
    Position=UDim2.new(1,-12,.5,0),
    Size=UDim2.fromOffset(78,20)
},Top)

N("UIListLayout",{
    FillDirection=Enum.FillDirection.Horizontal,
    HorizontalAlignment=Enum.HorizontalAlignment.Right,
    VerticalAlignment=Enum.VerticalAlignment.Center,
    Padding=UDim.new(0,5)
},Controls)

local function Control(name,col)
    local b=N("TextButton",{
        Name=name,
        Size=UDim2.fromOffset(18,18),
        BackgroundColor3=col,
        Text="",
        AutoButtonColor=false
    },Controls)
    C(b,50)
    return b
end

local Close=Control("Close",Color3.fromRGB(235,82,82))
local Min=Control("Minimize",Color3.fromRGB(238,194,72))
local Max=Control("Maximize",Color3.fromRGB(82,200,112))

local Body=N("Frame",{
    Position=UDim2.fromOffset(1,44),
    Size=UDim2.new(1,-2,1,-45),
    BackgroundTransparency=1
},Main)

local Side=N("Frame",{
    Size=UDim2.new(0,108,1,0),
    BackgroundColor3=L.Theme.Surface,
    BorderSizePixel=0
},Body)
Pad(Side,7)

N("UIListLayout",{
    SortOrder=Enum.SortOrder.LayoutOrder,
    Padding=UDim.new(0,3)
},Side)

local Content=N("Frame",{
    Position=UDim2.new(0,108,0,0),
    Size=UDim2.new(1,-108,1,0),
    BackgroundColor3=L.Theme.Background,
    BorderSizePixel=0
},Body)

-- DRAG

local drag=false
local ds,sp

Top.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        drag=true
        ds=i.Position
        sp=Main.Position
    end
end)

U.InputChanged:Connect(function(i)
    if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-ds
        Main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
    end
end)

U.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        drag=false
    end
end)

-- WINDOW

local normal=L.Config.MainSize
local minimized=false
local maximized=false

Max.Activated:Connect(function()
    maximized=not maximized
    if maximized then
        normal=Main.Size
        local v=workspace.CurrentCamera.ViewportSize
        TW(Main,{
            Size=UDim2.fromOffset(math.min(v.X-20,700),math.min(v.Y-20,600)),
            Position=UDim2.fromScale(.5,.5)
        })
    else
        TW(Main,{Size=normal})
    end
end)

Min.Activated:Connect(function()
    minimized=not minimized
    TW(Main,{
        Size=minimized and UDim2.new(Main.Size.X.Scale,Main.Size.X.Offset,0,44)
        or normal
    })
end)

Close.Activated:Connect(function()
    GUI.Enabled=false
end)

function L:ToggleUI()
    GUI.Enabled=not GUI.Enabled
end

function L:Show()
    GUI.Enabled=true
end

function L:Hide()
    GUI.Enabled=false
end

function L:Destroy()
    GUI:Destroy()
end

-- TABS

local Current
local function Page(tab)
    local p=N("ScrollingFrame",{
        Size=UDim2.fromScale(1,1),
        BackgroundTransparency=1,
        BorderSizePixel=0,
        ScrollBarThickness=4,
        ScrollBarImageColor3=Color3.fromRGB(100,100,105),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
        CanvasSize=UDim2.new(),
        Visible=false
    },Content)
    Pad(p,10)
    N("UIListLayout",{Padding=UDim.new(0,7)},p)
    return p
end

function L:AddTab(name)
    L._n+=1
    name=tostring(name or ("Tab "..L._n))

    local b=N("TextButton",{
        Size=UDim2.new(1,0,0,34),
        BackgroundColor3=L.Theme.Surface2,
        BackgroundTransparency=1,
        Text="",
        LayoutOrder=L._n,
        AutoButtonColor=false
    },Side)
    C(b,7)

    local txt=N("TextLabel",{
        BackgroundTransparency=1,
        Position=UDim2.fromOffset(10,0),
        Size=UDim2.new(1,-28,1,0),
        Text=name,
        Font=Enum.Font.GothamMedium,
        TextSize=12,
        TextColor3=L.Theme.SubText,
        TextXAlignment=Enum.TextXAlignment.Left
    },b)

    local ind=N("Frame",{
        AnchorPoint=Vector2.new(1,.5),
        Position=UDim2.new(1,-5,.5,0),
        Size=UDim2.fromOffset(3,20),
        BackgroundColor3=L.Theme.Accent,
        Visible=false
    },b)
    C(ind,4)

    local tab={Button=b,Page=Page(),Text=txt,Indicator=ind,Order=0}

    function tab:Select()
        for _,x in pairs(L.Tabs) do
            x.Page.Visible=false
            x.Indicator.Visible=false
            x.Button.BackgroundTransparency=1
            x.Text.TextColor3=L.Theme.SubText
        end
        self.Page.Visible=true
        self.Indicator.Visible=true
        self.Button.BackgroundTransparency=0
        self.Text.TextColor3=L.Theme.Text
        Current=self
    end

    b.Activated:Connect(function() tab:Select() end)
    table.insert(L.Tabs,tab)

    if not Current then tab:Select() end
    return tab
end

local function Holder(t,h)
    t.Order+=1
    local x=N("Frame",{
        Size=UDim2.new(1,0,0,h or 38),
        BackgroundTransparency=1,
        LayoutOrder=t.Order
    },t.Page)
    return x
end

-- LABELS

function L:AddHeader(t,text)
    local h=Holder(t,32)
    N("TextLabel",{
        BackgroundTransparency=1,
        Size=UDim2.fromScale(1,1),
        Text=text,
        Font=Enum.Font.GothamBold,
        TextSize=17,
        TextColor3=L.Theme.Text,
        TextXAlignment=Enum.TextXAlignment.Left
    },h)
end

function L:AddSection(t,text)
    local h=Holder(t,26)
    N("TextLabel",{
        BackgroundTransparency=1,
        Size=UDim2.fromScale(1,1),
        Text=text,
        Font=Enum.Font.GothamBold,
        TextSize=12,
        TextColor3=L.Theme.SubText,
        TextXAlignment=Enum.TextXAlignment.Left
    },h)
end

function L:AddLabel(t,text)
    local h=Holder(t,30)
    N("TextLabel",{
        BackgroundTransparency=1,
        Size=UDim2.fromScale(1,1),
        Text=text,
        Font=Enum.Font.Gotham,
        TextSize=12,
        TextColor3=L.Theme.Text,
        TextXAlignment=Enum.TextXAlignment.Left
    },h)
end

function L:AddParagraph(t,title,text)
    local h=Holder(t,55)
    N("TextLabel",{
        BackgroundTransparency=1,
        Size=UDim2.new(1,0,0,20),
        Text=title,
        Font=Enum.Font.GothamBold,
        TextSize=13,
        TextColor3=L.Theme.Text,
        TextXAlignment=Enum.TextXAlignment.Left
    },h)
    N("TextLabel",{
        BackgroundTransparency=1,
        Position=UDim2.fromOffset(0,20),
        Size=UDim2.new(1,0,0,35),
        Text=text,
        TextWrapped=true,
        Font=Enum.Font.Gotham,
        TextSize=11,
        TextColor3=L.Theme.SubText,
        TextXAlignment=Enum.TextXAlignment.Left
    },h)
end

function L:AddDivider(t)
    local h=Holder(t,8)
    N("Frame",{
        Position=UDim2.fromScale(0,.5),
        Size=UDim2.new(1,0,0,1),
        BackgroundColor3=L.Theme.Border
    },h)
end

-- BUTTON

function L:AddButton(t,text,callback)
    local h=Holder(t,38)
    local b=N("TextButton",{
        Size=UDim2.fromScale(1,1),
        BackgroundColor3=L.Theme.Element,
        Text=text,
        Font=Enum.Font.GothamMedium,
        TextSize=12,
        TextColor3=L.Theme.Text,
        AutoButtonColor=false
    },h)
    C(b,7)
    b.Activated:Connect(function()
        if typeof(callback)=="function" then
            task.spawn(callback)
        end
    end)
    return b
end

-- TOGGLE

function L:AddToggle(t,text,value,callback)
    local h=Holder(t,38)
    local b=N("TextButton",{
        Size=UDim2.fromScale(1,1),
        BackgroundColor3=L.Theme.Element,
        Text="",
        AutoButtonColor=false
    },h)
    C(b,7)

    N("TextLabel",{
        BackgroundTransparency=1,
        Position=UDim2.fromOffset(10,0),
        Size=UDim2.new(1,-55,1,0),
        Text=text,
        Font=Enum.Font.GothamMedium,
        TextSize=12,
        TextColor3=L.Theme.Text,
        TextXAlignment=Enum.TextXAlignment.Left
    },b)

    local box=N("Frame",{
        AnchorPoint=Vector2.new(1,.5),
        Position=UDim2.new(1,-10,.5,0),
        Size=UDim2.fromOffset(30,16),
        BackgroundColor3=Color3.fromRGB(65,65,70)
    },b)
    C(box,8)

    local knob=N("Frame",{
        AnchorPoint=Vector2.new(.5,.5),
        Position=UDim2.fromScale(.25,.5),
        Size=UDim2.fromOffset(12,12),
        BackgroundColor3=Color3.fromRGB(220,220,225)
    },box)
    C(knob,50)

    local function Set(v)
        value=v
        TW(knob,{Position=UDim2.fromScale(v and .75 or .25,.5)},.15)
        TW(box,{BackgroundColor3=v and L.Theme.Accent or Color3.fromRGB(65,65,70)},.15)
        if typeof(callback)=="function" then task.spawn(callback,v) end
    end

    b.Activated:Connect(function() Set(not value) end)
    Set(value)
    return {Set=Set}
end

-- SLIDER

function L:AddSlider(t,text,min,max,value,callback)
    local h=Holder(t,48)
    local lab=N("TextLabel",{
        BackgroundTransparency=1,
        Size=UDim2.new(1,0,0,20),
        Text=text..": "..tostring(value),
        Font=Enum.Font.GothamMedium,
        TextSize=12,
        TextColor3=L.Theme.Text,
        TextXAlignment=Enum.TextXAlignment.Left
    },h)

    local bar=N("Frame",{
        Position=UDim2.fromOffset(0,28),
        Size=UDim2.new(1,0,0,5),
        BackgroundColor3=L.Theme.Element
    },h)
    C(bar,5)

    local fill=N("Frame",{
        Size=UDim2.new((value-min)/(max-min),0,1,0),
        BackgroundColor3=L.Theme.Accent
    },bar)
    C(fill,5)

    local function Set(v)
        v=math.clamp(v,min,max)
        value=v
        fill.Size=UDim2.new((v-min)/(max-min),0,1,0)
        lab.Text=text..": "..math.floor(v)
        if typeof(callback)=="function" then task.spawn(callback,v) end
    end

    bar.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            local function move(x)
                Set(min+(max-min)*math.clamp((x-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1))
            end
            move(i.Position.X)
            local c
            c=U.InputChanged:Connect(function(x)
                if x.UserInputType==Enum.UserInputType.MouseMovement or x.UserInputType==Enum.UserInputType.Touch then move(x.Position.X) end
            end)
            U.InputEnded:Connect(function(x)
                if x.UserInputType==Enum.UserInputType.MouseButton1 or x.UserInputType==Enum.UserInputType.Touch then c:Disconnect() end
            end)
        end
    end)

    return {Set=Set}
end

-- DROPDOWN

function L:AddDropdown(t,text,options,callback)
    local h=Holder(t,38)
    local b=N("TextButton",{
        Size=UDim2.fromScale(1,1),
        BackgroundColor3=L.Theme.Element,
        Text=text,
        Font=Enum.Font.GothamMedium,
        TextSize=12,
        TextColor3=L.Theme.Text,
        AutoButtonColor=false
    },h)
    C(b,7)

    local list=N("Frame",{
        Position=UDim2.new(0,0,1,3),
        Size=UDim2.new(1,0,0,#options*28),
        BackgroundColor3=L.Theme.Surface2,
        Visible=false,
        ZIndex=20
    },b)
    C(list,7)

    N("UIListLayout",{Padding=UDim.new(0,2)},list)

    for _,option in ipairs(options) do
        local o=N("TextButton",{
            Size=UDim2.new(1,0,0,26),
            BackgroundTransparency=1,
            Text=tostring(option),
            Font=Enum.Font.Gotham,
            TextSize=11,
            TextColor3=L.Theme.Text,
            ZIndex=21
        },list)

        o.Activated:Connect(function()
            b.Text=text..": "..tostring(option)
            list.Visible=false
            if typeof(callback)=="function" then task.spawn(callback,option) end
        end)
    end

    b.Activated:Connect(function() list.Visible=not list.Visible end)
    return b
end

-- INPUT

function L:AddInput(t,text,placeholder,callback)
    local h=Holder(t,38)
    local box=N("TextBox",{
        Size=UDim2.fromScale(1,1),
        BackgroundColor3=L.Theme.Element,
        PlaceholderText=placeholder or "",
        Text="",
        Font=Enum.Font.Gotham,
        TextSize=12,
        TextColor3=L.Theme.Text,
        PlaceholderColor3=L.Theme.SubText,
        ClearTextOnFocus=false
    },h)
    C(box,7)
    Pad(box,10)
    box.FocusLost:Connect(function()
        if typeof(callback)=="function" then task.spawn(callback,box.Text) end
    end)
    return box
end

-- NOTIFY

function L:Notify(text)
    local n=N("TextLabel",{
        AnchorPoint=Vector2.new(1,1),
        Position=UDim2.new(1,-15,1,-15),
        Size=UDim2.fromOffset(250,42),
        BackgroundColor3=L.Theme.Surface2,
        Text=text,
        Font=Enum.Font.GothamMedium,
        TextSize=12,
        TextColor3=L.Theme.Text,
        ZIndex=100
    },GUI)
    C(n,8)
    S(n)
    TW(n,{Position=UDim2.new(1,-15,1,-65)})
    task.delay(3,function()
        TW(n,{Position=UDim2.new(1,270,1,-65)},.25)
        task.wait(.3)
        n:Destroy()
    end)
end

-- THEME

function L:SetTheme(theme)
    for k,v in pairs(theme or {}) do
        if L.Theme[k]~=nil then L.Theme[k]=v end
    end
end

-- FINISH LOADING

Main.Visible=true
TW(Main,{Size=L.Config.MainSize},.5)
TW(Load,{BackgroundTransparency=1},.35)
task.wait(.4)
Load:Destroy()

return L

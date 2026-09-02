--[[
    MODERN UI LIBRARY
    Full standalone version

    Main: 400 x 300
    Loading: 500 x 200
    No icons / no emojis
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Library = {}

Library.Config = {
    Name = "YourHubName",

    LoadingTitle = "Loading",
    LoadingSubtitle = "Preparing interface",
    LoadingDescription = "Please wait while the interface is initialized.",

    LoadingDelay = 2,

    StartSize = UDim2.fromOffset(45, 30),
    LoadingSize = UDim2.fromOffset(500, 200),
    MainSize = UDim2.fromOffset(400, 300),

    TweenSpeed = 0.35
}

Library.Theme = {
    Background = Color3.fromRGB(22, 22, 25),
    Surface = Color3.fromRGB(28, 28, 32),
    Surface2 = Color3.fromRGB(33, 33, 38),

    Element = Color3.fromRGB(38, 38, 44),
    ElementHover = Color3.fromRGB(47, 47, 54),

    Border = Color3.fromRGB(60, 60, 68),

    Text = Color3.fromRGB(242, 242, 246),
    SubText = Color3.fromRGB(160, 160, 170),

    Accent = Color3.fromRGB(225, 225, 230),
    AccentText = Color3.fromRGB(20, 20, 22),

    Scrollbar = Color3.fromRGB(105, 105, 112),

    Success = Color3.fromRGB(95, 205, 125),
    Warning = Color3.fromRGB(235, 190, 80),
    Danger = Color3.fromRGB(225, 85, 85)
}

Library._ThemeObjects = {}
Library._Connections = {}
Library._Destroyed = false
Library.Tabs = {}

local function New(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        pcall(function()
            object[property] = value
        end)
    end

    if parent then
        object.Parent = parent
    end

    return object
end

local function Corner(object, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = object
    return c
end

local function Stroke(object, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or Library.Theme.Border
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0

    pcall(function()
        s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    end)

    s.Parent = object
    return s
end

local function Shadow(object)
    local ok, result = pcall(function()
        local s = Instance.new("UIShadow")

        pcall(function()
            s.BlurRadius = 18
            s.Offset = Vector2.new(0, 5)
            s.Spread = Vector2.new(2, 2)
            s.Transparency = 0.45
            s.Color = Color3.fromRGB(0, 0, 0)
        end)

        s.Parent = object
        return s
    end)

    if ok then
        return result
    end
end

local function Register(object, property, themeName)
    if not object then
        return
    end

    pcall(function()
        object[property] = Library.Theme[themeName]
    end)

    table.insert(Library._ThemeObjects, {
        Object = object,
        Property = property,
        Key = themeName
    })
end

local function SafeCallback(callback, ...)
    if typeof(callback) ~= "function" then
        return
    end

    local args = table.pack(...)

    task.spawn(function()
        pcall(function()
            callback(table.unpack(args, 1, args.n))
        end)
    end)
end

local function Tween(object, info, properties)
    if not object then
        return
    end

    local ok, tween = pcall(function()
        return TweenService:Create(object, info, properties)
    end)

    if ok and tween then
        tween:Play()
        return tween
    end
end

local function Clamp(value, minimum, maximum)
    return math.max(minimum, math.min(maximum, value))
end

local function AddPadding(object, left, right, top, bottom)
    return New("UIPadding", {
        PaddingLeft = UDim.new(0, left or 0),
        PaddingRight = UDim.new(0, right or 0),
        PaddingTop = UDim.new(0, top or 0),
        PaddingBottom = UDim.new(0, bottom or 0)
    }, object)
end

----------------------------------------------------------------
-- SCREEN GUI
----------------------------------------------------------------

local Old = PlayerGui:FindFirstChild("ModernLibrary")

if Old then
    Old:Destroy()
end

local ScreenGui = New("ScreenGui", {
    Name = "ModernLibrary",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

Library.ScreenGui = ScreenGui

----------------------------------------------------------------
-- LOADING
----------------------------------------------------------------

local LoadingFrame = New("Frame", {
    Name = "LoadingFrame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = Library.Config.StartSize,
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    ClipsDescendants = true
}, ScreenGui)

Corner(LoadingFrame, 14)
Stroke(LoadingFrame, Color3.fromRGB(45, 45, 45), 1, 0.2)
Shadow(LoadingFrame)

local LoadingContent = New("Frame", {
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1)
}, LoadingFrame)

local LoadingName = New("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(30, 30),
    Size = UDim2.new(1, -60, 0, 34),
    Font = Enum.Font.GothamBold,
    Text = Library.Config.Name,
    TextSize = 25,
    TextColor3 = Color3.fromRGB(245, 245, 245),
    TextXAlignment = Enum.TextXAlignment.Left
}, LoadingContent)

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(175, 175, 185)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
Gradient.Parent = LoadingName

local LoadingTitle = New("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(30, 72),
    Size = UDim2.new(1, -100, 0, 24),
    Font = Enum.Font.GothamMedium,
    Text = Library.Config.LoadingTitle,
    TextSize = 17,
    TextColor3 = Color3.fromRGB(225, 225, 230),
    TextXAlignment = Enum.TextXAlignment.Left
}, LoadingContent)

local LoadingDots = New("TextLabel", {
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -30, 0, 72),
    Size = UDim2.fromOffset(60, 24),
    Font = Enum.Font.GothamBold,
    Text = "...",
    TextSize = 17,
    TextColor3 = Color3.fromRGB(205, 205, 210),
    TextXAlignment = Enum.TextXAlignment.Right
}, LoadingContent)

local LoadingSubtitle = New("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(30, 101),
    Size = UDim2.new(1, -60, 0, 20),
    Font = Enum.Font.Gotham,
    Text = Library.Config.LoadingSubtitle,
    TextSize = 12,
    TextColor3 = Color3.fromRGB(155, 155, 165),
    TextXAlignment = Enum.TextXAlignment.Left
}, LoadingContent)

local LoadingDescription = New("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(30, 127),
    Size = UDim2.new(1, -60, 0, 35),
    Font = Enum.Font.Gotham,
    Text = Library.Config.LoadingDescription,
    TextSize = 11,
    TextWrapped = true,
    TextColor3 = Color3.fromRGB(115, 115, 125),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
}, LoadingContent)

----------------------------------------------------------------
-- MAIN
----------------------------------------------------------------

local MainFrame = New("Frame", {
    Name = "MainFrame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = Library.Config.StartSize,
    BackgroundColor3 = Library.Theme.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Visible = false
}, ScreenGui)

Library.MainFrame = MainFrame

Corner(MainFrame, 14)

local MainStroke = Stroke(
    MainFrame,
    Library.Theme.Border,
    1,
    0.1
)

Register(MainFrame, "BackgroundColor3", "Background")
Register(MainStroke, "Color", "Border")

Shadow(MainFrame)

----------------------------------------------------------------
-- TOP BAR
----------------------------------------------------------------

local TopBar = New("Frame", {
    Name = "TopBar",
    Position = UDim2.fromOffset(1, 1),
    Size = UDim2.new(1, -2, 0, 43),
    BackgroundColor3 = Library.Theme.Surface,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, MainFrame)

Register(TopBar, "BackgroundColor3", "Surface")

Corner(TopBar, 13)

local TopBarBottom = New("Frame", {
    Position = UDim2.new(0, 0, 1, -13),
    Size = UDim2.new(1, 0, 0, 13),
    BackgroundColor3 = Library.Theme.Surface,
    BorderSizePixel = 0
}, TopBar)

Register(TopBarBottom, "BackgroundColor3", "Surface")

local Title = New("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(18, 0),
    Size = UDim2.new(1, -150, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = Library.Config.Name,
    TextSize = 14,
    TextColor3 = Library.Theme.Text,
    TextXAlignment = Enum.TextXAlignment.Left
}, TopBar)

Register(Title, "TextColor3", "Text")

----------------------------------------------------------------
-- CONTROLS
----------------------------------------------------------------

local ControlHolder = New("Frame", {
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -12, 0.5, 0),
    Size = UDim2.fromOffset(82, 22)
}, TopBar)

New("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    Padding = UDim.new(0, 6)
}, ControlHolder)

local function CreateControl(name, color)
    local button = New("TextButton", {
        Name = name,
        Size = UDim2.fromOffset(18, 18),
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false
    }, ControlHolder)

    Corner(button, 50)

    button.MouseEnter:Connect(function()
        Tween(button, TweenInfo.new(0.12), {
            BackgroundTransparency = 0.15
        })
    end)

    button.MouseLeave:Connect(function()
        Tween(button, TweenInfo.new(0.12), {
            BackgroundTransparency = 0
        })
    end)

    return button
end

local CloseButton = CreateControl(
    "Close",
    Color3.fromRGB(235, 82, 82)
)

local MinimizeButton = CreateControl(
    "Minimize",
    Color3.fromRGB(238, 194, 72)
)

local MaximizeButton = CreateControl(
    "Maximize",
    Color3.fromRGB(82, 200, 112)
)

----------------------------------------------------------------
-- BODY
----------------------------------------------------------------

local Body = New("Frame", {
    Name = "Body",
    Position = UDim2.fromOffset(1, 44),
    Size = UDim2.new(1, -2, 1, -45),
    BackgroundTransparency = 1,
    ClipsDescendants = true
}, MainFrame)

----------------------------------------------------------------
-- SIDEBAR
----------------------------------------------------------------

local Sidebar = New("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, 108, 1, 0),
    BackgroundColor3 = Library.Theme.Surface,
    BorderSizePixel = 0
}, Body)

Register(Sidebar, "BackgroundColor3", "Surface")

AddPadding(Sidebar, 7, 7, 9, 9)

New("UIListLayout", {
    FillDirection = Enum.FillDirection.Vertical,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 3)
}, Sidebar)

----------------------------------------------------------------
-- CONTENT
----------------------------------------------------------------

local Content = New("Frame", {
    Name = "Content",
    Position = UDim2.new(0, 108, 0, 0),
    Size = UDim2.new(1, -108, 1, 0),
    BackgroundColor3 = Library.Theme.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, Body)

Register(Content, "BackgroundColor3", "Background")

----------------------------------------------------------------
-- DRAGGING
----------------------------------------------------------------

local dragging = false
local dragStart
local startPosition

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        local delta = input.Position - dragStart

        MainFrame.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = false
    end
end)

----------------------------------------------------------------
-- WINDOW
----------------------------------------------------------------

local NormalSize = Library.Config.MainSize
local NormalPosition = UDim2.fromScale(0.5, 0.5)

local Maximized = false
local Minimized = false

local function GetMaxSize()
    local camera = workspace.CurrentCamera

    if not camera then
        return UDim2.fromOffset(650, 500)
    end

    local viewport = camera.ViewportSize

    local width = math.max(300, math.min(viewport.X - 24, 700))
    local height = math.max(220, math.min(viewport.Y - 24, 600))

    return UDim2.fromOffset(width, height)
end

local function SetMaximized(state)
    if Minimized then
        return
    end

    Maximized = state

    if state then
        NormalSize = MainFrame.Size
        NormalPosition = MainFrame.Position

        Tween(MainFrame,
            TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {
                Size = GetMaxSize(),
                Position = UDim2.fromScale(0.5, 0.5)
            }
        )
    else
        Tween(MainFrame,
            TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {
                Size = NormalSize,
                Position = NormalPosition
            }
        )
    end
end

MaximizeButton.Activated:Connect(function()
    SetMaximized(not Maximized)
end)

local function SetMinimized(state)
    if state and Maximized then
        SetMaximized(false)
    end

    Minimized = state

    if state then
        Tween(MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(
                    MainFrame.Size.X.Scale,
                    MainFrame.Size.X.Offset,
                    0,
                    44
                )
            }
        )
    else
        Tween(MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {
                Size = NormalSize
            }
        )
    end
end

MinimizeButton.Activated:Connect(function()
    SetMinimized(not Minimized)
end)

----------------------------------------------------------------
-- PAGES
----------------------------------------------------------------

local Tabs = Library.Tabs
local CurrentTab = nil
local TabCount = 0

local function CreatePage()
    local Page = New("ScrollingFrame", {
        Name = "Page",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,

        ScrollBarThickness = 4,
        ScrollBarImageTransparency = 0.25,
        ScrollBarImageColor3 = Library.Theme.Scrollbar,

        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Visible = false
    }, Content)

    Register(Page, "ScrollBarImageColor3", "Scrollbar")

    AddPadding(Page, 12, 12, 12, 14)

    New("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 7)
    }, Page)

    return Page
end

----------------------------------------------------------------
-- TAB
----------------------------------------------------------------

function Library:AddTab(name)
    TabCount += 1

    local tabName = tostring(name or ("Tab " .. TabCount))

    local TabButton = New("TextButton", {
        Name = tabName .. "Tab",
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = Library.Theme.Surface2,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = "",
        LayoutOrder = TabCount
    }, Sidebar)

    Register(TabButton, "BackgroundColor3", "Surface2")

    Corner(TabButton, 7)

    local Indicator = New("Frame", {
        Name = "ActiveIndicator",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -5, 0.5, 0),
        Size = UDim2.fromOffset(3, 20),
        BackgroundColor3 = Library.Theme.Accent,
        BorderSizePixel = 0,
        Visible = false
    }, TabButton)

    Register(Indicator, "BackgroundColor3", "Accent")
    Corner(Indicator, 4)

    local TabText = New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.new(1, -34, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = tabName,
        TextSize = 12,
        TextColor3 = Library.Theme.SubText,
        TextXAlignment = Enum.TextXAlignment.Left
    }, TabButton)

    Register(TabText, "TextColor3", "SubText")

    AddPadding(TabText, 0, 10, 0, 0)

    local Page = CreatePage()

    local Tab = {
        Name = tabName,
        Button = TabButton,
        Page = Page,
        Indicator = Indicator,
        Text = TabText,
        Elements = {},
        _ElementOrder = 0
    }

    Tabs[tabName] = Tab

    function Tab:Select()
        for _, other in pairs(Tabs) do
            other.Page.Visible = false
            other.Indicator.Visible = false
            other.Button.BackgroundTransparency = 1
            other.Text.TextColor3 = Library.Theme.SubText
        end

        Page.Visible = true
        Indicator.Visible = true
        TabButton.BackgroundTransparency = 0
        TabText.TextColor3 = Library.Theme.Text

        CurrentTab = Tab
    end

    TabButton.Activated:Connect(function()
        Tab:Select()
    end)

    if not CurrentTab then
        Tab:Select()
    end

    return Tab
end

----------------------------------------------------------------
-- ELEMENT HOLDER
----------------------------------------------------------------

local function Holder(Tab, height)
    Tab._ElementOrder += 1

    local H = New("Frame", {
        Size = UDim2.new(1, 0, 0, height or 40),
        BackgroundTransparency = 1,
        LayoutOrder = Tab._ElementOrder
    }, Tab.Page)

    table.insert(Tab.Elements, H)

    return H
end

----------------------------------------------------------------
-- HEADER
----------------------------------------------------------------

function Library:AddHeader(Tab, text)
    local H = Holder(Tab, 34)

    local Label = New("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Font = Enum.Font.GothamBold,
        Text = tostring(text),
        TextSize = 17,
        TextColor3 = Library.Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left
    }, H)

    Register(Label, "TextColor3", "Text")

    AddPadding(Label, 1, 1, 0, 0)

    return H
end

----------------------------------------------------------------
-- SECTION
----------------------------------------------------------------

function Library:AddSection(Tab, text)
    local H = Holder(Tab, 28)

    local Label = New("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
 

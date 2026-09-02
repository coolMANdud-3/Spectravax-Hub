--[[
    MODERN UI LIBRARY
    Single LocalScript
    Place in StarterGui

    Main:
        400 x 300

    Loading:
        starts small
        expands to 500 x 200
        black loading screen
        fades
        becomes 400 x 300

    No icons / no emojis.
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

----------------------------------------------------------------
-- LIBRARY
----------------------------------------------------------------

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

----------------------------------------------------------------
-- THEME
----------------------------------------------------------------

Library.Theme = {
    Background = Color3.fromRGB(22, 22, 25),
    Surface = Color3.fromRGB(28, 28, 32),
    Surface2 = Color3.fromRGB(32, 32, 37),

    Element = Color3.fromRGB(37, 37, 43),
    ElementHover = Color3.fromRGB(45, 45, 51),

    Border = Color3.fromRGB(58, 58, 66),

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

----------------------------------------------------------------
-- HELPERS
----------------------------------------------------------------

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

local function AddCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function AddStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Library.Theme.Border
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

local function AddShadow(parent)
    local success, shadow = pcall(function()
        return Instance.new("UIShadow")
    end)

    if success and shadow then
        shadow.Parent = parent
        return shadow
    end

    return nil
end

local function Theme(object, property, key)
    if not object then
        return
    end

    if Library.Theme[key] ~= nil then
        pcall(function()
            object[property] = Library.Theme[key]
        end)
    end

    table.insert(Library._ThemeObjects, {
        Object = object,
        Property = property,
        Key = key
    })
end

local function SafeCallback(callback, ...)
    if typeof(callback) == "function" then
        task.spawn(function()
            pcall(callback, ...)
        end)
    end
end

local function Tween(object, info, properties)
    if not object then
        return
    end

    local tween = TweenService:Create(
        object,
        info or TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        properties
    )

    tween:Play()

    return tween
end

local function Clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

----------------------------------------------------------------
-- SCREEN GUI
----------------------------------------------------------------

local ScreenGui = New("ScreenGui", {
    Name = "ModernLibrary",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

Library.ScreenGui = ScreenGui

----------------------------------------------------------------
-- LOADING UI
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

AddCorner(LoadingFrame, 14)
AddStroke(LoadingFrame, Color3.fromRGB(35, 35, 35), 1, 0.2)
AddShadow(LoadingFrame)

local LoadingContainer = New("Frame", {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0)
}, LoadingFrame)

local LoadingTitle = New("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 30, 0, 32),
    Size = UDim2.new(1, -60, 0, 34),
    Font = Enum.Font.GothamBold,
    Text = Library.Config.Name,
    TextSize = 25,
    TextColor3 = Color3.fromRGB(245, 245, 245),
    TextXAlignment = Enum.TextXAlignment.Left
}, LoadingContainer)

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(190, 190, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
TitleGradient.Rotation = 0
TitleGradient.Parent = LoadingTitle

local LoadingText = New("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 30, 0, 72),
    Size = UDim2.new(1, -60, 0, 25),
    Font = Enum.Font.GothamMedium,
    Text = Library.Config.LoadingTitle,
    TextSize = 17,
    TextColor3 = Color3.fromRGB(225, 225, 230),
    TextXAlignment = Enum.TextXAlignment.Left
}, LoadingContainer)

local LoadingSubtitle = New("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 30, 0, 100),
    Size = UDim2.new(1, -60, 0, 22),
    Font = Enum.Font.Gotham,
    Text = Library.Config.LoadingSubtitle,
    TextSize = 12,
    TextColor3 = Color3.fromRGB(155, 155, 165),
    TextXAlignment = Enum.TextXAlignment.Left
}, LoadingContainer)

local LoadingDescription = New("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 30, 0, 127),
    Size = UDim2.new(1, -60, 0, 35),
    Font = Enum.Font.Gotham,
    Text = Library.Config.LoadingDescription,
    TextSize = 11,
    TextColor3 = Color3.fromRGB(115, 115, 125),
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
}, LoadingContainer)

local LoadingDots = New("TextLabel", {
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -30, 0, 72),
    Size = UDim2.fromOffset(70, 25),
    Font = Enum.Font.GothamBold,
    Text = "...",
    TextSize = 17,
    TextColor3 = Color3.fromRGB(190, 190, 195),
    TextXAlignment = Enum.TextXAlignment.Right
}, LoadingContainer)

----------------------------------------------------------------
-- MAIN FRAME
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

-- Important: parent clipping + actual rounded corner.
AddCorner(MainFrame, 14)

local MainStroke = AddStroke(MainFrame, Library.Theme.Border, 1, 0.15)
Theme(MainFrame, "BackgroundColor3", "Background")
Theme(MainStroke, "Color", "Border")

AddShadow(MainFrame)

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

Theme(TopBar, "BackgroundColor3", "Surface")

local TopBarCorner = AddCorner(TopBar, 13)

local TopBarBottom = New("Frame", {
    Position = UDim2.new(0, 0, 1, -12),
    Size = UDim2.new(1, 0, 0, 12),
    BackgroundColor3 = Library.Theme.Surface,
    BorderSizePixel = 0
}, TopBar)

Theme(TopBarBottom, "BackgroundColor3", "Surface")

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

Theme(Title, "TextColor3", "Text")

----------------------------------------------------------------
-- WINDOW CONTROL BUTTONS
----------------------------------------------------------------

local ControlHolder = New("Frame", {
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -12, 0.5, 0),
    Size = UDim2.fromOffset(82, 22)
}, TopBar)

local ControlLayout = New("UIListLayout", {
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
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false
    }, ControlHolder)

    AddCorner(button, 50)

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
    Position = UDim2.fromOffset(0, 0),
    Size = UDim2.new(0, 108, 1, 0),
    BackgroundColor3 = Library.Theme.Surface,
    BorderSizePixel = 0
}, Body)

Theme(Sidebar, "BackgroundColor3", "Surface")

local SidebarPadding = New("UIPadding", {
    PaddingTop = UDim.new(0, 9),
    PaddingBottom = UDim.new(0, 9),
    PaddingLeft = UDim.new(0, 7),
    PaddingRight = UDim.new(0, 7)
}, Sidebar)

local TabList = New("UIListLayout", {
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

Theme(Content, "BackgroundColor3", "Background")

----------------------------------------------------------------
-- TAB DATA
----------------------------------------------------------------

local Tabs = {}
local CurrentTab = nil
local TabCount = 0

Library.Tabs = Tabs

----------------------------------------------------------------
-- DRAGGING
----------------------------------------------------------------

local dragging = false
local dragStart
local startPosition

local function StartDrag(input)
    dragging = true
    dragStart = input.Position
    startPosition = MainFrame.Position
end

local function UpdateDrag(input)
    if not dragging then
        return
    end

    local delta = input.Position - dragStart

    MainFrame.Position = UDim2.new(
        startPosition.X.Scale,
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale,
        startPosition.Y.Offset + delta.Y
    )
end

local function EndDrag()
    dragging = false
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        StartDrag(input)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        dragStart = dragStart or input.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging then
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            UpdateDrag(input)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        EndDrag()
    end
end)

----------------------------------------------------------------
-- MAXIMIZE
----------------------------------------------------------------

local NormalSize = Library.Config.MainSize
local NormalPosition = UDim2.fromScale(0.5, 0.5)
local Maximized = false
local Minimized = false

local function GetMaxSize()
    local camera = workspace.CurrentCamera

    if camera then
        local viewport = camera.ViewportSize

        local width = math.min(viewport.X - 24, 700)
        local height = math.min(viewport.Y - 24, 600)

        return UDim2.fromOffset(
            math.max(width, 300),
            math.max(height, 220)
        )
    end

    return UDim2.new(0.9, 0, 0.85, 0)
end

local function SetMaximized(state)
    if Minimized then
        return
    end

    Maximized = state

    if state then
        NormalSize = MainFrame.Size
        NormalPosition = MainFrame.Position

        Tween(
            MainFrame,
            TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {
                Size = GetMaxSize(),
                Position = UDim2.fromScale(0.5, 0.5)
            }
        )
    else
        Tween(
            MainFrame,
            TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {
                Size = NormalSize,
                Position = NormalPosition
            }
        )
    end
end

MaximizeButton.MouseButton1Click:Connect(function()
    SetMaximized(not Maximized)
end)

----------------------------------------------------------------
-- MINIMIZE
----------------------------------------------------------------

local function SetMinimized(state)
    if Maximized and state then
        SetMaximized(false)
    end

    Minimized = state

    if state then
        Tween(
            MainFrame,
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
        Tween(
            MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {
                Size = NormalSize
            }
        )
    end
end

MinimizeButton.MouseButton1Click:Connect(function()
    SetMinimized(not Minimized)
end)

----------------------------------------------------------------
-- CLOSE
----------------------------------------------------------------

CloseButton.MouseButton1Click:Connect(function()
    Library:Destroy()
end)

----------------------------------------------------------------
-- PAGE CREATION
----------------------------------------------------------------

local function CreatePage()
    local Page = New("ScrollingFrame", {
        Name = "Page",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageTransparency = 0.2,
        ScrollBarImageColor3 = Library.Theme.Scrollbar,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Visible = false
    }, Content)

    Theme(Page, "ScrollBarImageColor3", "Scrollbar")

    local Padding = New("UIPadding", {
        PaddingTop = UDim.new(0, 12),
        PaddingBottom = UDim.new(0, 14),
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12)
    }, Page)

    local Layout = New("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 7)
    }, Page)

    return Page
end

----------------------------------------------------------------
-- TAB
----------------------------------------------------------------

function Library:CreateTab(info)
    info = info or {}

    TabCount += 1

    local tabName = info.Name or ("Tab " .. TabCount)

    local TabButton = New("TextButton", {
        Name = tabName .. "Tab",
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = Library.Theme.Surface,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = "",
        LayoutOrder = TabCount
    }, Sidebar)

    Theme(TabButton, "BackgroundColor3", "Surface")

    AddCorner(TabButton, 7)

    -- RIGHT-SIDE ACTIVE INDICATOR
    local Indicator = New("Frame", {
        Name = "ActiveIndicator",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -5, 0.5, 0),
        Size = UDim2.fromOffset(3, 20),
        BackgroundColor3 = Library.Theme.Accent,
        BorderSizePixel = 0,
        Visible = false
    }, TabButton)

    Theme(Indicator, "BackgroundColor3", "Accent")

    AddCorner(Indicator, 4)

    local TabText = New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(13, 0),
        Size = UDim2.new(1, -35, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = tabName,
        TextSize = 12,
        TextColor3 = Library.Theme.SubText,
        TextXAlignment = Enum.TextXAlignment.Left
    }, TabButton)

    Theme(TabText, "TextColor3", "SubText")

    local Page = CreatePage()

    local Tab = {
        Name = tabName,
        Button = TabButton,
        Page = Page,
        Elements = {},
        _ElementOrder = 0
    }

    Tabs[tabName] = Tab

    function Tab:Select()
        for _, other in pairs(Tabs) do
            if other ~= Tab then
                other.Page.Visible = false
                other.Button.BackgroundTransparency = 1
                other.Indicator.Visible = false
                other.Text.TextColor3 = Library.Theme.SubText
            end
        end

        Page.Visible = true
        TabButton.BackgroundTransparency = 0
        Indicator.Visible = true
        TabText.TextColor3 = Library

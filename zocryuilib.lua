local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local TweenService = game:GetService("TweenService")

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
MainFrame.Size = UDim2.new(0, 412, 0, 264)
MainFrame.Position = UDim2.new(0, 206, 0, 8)
MainFrame.Name = "MainFrame"
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(255, 119, 33)

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.TextWrapped = true
Title.ZIndex = 2
Title.BorderSizePixel = 0
Title.TextScaled = true
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0, 168, 0, 26)
Title.Text = "Spectravax Hub"
Title.Name = "Title"
Title.Position = UDim2.new(0, 12, 0, 8)

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Parent = MainFrame
MinimizeButton.BorderSizePixel = 0
MinimizeButton.TextSize = 18
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeButton.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Text = "−"
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Position = UDim2.new(1, -100, 0, 5)

local FullscreenButton = Instance.new("TextButton")
FullscreenButton.Parent = MainFrame
FullscreenButton.BorderSizePixel = 0
FullscreenButton.TextSize = 16
FullscreenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FullscreenButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FullscreenButton.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
FullscreenButton.Size = UDim2.new(0, 30, 0, 30)
FullscreenButton.Text = "□"
FullscreenButton.Name = "FullscreenButton"
FullscreenButton.Position = UDim2.new(1, -65, 0, 5)

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.BorderSizePixel = 0
CloseButton.TextSize = 18
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Text = "×"
CloseButton.Name = "CloseButton"
CloseButton.Position = UDim2.new(1, -35, 0, 5)

local Frame1 = Instance.new("Frame")
Frame1.Parent = MainFrame
Frame1.BorderSizePixel = 0
Frame1.BackgroundColor3 = Color3.fromRGB(145, 145, 145)
Frame1.Size = UDim2.new(0, 404, 0, 256)
Frame1.Position = UDim2.new(0, 4, 0, 4)
Frame1.BackgroundTransparency = 0.8

local Frame2 = Instance.new("Frame")
Frame2.Parent = Frame1
Frame2.BorderSizePixel = 0
Frame2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame2.Size = UDim2.new(0, 392, 0, 246)
Frame2.Position = UDim2.new(0, 6, 0, 4)
Frame2.BackgroundTransparency = 0.8

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.Size = UDim2.new(0, 300, 0, 208)
ScrollingFrame.Position = UDim2.new(0, 96, 0, 42)
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.BackgroundTransparency = 0.6

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local Tabs = {}
local TabElements = {}
local CurrentTab = nil
local minimized = false
local fullscreen = false
local originalSize = UDim2.new(0, 412, 0, 264)
local originalPos = UDim2.new(0, 206, 0, 8)
local ThemeColors = {
    Orange = Color3.fromRGB(255, 119, 33),
    Blue = Color3.fromRGB(33, 119, 255),
    Red = Color3.fromRGB(255, 33, 33),
    Green = Color3.fromRGB(33, 255, 119),
    Purple = Color3.fromRGB(170, 33, 255),
    Pink = Color3.fromRGB(255, 33, 170),
    Cyan = Color3.fromRGB(33, 255, 255),
    Yellow = Color3.fromRGB(255, 255, 33)
}
local CurrentTheme = "Orange"

local function CreateTab(name, pos)
    local tab = Instance.new("TextButton")
    tab.Parent = MainFrame
    tab.BorderSizePixel = 0
    tab.TextSize = 12
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
    tab.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    tab.Size = UDim2.new(0, 72, 0, 40)
    tab.Text = name
    tab.Name = "Tab"
    tab.Position = UDim2.new(0, 14, 0, pos)
    tab.AutoButtonColor = false
    
    local stroke = Instance.new("UIStroke")
    stroke.Parent = tab
    stroke.Color = Color3.fromRGB(113, 113, 113)
    
    table.insert(Tabs, tab)
    TabElements[name] = {}
    
    tab.MouseEnter:Connect(function()
        if tab.BackgroundColor3 ~= Color3.fromRGB(255, 119, 33) then
            TweenService:Create(tab, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
        end
    end)
    tab.MouseLeave:Connect(function()
        if tab.BackgroundColor3 ~= Color3.fromRGB(255, 119, 33) then
            TweenService:Create(tab, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}):Play()
        end
    end)
    
    tab.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            TweenService:Create(t, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}):Play()
            t.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        TweenService:Create(tab, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(255, 119, 33)}):Play()
        tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        CurrentTab = name
        
        for _, child in pairs(ScrollingFrame:GetChildren()) do
            if child:IsA("TextButton") or child:IsA("TextLabel") or child:IsA("Frame") then
                child.Visible = false
                child.Parent = nil
            end
        end
        
        for _, element in pairs(TabElements[name]) do
            element.Visible = true
            element.Parent = ScrollingFrame
        end
    end)
    
    return tab
end

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.TextWrapped = true
    btn.BorderSizePixel = 0
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
    btn.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    btn.Size = UDim2.new(0, 270, 0, 34)
    btn.Text = text
    btn.Name = "ButtonElement"
    btn.AutoButtonColor = false
    
    local stroke = Instance.new("UIStroke")
    stroke.Parent = btn
    stroke.Color = Color3.fromRGB(113, 113, 113)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(80, 80, 80), Size = UDim2.new(0, 275, 0, 36)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(54, 54, 54), Size = UDim2.new(0, 270, 0, 34)}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
        task.wait(0.1)
        TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(54, 54, 54)}):Play()
        if callback then callback() end
    end)
    
    if TabElements[CurrentTab] then
        table.insert(TabElements[CurrentTab], btn)
    end
    return btn
end

local function CreateToggle(text, default, callback)
    local toggle = Instance.new("TextButton")
    toggle.TextWrapped = true
    toggle.BorderSizePixel = 0
    toggle.TextSize = 14
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
    toggle.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    toggle.Size = UDim2.new(0, 270, 0, 36)
    toggle.Text = text
    toggle.Name = "ToggleElement"
    toggle.AutoButtonColor = false
    
    local stroke = Instance.new("UIStroke")
    stroke.Parent = toggle
    stroke.Color = Color3.fromRGB(113, 113, 113)
    
    local indicator = Instance.new("Frame")
    indicator.Parent = toggle
    indicator.BorderSizePixel = 0
    indicator.BackgroundColor3 = default and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(106, 0, 0)
    indicator.Size = UDim2.new(0, 28, 0, 28)
    indicator.Position = UDim2.new(0, 238, 0, 4)
    
    local indicatorStroke = Instance.new("UIStroke")
    indicatorStroke.Parent = indicator
    indicatorStroke.Color = Color3.fromRGB(79, 79, 79)
    
    local state = default or false
    
    toggle.MouseEnter:Connect(function()
        TweenService:Create(toggle, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
    end)
    toggle.MouseLeave:Connect(function()
        TweenService:Create(toggle, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(54, 54, 54)}):Play()
    end)
    toggle.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(106, 0, 0)}):Play()
        if callback then callback(state) end
    end)
    
    if TabElements[CurrentTab] then
        table.insert(TabElements[CurrentTab], toggle)
    end
    return toggle
end

local function CreateLabel(text)
    local label = Instance.new("TextLabel")
    label.TextWrapped = true
    label.ZIndex = 2
    label.BorderSizePixel = 0
    label.TextScaled = true
    label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    label.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0, 116, 0, 20)
    label.Text = text
    label.Name = "LabelElement"
    label.Position = UDim2.new(0, 28, 0, 20)
    
    if TabElements[CurrentTab] then
        table.insert(TabElements[CurrentTab], label)
    end
    return label
end

local function CreateCopyLabel(text)
    local container = Instance.new("Frame")
    container.BorderSizePixel = 0
    container.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
    container.Size = UDim2.new(0, 270, 0, 30)
    container.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = container
    label.TextWrapped = true
    label.ZIndex = 2
    label.BorderSizePixel = 0
    label.TextScaled = true
    label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    label.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0, 200, 0, 20)
    label.Text = text
    label.Name = "CopyLabel"
    label.Position = UDim2.new(0, 0, 0, 5)
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local copyBtn = Instance.new("TextButton")
    copyBtn.Parent = container
    copyBtn.BorderSizePixel = 0
    copyBtn.TextSize = 12
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    copyBtn.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    copyBtn.Size = UDim2.new(0, 50, 0, 24)
    copyBtn.Position = UDim2.new(0, 220, 0, 3)
    copyBtn.Text = "Copy"
    copyBtn.Name = "CopyButton"
    
    local copyStroke = Instance.new("UIStroke")
    copyStroke.Parent = copyBtn
    copyStroke.Color = Color3.fromRGB(113, 113, 113)
    
    copyBtn.MouseEnter:Connect(function()
        TweenService:Create(copyBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    copyBtn.MouseLeave:Connect(function()
        TweenService:Create(copyBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)
    copyBtn.MouseButton1Click:Connect(function()
        setclipboard(text)
        TweenService:Create(copyBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Text = "Copied!"}):Play()
        task.wait(1)
        TweenService:Create(copyBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Text = "Copy"}):Play()
    end)
    
    if TabElements[CurrentTab] then
        table.insert(TabElements[CurrentTab], container)
    end
    return container
end

local function CreateDropdown(text, options, default, callback)
    local container = Instance.new("Frame")
    container.BorderSizePixel = 0
    container.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
    container.Size = UDim2.new(0, 270, 0, 36)
    container.BackgroundTransparency = 1
    
    local dropdown = Instance.new("TextButton")
    dropdown.Parent = container
    dropdown.TextWrapped = true
    dropdown.BorderSizePixel = 0
    dropdown.TextSize = 14
    dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdown.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
    dropdown.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    dropdown.Size = UDim2.new(0, 270, 0, 36)
    dropdown.Text = text .. ": " .. (default or options[1])
    dropdown.Name = "DropdownElement"
    dropdown.AutoButtonColor = false
    
    local stroke = Instance.new("UIStroke")
    stroke.Parent = dropdown
    stroke.Color = Color3.fromRGB(113, 113, 113)
    
    local arrow = Instance.new("TextLabel")
    arrow.Parent = dropdown
    arrow.BorderSizePixel = 0
    arrow.BackgroundTransparency = 1
    arrow.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    arrow.TextColor3 = Color3.fromRGB(255, 255, 255)
    arrow.Size = UDim2.new(0, 30, 0, 30)
    arrow.Position = UDim2.new(1, -35, 0, 3)
    arrow.Text = "v"
    arrow.TextSize = 20
    
    local expanded = false
    local selected = default or options[1]
    local optionButtons = {}
    
    local function updateText()
        dropdown.Text = text .. ": " .. selected
    end
    
    local function createOptions()
        for _, opt in pairs(optionButtons) do
            opt:Destroy()
        end
        optionButtons = {}
        
        if expanded then
            local y = 36
            for _, option in pairs(options) do
                local optBtn = Instance.new("TextButton")
                optBtn.Parent = container
                optBtn.TextWrapped = true
                optBtn.BorderSizePixel = 0
                optBtn.TextSize = 14
                optBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                optBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                optBtn.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                optBtn.Size = UDim2.new(0, 270, 0, 28)
                optBtn.Position = UDim2.new(0, 0, 0, y)
                optBtn.Text = option
                optBtn.Name = "DropdownOption"
                optBtn.AutoButtonColor = false
                
                local optStroke = Instance.new("UIStroke")
                optStroke.Parent = optBtn
                optStroke.Color = Color3.fromRGB(113, 113, 113)
                
                optBtn.MouseEnter:Connect(function()
                    TweenService:Create(optBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
                end)
                optBtn.MouseLeave:Connect(function()
                    TweenService:Create(optBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                end)
                optBtn.MouseButton1Click:Connect(function()
                    selected = option
                    updateText()
                    if callback then callback(option) end
                    expanded = false
                    arrow.Text = "v"
                    TweenService:Create(container, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 270, 0, 36)}):Play()
                    for _, btn in pairs(optionButtons) do
                        btn:Destroy()
                    end
                    optionButtons = {}
                end)
                
                table.insert(optionButtons, optBtn)
                y = y + 28
            end
            TweenService:Create(container, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 270, 0, y)}):Play()
        end
    end
    
    dropdown.MouseEnter:Connect(function()
        TweenService:Create(dropdown, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
    end)
    dropdown.MouseLeave:Connect(function()
        TweenService:Create(dropdown, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(54, 54, 54)}):Play()
    end)
    dropdown.MouseButton1Click:Connect(function()
        expanded = not expanded
        arrow.Text = expanded and "^" or "v"
        createOptions()
    end)
    
    if TabElements[CurrentTab] then
        table.insert(TabElements[CurrentTab], container)
    end
    return dropdown
end

local function CreateSlider(text, min, max, default, callback)
    local container = Instance.new("Frame")
    container.BorderSizePixel = 0
    container.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
    container.Size = UDim2.new(0, 270, 0, 50)
    container.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = container
    label.BorderSizePixel = 0
    label.BackgroundTransparency = 1
    label.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Size = UDim2.new(0, 200, 0, 20)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Text = text .. ": " .. tostring(default)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local track = Instance.new("Frame")
    track.Parent = container
    track.BorderSizePixel = 0
    track.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    track.Size = UDim2.new(0, 250, 0, 6)
    track.Position = UDim2.new(0, 10, 0, 24)
    
    local fill = Instance.new("Frame")
    fill.Parent = track
    fill.BorderSizePixel = 0
    fill.BackgroundColor3 = Color3.fromRGB(255, 119, 33)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    
    local value = default
    
    local function updateSlider(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            local relativeX = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            value = math.round(min + (relativeX * (max - min)))
            value = math.clamp(value, min, max)
            TweenService:Create(fill, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new((value - min) / (max - min), 0, 1, 0)}):Play()
            label.Text = text .. ": " .. tostring(value)
            if callback then callback(value) end
        end
    end
    
    track.MouseEnter:Connect(function()
        TweenService:Create(track, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    track.MouseLeave:Connect(function()
        TweenService:Create(track, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)
    
    track.MouseButton1Down:Connect(function()
        local connection = game:GetService("UserInputService").InputChanged:Connect(updateSlider)
        local releaseConnection = game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
                releaseConnection:Disconnect()
            end
        end)
    end)
    
    if TabElements[CurrentTab] then
        table.insert(TabElements[CurrentTab], container)
    end
    return container
end

local function CreateKeybind(text, default, callback)
    local keybind = Instance.new("TextButton")
    keybind.TextWrapped = true
    keybind.BorderSizePixel = 0
    keybind.TextSize = 14
    keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
    keybind.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
    keybind.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    keybind.Size = UDim2.new(0, 270, 0, 36)
    keybind.Text = text .. ": " .. tostring(default)
    keybind.Name = "KeybindElement"
    keybind.AutoButtonColor = false
    
    local stroke = Instance.new("UIStroke")
    stroke.Parent = keybind
    stroke.Color = Color3.fromRGB(113, 113, 113)
    
    local listening = false
    local currentKey = default
    
    keybind.MouseEnter:Connect(function()
        TweenService:Create(keybind, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
    end)
    keybind.MouseLeave:Connect(function()
        TweenService:Create(keybind, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(54, 54, 54)}):Play()
    end)
    keybind.MouseButton1Click:Connect(function()
        if not listening then
            listening = true
            keybind.Text = text .. ": Press any key..."
            TweenService:Create(keybind, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(100, 50, 0)}):Play()
            local connection
            connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    currentKey = input.KeyCode
                    keybind.Text = text .. ": " .. tostring(currentKey)
                    TweenService:Create(keybind, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(54, 54, 54)}):Play()
                    listening = false
                    if callback then callback(currentKey) end
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    if TabElements[CurrentTab] then
        table.insert(TabElements[CurrentTab], keybind)
    end
    return keybind
end

local function CreateColorPicker(text, default, callback)
    local container = Instance.new("Frame")
    container.BorderSizePixel = 0
    container.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
    container.Size = UDim2.new(0, 270, 0, 40)
    container.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = container
    label.BorderSizePixel = 0
    label.BackgroundTransparency = 1
    label.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Size = UDim2.new(0, 200, 0, 20)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Text = text
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local colorBtn = Instance.new("TextButton")
    colorBtn.Parent = container
    colorBtn.BorderSizePixel = 0
    colorBtn.TextSize = 12
    colorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    colorBtn.BackgroundColor3 = default or Color3.fromRGB(255, 255, 255)
    colorBtn.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    colorBtn.Size = UDim2.new(0, 50, 0, 24)
    colorBtn.Position = UDim2.new(0, 220, 0, 8)
    colorBtn.Text = ""
    colorBtn.Name = "ColorPicker"
    
    local colorStroke = Instance.new("UIStroke")
    colorStroke.Parent = colorBtn
    colorStroke.Color = Color3.fromRGB(113, 113, 113)
    
    local colorPickerFrame = Instance.new("Frame")
    colorPickerFrame.Parent = container
    colorPickerFrame.BorderSizePixel = 0
    colorPickerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    colorPickerFrame.Size = UDim2.new(0, 220, 0, 0)
    colorPickerFrame.Position = UDim2.new(0, 0, 0, 30)
    colorPickerFrame.Visible = false
    colorPickerFrame.ClipsDescendants = true
    
    local colorPickerStroke = Instance.new("UIStroke")
    colorPickerStroke.Parent = colorPickerFrame
    colorPickerStroke.Color = Color3.fromRGB(113, 113, 113)
    
    local colorGrid = Instance.new("Frame")
    colorGrid.Parent = colorPickerFrame
    colorGrid.BorderSizePixel = 0
    colorGrid.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    colorGrid.Size = UDim2.new(1, -10, 1, -10)
    colorGrid.Position = UDim2.new(0, 5, 0, 5)
    
    local colorGridLayout = Instance.new("UIGridLayout")
    colorGridLayout.Parent = colorGrid
    colorGridLayout.CellSize = UDim2.new(0, 30, 0, 30)
    colorGridLayout.CellPadding = UDim2.new(0, 4, 0, 4)
    colorGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    local colorExpanded = false
    local selectedColor = default or Color3.fromRGB(255, 255, 255)
    
    colorBtn.MouseButton1Click:Connect(function()
        colorExpanded = not colorExpanded
        colorPickerFrame.Visible = true
        local size = colorExpanded and 150 or 0
        TweenService:Create(colorPickerFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 220, 0, size)}):Play()
        TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 270, 0, colorExpanded and 190 or 40)}):Play()
    end)
    
    local colorPresets = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(255, 119, 33),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 255, 255),
        Color3.fromRGB(33, 119, 255),
        Color3.fromRGB(170, 33, 255),
        Color3.fromRGB(255, 33, 170),
        Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(128, 128, 128),
        Color3.fromRGB(0, 0, 0),
        Color3.fromRGB(255, 200, 200)
    }
    
    for _, color in pairs(colorPresets) do
        local colorBtn2 = Instance.new("TextButton")
        colorBtn2.Parent = colorGrid
        colorBtn2.BorderSizePixel = 0
        colorBtn2.BackgroundColor3 = color
        colorBtn2.Size = UDim2.new(0, 30, 0, 30)
        colorBtn2.Text = ""
        colorBtn2.AutoButtonColor = false
        
        local colorBtn2Stroke = Instance.new("UIStroke")
        colorBtn2Stroke.Parent = colorBtn2
        colorBtn2Stroke.Color = Color3.fromRGB(79, 79, 79)
        
        colorBtn2.MouseEnter:Connect(function()
            TweenService:Create(colorBtn2, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 34, 0, 34)}):Play()
        end)
        colorBtn2.MouseLeave:Connect(function()
            TweenService:Create(colorBtn2, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 30, 0, 30)}):Play()
        end)
        colorBtn2.MouseButton1Click:Connect(function()
            selectedColor = color
            colorBtn.BackgroundColor3 = color
            if callback then callback(color) end
            colorExpanded = false
            TweenService:Create(colorPickerFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 220, 0, 0)}):Play()
            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 270, 0, 40)}):Play()
            task.wait(0.3)
            colorPickerFrame.Visible = false
        end)
    end
    
    if TabElements[CurrentTab] then
        table.insert(TabElements[CurrentTab], container)
    end
    return container
end

MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 412, 0, 30)}):Play()
        MinimizeButton.Text = "+"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = originalSize}):Play()
        MinimizeButton.Text = "−"
    end
end)

FullscreenButton.MouseButton1Click:Connect(function()
    fullscreen = not fullscreen
    if fullscreen then
        originalSize = MainFrame.Size
        originalPos = MainFrame.Position
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 500, 0, 400), Position = UDim2.new(0.5, -250, 0.5, -200)}):Play()
        FullscreenButton.Text = "▢"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = originalSize, Position = originalPos}):Play()
        FullscreenButton.Text = "□"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.2)
    ScreenGui:Destroy()
end)

return {
    CreateTab = CreateTab,
    CreateButton = CreateButton,
    CreateToggle = CreateToggle,
    CreateLabel = CreateLabel,
    CreateCopyLabel = CreateCopyLabel,
    CreateDropdown = CreateDropdown,
    CreateSlider = CreateSlider,
    CreateKeybind = CreateKeybind,
    CreateColorPicker = CreateColorPicker,
    ScreenGui = ScreenGui,
    MainFrame = MainFrame,
    ScrollingFrame = ScrollingFrame,
    Tabs = Tabs,
    TabElements = TabElements,
    CurrentTab = CurrentTab,
    ThemeColors = ThemeColors,
    CurrentTheme = CurrentTheme,
    TweenService = TweenService
}

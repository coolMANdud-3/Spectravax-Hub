local ZocryUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/coolMANdud-3/Spectravax-Hub/refs/heads/main/zocryuilib.lua"))()

local MainTab = ZocryUI.CreateTab("Main", 42)

ZocryUI.SetDraggableButton({
    Image = "rbxassetid://123311667009287",
    StrokeColor = Color3.fromRGB(255, 117, 63),
    StrokeThickness = 2,
    Size = UDim2.new(0, 60, 0, 60),
    Position = UDim2.new(0, 38, 0, 98),
    Visible = false
})
ZocryUI.UpdateDraggableButton()

local player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents")
local Events = ReplicatedStorage:FindFirstChild("Events")

local function giveItem(itemName)
    if RemoteEvents and RemoteEvents:FindFirstChild("GiveTool") then
        RemoteEvents.GiveTool:FireServer(itemName)
    elseif Events and Events:FindFirstChild("GiveTool") then
        Events.GiveTool:FireServer(itemName)
    elseif Events and Events:FindFirstChild("Vending") then
        Events.Vending:FireServer(3, itemName, "Armor", "FoxIDM", nil, 1)
    end
end

local function teleportTo(partName)
    local targets = {}
    for _, child in pairs(workspace:GetChildren()) do
        if child.Name:lower():find(partName:lower()) then
            table.insert(targets, child)
        end
    end
    for _, target in pairs(targets) do
        if target:IsA("BasePart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 5, 0)
            return
        elseif target:IsA("Model") and target:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
            return
        end
    end
end

local function instantHeal()
    if RemoteEvents and RemoteEvents:FindFirstChild("Heal") then
        RemoteEvents.Heal:FireServer()
    elseif RemoteEvents and RemoteEvents:FindFirstChild("InstantHeal") then
        RemoteEvents.InstantHeal:FireServer()
    elseif Events and Events:FindFirstChild("Heal") then
        Events.Heal:FireServer()
    elseif player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
    end
end

local function getRole(roleName)
    if RemoteEvents and RemoteEvents:FindFirstChild("BuyRole") then
        RemoteEvents.BuyRole:FireServer(roleName)
    elseif Events and Events:FindFirstChild("BuyRole") then
        Events.BuyRole:FireServer(roleName)
    elseif Events and Events:FindFirstChild("GiveRole") then
        Events.GiveRole:FireServer(roleName)
    end
end

local function killAllEnemies()
    local badGuys = workspace:FindFirstChild("BadGuys")
    if badGuys then
        for _, enemy in pairs(badGuys:GetChildren()) do
            if RemoteEvents and RemoteEvents:FindFirstChild("HitBadguy") then
                RemoteEvents.HitBadguy:FireServer(enemy, 10)
            end
        end
    else
        for _, obj in pairs(workspace:GetChildren()) do
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
                local humanoid = obj:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 and (obj.Name:lower():find("enemy") or obj.Name:lower():find("bad") or obj.Name:lower():find("zombie")) then
                    humanoid.Health = 0
                end
            end
        end
    end
end

ZocryUI.CurrentTab = "Main"
for _, t in pairs(ZocryUI.Tabs) do
    if t.Text == "Main" then
        t.BackgroundColor3 = Color3.fromRGB(255, 119, 33)
    else
        t.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
    end
end

ZocryUI.CreateLabel("ITEM GIVER")
ZocryUI.CreateDropdown("Items", {"Apple", "Cookie", "Pizza", "Bloxy Cola", "Chips", "Lollipop", "MedKit", "Bat", "Sword", "Plank", "Crowbar", "Key", "Battery", "Mask", "Armor", "Cure", "Hammer", "Teddy", "PoisonPizza", "LinkedSword"}, "Apple", function(selected)
    getgenv().SelectedItem = selected
end)
ZocryUI.CreateButton("Get Item", function()
    giveItem(getgenv().SelectedItem or "Apple")
end)

ZocryUI.CreateButton("Instant Heal", function() instantHeal() end)

ZocryUI.CreateLabel("ROLES")
ZocryUI.CreateButton("Get Police", function() getRole("Police") end)
ZocryUI.CreateButton("Get SWAT", function() getRole("SWAT") end)
ZocryUI.CreateButton("Get Medic", function() getRole("Medic") end)

ZocryUI.CreateLabel("TELEPORTS")
ZocryUI.CreateButton("Teleport to House", function() teleportTo("House") end)
ZocryUI.CreateButton("Teleport to Store", function() teleportTo("Store") end)
ZocryUI.CreateButton("Teleport to Basement", function() teleportTo("Basement") end)
ZocryUI.CreateButton("Teleport to Attic", function() teleportTo("Attic") end)
ZocryUI.CreateButton("Teleport to Sewer", function() teleportTo("Sewer") end)
ZocryUI.CreateButton("Teleport to Boss", function() teleportTo("Boss") end)

ZocryUI.CreateLabel("MISCELLANEOUS")
local antiAFK = false
local noClip = false
local infiniteJump = false

ZocryUI.CreateToggle("Anti-AFK", false, function(state)
    antiAFK = state
end)

ZocryUI.CreateToggle("NoClip", false, function(state)
    noClip = state
    if state and player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

ZocryUI.CreateToggle("Infinite Jump", false, function(state)
    infiniteJump = state
end)

ZocryUI.CreateButton("Reset Character", function()
    if player.Character then
        player.Character:BreakJoints()
    end
end)

ZocryUI.CreateButton("Kill All Enemies", function()
    killAllEnemies()
end)

ZocryUI.CreateButton("Walk Speed (High)", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 50
    end
end)

ZocryUI.CreateButton("Walk Speed (Normal)", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
    end
end)

ZocryUI.CreateButton("Jump Power (High)", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = 80
    end
end)

ZocryUI.CreateButton("Jump Power (Normal)", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = 50
    end
end)

spawn(function()
    while task.wait(1) do
        if antiAFK then
            local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:Move(Vector3.new(0, 0, 0.1), true)
                task.wait(0.5)
                humanoid:Move(Vector3.new(0, 0, -0.1), true)
            end
        end
        if noClip and player.Character then
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        if infiniteJump and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            if hrp.Velocity.Y < -1 then
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
            end
        end
    end
end)

for _, child in pairs(ZocryUI.ScrollingFrame:GetChildren()) do
    if child:IsA("TextButton") or child:IsA("TextLabel") or child:IsA("Frame") then
        child.Visible = false
        child.Parent = nil
    end
end

for _, element in pairs(ZocryUI.TabElements["Main"]) do
    element.Visible = true
    element.Parent = ZocryUI.ScrollingFrame
end

return ZocryUI.ScreenGui

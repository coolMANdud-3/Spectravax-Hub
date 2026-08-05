local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Spectravax Hub (SIMPLE)",
   Icon = aperture,
   LoadingTitle = "Loading the script...",
   LoadingSubtitle = "By SpectravaxREBORN.",
   Theme = "Default",
   DisableRayfieldPrompts = true,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "ScaryTeacherFarm",
      FileName = "Settings"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Spectravax Hub",
      Subtitle = "Key Required.",
      Note = "Get key at coolmandud-3.github.io.",
      FileName = "Key",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"Specting"}
   }
})

local items = {
    {pos = Vector3.new(250.65, 21.52, 93.48), name = "Flare Gun", keywords = {"flare"}, category = "Weapons"},
    {pos = Vector3.new(272.59, -31.34, -15.14), name = "Crowbar", keywords = {"crowbar"}, category = "Weapons"},
    {pos = Vector3.new(232.69, -30.81, -15.81), name = "Flashbang", keywords = {"flashbang", "flash", "bang", "grenade"}, category = "Weapons"},
    {pos = Vector3.new(307.91, 13.52, 80.72), name = "Sword", keywords = {"sword", "blade", "katana", "weapon"}, category = "Weapons"},
    {pos = Vector3.new(248.57, 32.63, 168.86), name = "Dynamite", keywords = {"dynamite", "dyna", "get", "explosive"}, category = "Weapons"},
    {pos = Vector3.new(415.73, 29.53, 191.10), name = "Balloon", keywords = {"balloon"}, category = "Items"},
    {pos = Vector3.new(243.28, -26.14, 23.34), name = "Minecraft Torch", keywords = {"minecraft", "torch", "mine", "craft"}, category = "Items"},
    {pos = Vector3.new(350.68, 11.94, 267.24), name = "Spray Paint", keywords = {"spray", "paint", "spraypaint", "can"}, category = "Items"},
    {pos = Vector3.new(338.24, 7.23, -12.58), name = "Teddy", keywords = {"teddy", "bear", "teddybear"}, category = "Items"},
    {pos = Vector3.new(275.63, 33.65, 68.72), name = "Landmine", keywords = {"landmine", "land", "mine", "land_mine"}, category = "Items"},
    {pos = Vector3.new(302.52, 32.46, 160.28), name = "Scissors", keywords = {"scissors", "scissor", "get", "cut"}, category = "Items"},
    {pos = Vector3.new(322.21, 58.35, 148.02), name = "Speed Coil", keywords = {"speed", "coil", "speedcoil", "get"}, category = "Items"},
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

local function teleportToPosition(pos)
    local char = player.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    root.CFrame = CFrame.new(pos)
    wait(0.05)
    return true
end

local function collectItemAtPosition(pos, keywords)
    local threshold = 10
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local dist = (obj.Position - pos).Magnitude
            if dist < threshold then
                local name = obj.Name:lower()
                local found = false
                for _, keyword in ipairs(keywords) do
                    if name:find(string.lower(keyword)) then
                        found = true
                        break
                    end
                end
                if found then
                    local detector = obj:FindFirstChild("ClickDetector")
                    if detector then
                        fireclickdetector(detector)
                        return true
                    else
                        for _, child in ipairs(obj:GetChildren()) do
                            if child:IsA("ClickDetector") then
                                fireclickdetector(child)
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("ClickDetector") then
            local parent = obj.Parent
            if parent and parent:IsA("BasePart") then
                local dist = (parent.Position - pos).Magnitude
                if dist < threshold then
                    fireclickdetector(obj)
                    return true
                end
            end
        end
    end
    return false
end

local function collectAllItems()
    for i, item in ipairs(items) do
        if teleportToPosition(item.pos) then
            wait(0.05)
            collectItemAtPosition(item.pos, item.keywords)
        end
        if i < #items then
            wait(0.1)
        end
    end
end

local MainTab = Window:CreateTab("Main", home)

MainTab:CreateLabel("Made by Spectravax")

MainTab:CreateButton({
   Name = "Get All Items",
   Description = "Collect all items once",
   Callback = function()
        collectAllItems()
    end
})

local ItemsTab = Window:CreateTab("Items", burger)

local function createItemButtons(category)
    local categoryItems = {}
    for _, item in ipairs(items) do
        if item.category == category then
            table.insert(categoryItems, item)
        end
    end
    for i, item in ipairs(categoryItems) do
        ItemsTab:CreateButton({
            Name = item.name,
            Callback = function()
                teleportToPosition(item.pos)
            end
        })
    end
end

ItemsTab:CreateLabel("Weapons")
createItemButtons("Weapons")

ItemsTab:CreateLabel("Items")
createItemButtons("Items")

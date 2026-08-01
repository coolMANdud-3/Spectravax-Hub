local LMG2L = {};

LMG2L["ScreenGui_1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
LMG2L["ScreenGui_1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

LMG2L["MainFrame_2"] = Instance.new("Frame", LMG2L["ScreenGui_1"]);
LMG2L["MainFrame_2"]["BorderSizePixel"] = 0;
LMG2L["MainFrame_2"]["BackgroundColor3"] = Color3.fromRGB(21, 21, 21);
LMG2L["MainFrame_2"]["Size"] = UDim2.new(0, 394, 0, 264);
LMG2L["MainFrame_2"]["Position"] = UDim2.new(0, 216, 0, 20);
LMG2L["MainFrame_2"]["Name"] = [[MainFrame]];
LMG2L["MainFrame_2"]["Active"] = true;
LMG2L["MainFrame_2"]["Draggable"] = true;

LMG2L["UIStroke_3"] = Instance.new("UIStroke", LMG2L["MainFrame_2"]);
LMG2L["UIStroke_3"]["Thickness"] = 2;
LMG2L["UIStroke_3"]["Color"] = Color3.fromRGB(255, 136, 15);

LMG2L["KeySystemFrame_4"] = Instance.new("Frame", LMG2L["MainFrame_2"]);
LMG2L["KeySystemFrame_4"]["BorderSizePixel"] = 0;
LMG2L["KeySystemFrame_4"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["KeySystemFrame_4"]["Size"] = UDim2.new(0, 204, 0, 212);
LMG2L["KeySystemFrame_4"]["Position"] = UDim2.new(0, 6, 0, 46);
LMG2L["KeySystemFrame_4"]["Name"] = [[KeySystemFrame]];

LMG2L["UIStroke_5"] = Instance.new("UIStroke", LMG2L["KeySystemFrame_4"]);
LMG2L["UIStroke_5"]["Thickness"] = 2;
LMG2L["UIStroke_5"]["Color"] = Color3.fromRGB(35, 35, 35);

LMG2L["Title_6"] = Instance.new("TextLabel", LMG2L["MainFrame_2"]);
LMG2L["Title_6"]["TextWrapped"] = true;
LMG2L["Title_6"]["BorderSizePixel"] = 0;
LMG2L["Title_6"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LMG2L["Title_6"]["TextScaled"] = true;
LMG2L["Title_6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Title_6"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["Title_6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Title_6"]["BackgroundTransparency"] = 1;
LMG2L["Title_6"]["Size"] = UDim2.new(0, 384, 0, 36);
LMG2L["Title_6"]["Text"] = [[Spectravax Hub]];
LMG2L["Title_6"]["Name"] = [[Title]];
LMG2L["Title_6"]["Position"] = UDim2.new(0, 4, 0, 4);

LMG2L["FrameDescription_7"] = Instance.new("Frame", LMG2L["MainFrame_2"]);
LMG2L["FrameDescription_7"]["BorderSizePixel"] = 0;
LMG2L["FrameDescription_7"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["FrameDescription_7"]["Size"] = UDim2.new(0, 170, 0, 212);
LMG2L["FrameDescription_7"]["Position"] = UDim2.new(0, 218, 0, 46);
LMG2L["FrameDescription_7"]["Name"] = [[FrameDescription]];

LMG2L["UIStroke_8"] = Instance.new("UIStroke", LMG2L["FrameDescription_7"]);
LMG2L["UIStroke_8"]["Thickness"] = 2;
LMG2L["UIStroke_8"]["Color"] = Color3.fromRGB(35, 35, 35);

LMG2L["Description_9"] = Instance.new("TextLabel", LMG2L["FrameDescription_7"]);
LMG2L["Description_9"]["TextWrapped"] = true;
LMG2L["Description_9"]["BorderSizePixel"] = 0;
LMG2L["Description_9"]["TextScaled"] = true;
LMG2L["Description_9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Description_9"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["Description_9"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Description_9"]["BackgroundTransparency"] = 1;
LMG2L["Description_9"]["Size"] = UDim2.new(0, 104, 0, 18);
LMG2L["Description_9"]["Text"] = [[Enter your key to access the hub.]];
LMG2L["Description_9"]["Name"] = [[Description]];
LMG2L["Description_9"]["Position"] = UDim2.new(0, 0, 0, 2);

LMG2L["GetButton_c"] = Instance.new("TextButton", LMG2L["MainFrame_2"]);
LMG2L["GetButton_c"]["TextWrapped"] = true;
LMG2L["GetButton_c"]["BorderSizePixel"] = 0;
LMG2L["GetButton_c"]["TextSize"] = 13;
LMG2L["GetButton_c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["GetButton_c"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["GetButton_c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["GetButton_c"]["Size"] = UDim2.new(0, 88, 0, 28);
LMG2L["GetButton_c"]["Text"] = [[Get Key]];
LMG2L["GetButton_c"]["Name"] = [[GetButton]];
LMG2L["GetButton_c"]["Position"] = UDim2.new(0, 10, 0, 226);

LMG2L["UIStroke_d"] = Instance.new("UIStroke", LMG2L["GetButton_c"]);
LMG2L["UIStroke_d"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
LMG2L["UIStroke_d"]["Thickness"] = 2;
LMG2L["UIStroke_d"]["Color"] = Color3.fromRGB(141, 141, 141);

LMG2L["TextBox_e"] = Instance.new("TextBox", LMG2L["MainFrame_2"]);
LMG2L["TextBox_e"]["PlaceholderColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["TextBox_e"]["BorderSizePixel"] = 0;
LMG2L["TextBox_e"]["TextWrapped"] = true;
LMG2L["TextBox_e"]["TextSize"] = 13;
LMG2L["TextBox_e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["TextBox_e"]["BackgroundColor3"] = Color3.fromRGB(21, 21, 21);
LMG2L["TextBox_e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["TextBox_e"]["Size"] = UDim2.new(0, 196, 0, 56);
LMG2L["TextBox_e"]["Position"] = UDim2.new(0, 10, 0, 50);
LMG2L["TextBox_e"]["Text"] = [[]];
LMG2L["TextBox_e"]["PlaceholderText"] = "Enter your key here...";

LMG2L["UIStroke_f"] = Instance.new("UIStroke", LMG2L["TextBox_e"]);
LMG2L["UIStroke_f"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
LMG2L["UIStroke_f"]["Thickness"] = 2;
LMG2L["UIStroke_f"]["Color"] = Color3.fromRGB(141, 141, 141);

LMG2L["VerifyButton_10"] = Instance.new("TextButton", LMG2L["MainFrame_2"]);
LMG2L["VerifyButton_10"]["TextWrapped"] = true;
LMG2L["VerifyButton_10"]["BorderSizePixel"] = 0;
LMG2L["VerifyButton_10"]["TextSize"] = 13;
LMG2L["VerifyButton_10"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["VerifyButton_10"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["VerifyButton_10"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["VerifyButton_10"]["Size"] = UDim2.new(0, 196, 0, 28);
LMG2L["VerifyButton_10"]["Text"] = [[Verify Key]];
LMG2L["VerifyButton_10"]["Name"] = [[VerifyButton]];
LMG2L["VerifyButton_10"]["Position"] = UDim2.new(0, 10, 0, 116);

LMG2L["UIStroke_11"] = Instance.new("UIStroke", LMG2L["VerifyButton_10"]);
LMG2L["UIStroke_11"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
LMG2L["UIStroke_11"]["Thickness"] = 2;
LMG2L["UIStroke_11"]["Color"] = Color3.fromRGB(141, 141, 141);

LMG2L["Notice_12"] = Instance.new("TextLabel", LMG2L["MainFrame_2"]);
LMG2L["Notice_12"]["TextWrapped"] = true;
LMG2L["Notice_12"]["BorderSizePixel"] = 0;
LMG2L["Notice_12"]["TextSize"] = 9;
LMG2L["Notice_12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Notice_12"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["Notice_12"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Notice_12"]["BackgroundTransparency"] = 1;
LMG2L["Notice_12"]["Size"] = UDim2.new(0, 100, 0, 18);
LMG2L["Notice_12"]["Text"] = [[This Key System is made by SpectravaxREBORN.]];
LMG2L["Notice_12"]["Name"] = [[Notice]];
LMG2L["Notice_12"]["Position"] = UDim2.new(0, 286, 0, 236);

LMG2L["CloseButton_13"] = Instance.new("ImageButton", LMG2L["MainFrame_2"]);
LMG2L["CloseButton_13"]["BorderSizePixel"] = 0;
LMG2L["CloseButton_13"]["BackgroundTransparency"] = 1;
LMG2L["CloseButton_13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["CloseButton_13"]["Image"] = [[rbxassetid://117081647256543]];
LMG2L["CloseButton_13"]["Size"] = UDim2.new(0, 34, 0, 34);
LMG2L["CloseButton_13"]["Name"] = [[CloseButton]];
LMG2L["CloseButton_13"]["Position"] = UDim2.new(0, 358, 0, 4);

LMG2L.Settings = {
    Colors = {
        MainFrame = Color3.fromRGB(21, 21, 21),
        Accent = Color3.fromRGB(255, 136, 15),
        AccentStroke = Color3.fromRGB(255, 136, 15),
        Frame = Color3.fromRGB(0, 0, 0),
        FrameStroke = Color3.fromRGB(35, 35, 35),
        Text = Color3.fromRGB(255, 255, 255),
        Button = Color3.fromRGB(0, 0, 0),
        ButtonStroke = Color3.fromRGB(141, 141, 141),
        TextBox = Color3.fromRGB(21, 21, 21),
        TextBoxStroke = Color3.fromRGB(141, 141, 141),
        Success = Color3.fromRGB(0, 255, 0),
        Error = Color3.fromRGB(255, 0, 0)
    },
    KeyLink = "https://example.com/getkey",
    ScriptLink = "",
    ValidKeys = {"1416", "SPECTRAVAX-2024", "VIP-ACCESS", "DEVELOPER-KEY"},
    SaveFileName = "Spectravax_Key.txt"
}

local function SetTitle(text)
    LMG2L["Title_6"].Text = text
end

local function SetDescription(text)
    LMG2L["Description_9"].Text = text
end

local function SetNotice(text)
    LMG2L["Notice_12"].Text = text
end

local function SetPlaceholder(text)
    LMG2L["TextBox_e"].PlaceholderText = text
end

local function GetKey()
    return LMG2L["TextBox_e"].Text
end

local function SetKey(text)
    LMG2L["TextBox_e"].Text = text
end

local function ShowStatus(message, isSuccess)
    local keySystemFrame = LMG2L["KeySystemFrame_4"]
    local statusLabel = keySystemFrame:FindFirstChild("StatusLabel")
    if not statusLabel then
        statusLabel = Instance.new("TextLabel")
        statusLabel.Parent = keySystemFrame
        statusLabel.BorderSizePixel = 0
        statusLabel.BackgroundTransparency = 1
        statusLabel.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        statusLabel.TextSize = 13
        statusLabel.Size = UDim2.new(0, 190, 0, 20)
        statusLabel.Position = UDim2.new(0, 5, 0, 150)
        statusLabel.TextWrapped = true
        statusLabel.TextXAlignment = Enum.TextXAlignment.Left
        statusLabel.Name = "StatusLabel"
    end
    statusLabel.Text = message
    statusLabel.TextColor3 = isSuccess and LMG2L.Settings.Colors.Success or LMG2L.Settings.Colors.Error
end

local function ClearStatus()
    local keySystemFrame = LMG2L["KeySystemFrame_4"]
    local statusLabel = keySystemFrame:FindFirstChild("StatusLabel")
    if statusLabel then
        statusLabel.Text = ""
    end
end

local function CloseUI()
    LMG2L["ScreenGui_1"]:Destroy()
end

local function CopyKeyToClipboard()
    local key = LMG2L["TextBox_e"].Text
    if key ~= "" then
        setclipboard(key)
        ShowStatus("Key copied to clipboard!", true)
        task.wait(1.5)
        ClearStatus()
    else
        ShowStatus("Nothing to copy!", false)
        task.wait(1.5)
        ClearStatus()
    end
end

local function OpenKeyLink()
    if LMG2L.Settings.KeyLink and LMG2L.Settings.KeyLink ~= "" then
        setclipboard(LMG2L.Settings.KeyLink)
        ShowStatus("Key link copied to clipboard!", true)
        task.wait(1.5)
        ClearStatus()
    else
        ShowStatus("No key link set!", false)
        task.wait(1.5)
        ClearStatus()
    end
end

local function SetKeyLink(link)
    LMG2L.Settings.KeyLink = link
end

local function SetScriptLink(link)
    LMG2L.Settings.ScriptLink = link
end

local function SetValidKeys(keys)
    LMG2L.Settings.ValidKeys = keys
end

local function AddValidKey(key)
    table.insert(LMG2L.Settings.ValidKeys, key)
end

local function RemoveValidKey(key)
    for i, v in pairs(LMG2L.Settings.ValidKeys) do
        if v == key then
            table.remove(LMG2L.Settings.ValidKeys, i)
            break
        end
    end
end

local function ValidateKey(key)
    for _, validKey in pairs(LMG2L.Settings.ValidKeys) do
        if key == validKey then
            return true
        end
    end
    return false
end

local function SetColors(colors)
    if colors.MainFrame then
        LMG2L["MainFrame_2"].BackgroundColor3 = colors.MainFrame
        LMG2L.Settings.Colors.MainFrame = colors.MainFrame
    end
    if colors.Accent then
        LMG2L["UIStroke_3"].Color = colors.Accent
        LMG2L.Settings.Colors.Accent = colors.Accent
        LMG2L.Settings.Colors.AccentStroke = colors.Accent
    end
    if colors.Frame then
        LMG2L["KeySystemFrame_4"].BackgroundColor3 = colors.Frame
        LMG2L["FrameDescription_7"].BackgroundColor3 = colors.Frame
        LMG2L.Settings.Colors.Frame = colors.Frame
    end
    if colors.FrameStroke then
        LMG2L["UIStroke_5"].Color = colors.FrameStroke
        LMG2L["UIStroke_8"].Color = colors.FrameStroke
        LMG2L.Settings.Colors.FrameStroke = colors.FrameStroke
    end
    if colors.Text then
        LMG2L["Title_6"].TextColor3 = colors.Text
        LMG2L["Description_9"].TextColor3 = colors.Text
        LMG2L["Notice_12"].TextColor3 = colors.Text
        LMG2L["TextBox_e"].TextColor3 = colors.Text
        LMG2L["GetButton_c"].TextColor3 = colors.Text
        LMG2L["VerifyButton_10"].TextColor3 = colors.Text
        LMG2L.Settings.Colors.Text = colors.Text
    end
    if colors.Button then
        LMG2L["GetButton_c"].BackgroundColor3 = colors.Button
        LMG2L["VerifyButton_10"].BackgroundColor3 = colors.Button
        LMG2L.Settings.Colors.Button = colors.Button
    end
    if colors.ButtonStroke then
        LMG2L["UIStroke_d"].Color = colors.ButtonStroke
        LMG2L["UIStroke_11"].Color = colors.ButtonStroke
        LMG2L.Settings.Colors.ButtonStroke = colors.ButtonStroke
    end
    if colors.TextBox then
        LMG2L["TextBox_e"].BackgroundColor3 = colors.TextBox
        LMG2L.Settings.Colors.TextBox = colors.TextBox
    end
    if colors.TextBoxStroke then
        LMG2L["UIStroke_f"].Color = colors.TextBoxStroke
        LMG2L.Settings.Colors.TextBoxStroke = colors.TextBoxStroke
    end
    if colors.Success then
        LMG2L.Settings.Colors.Success = colors.Success
    end
    if colors.Error then
        LMG2L.Settings.Colors.Error = colors.Error
    end
end

local function ResetColors()
    SetColors({
        MainFrame = Color3.fromRGB(21, 21, 21),
        Accent = Color3.fromRGB(255, 136, 15),
        Frame = Color3.fromRGB(0, 0, 0),
        FrameStroke = Color3.fromRGB(35, 35, 35),
        Text = Color3.fromRGB(255, 255, 255),
        Button = Color3.fromRGB(0, 0, 0),
        ButtonStroke = Color3.fromRGB(141, 141, 141),
        TextBox = Color3.fromRGB(21, 21, 21),
        TextBoxStroke = Color3.fromRGB(141, 141, 141),
        Success = Color3.fromRGB(0, 255, 0),
        Error = Color3.fromRGB(255, 0, 0)
    })
end

LMG2L["GetButton_c"].MouseButton1Click:Connect(function()
    CopyKeyToClipboard()
end)

LMG2L["VerifyButton_10"].MouseButton1Click:Connect(function()
    local key = LMG2L["TextBox_e"].Text
    if key == "" then
        ShowStatus("Please enter a key!", false)
        return
    end
    
    if ValidateKey(key) then
        ShowStatus("Key verified! Loading...", true)
        if LMG2L.Settings.ScriptLink and LMG2L.Settings.ScriptLink ~= "" then
            local success, err = pcall(function()
                loadstring(LMG2L.Settings.ScriptLink)()
            end)
            if not success then
                warn("Failed to load script: " .. tostring(err))
            end
        end
        task.wait(1)
        ClearStatus()
        CloseUI()
    else
        ShowStatus("Invalid key! Please try again.", false)
        task.wait(1.5)
        ClearStatus()
    end
end)

LMG2L["CloseButton_13"].MouseButton1Click:Connect(function()
    CloseUI()
end)

local dragging = false
local dragStart
local startPos

LMG2L["MainFrame_2"].InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = LMG2L["MainFrame_2"].Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        LMG2L["MainFrame_2"].Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

return LMG2L["ScreenGui_1"], require, {
    SetTitle = SetTitle,
    SetDescription = SetDescription,
    SetNotice = SetNotice,
    SetPlaceholder = SetPlaceholder,
    GetKey = GetKey,
    SetKey = SetKey,
    ValidateKey = ValidateKey,
    ShowStatus = ShowStatus,
    ClearStatus = ClearStatus,
    CloseUI = CloseUI,
    CopyKeyToClipboard = CopyKeyToClipboard,
    OpenKeyLink = OpenKeyLink,
    SetKeyLink = SetKeyLink,
    SetScriptLink = SetScriptLink,
    SetValidKeys = SetValidKeys,
    AddValidKey = AddValidKey,
    RemoveValidKey = RemoveValidKey,
    SetColors = SetColors,
    ResetColors = ResetColors,
    Settings = LMG2L.Settings
}

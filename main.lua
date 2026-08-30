-- Bu scripti StarterPlayerScripts içine bir LocalScript olarak ekleyin.

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("KaijuHubGui") then return end

-- ==================== VERİLER ====================
local tabData = {
    Main = {
        Title = "✨ Main Features",
        Items = {
            "No bat Cool down",
            "No Grab Cool Down",
            "+1-2 Sec Cooldown Almost Any Tool",
            "+Walkspeed",
            "Anti Ragdoll",
            "Character Scripts",
            "Killing Aura",
            "No Blackout!",
            "Server Descriptions",
            "Private Server Commands",
            "Game Settings GUI",
            "Instant Transform-style Effect"
        }
    },
    Fishing = {
        Title = "🎣 Fishing",
        Items = {"Fishing Rod", "Bait", "Catch Rates", "Fish Types", "Legendary Fish", "Fishing Spots"}
    },
    Teleport = {
        Title = "🌍 Teleport",
        Items = {"Spawn", "Shop", "Arena", "Island", "Hideout", "Mountain"}
    },
    Player = {
        Title = "👤 Player",
        Items = {"Stats", "Inventory", "Skills", "Pets", "Badges", "Achievements"}
    },
    Settings = {
        Title = "⚙️ Settings",
        Items = {"Volume", "Graphics", "Controls", "Accessibility", "Reset Character", "Keybinds"}
    }
}

-- ==================== ANA GUI ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KaijuHubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- ==================== ANA FRAME (Pembemsi arka plan) ====================
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 520, 0, 420)  -- Daha küçük
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -210)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 200, 210) -- Pembemsi
mainFrame.BackgroundTransparency = 0.95 -- Hafif saydam
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Gölge efekti (arka plana)
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316049533" -- Roblox gölge efekti
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.6
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 10, 10)
shadow.Parent = mainFrame

-- Köşe yuvarlama
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- ==================== BAŞLIK ÇUBUĞU (Sürüklemek için) ====================
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 150, 170)
titleBar.BackgroundTransparency = 0.2
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
local titleBarCorner = Instance.new("UICorner")
titleBarCorner.CornerRadius = UDim.new(0, 12)
titleBarCorner.Parent = titleBar

-- Başlık yazısı
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🌸 Kaiju Paradise HUB"
titleLabel.TextColor3 = Color3.fromRGB(80, 30, 50)
titleLabel.TextSize = 22
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Kapatma butonu (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 70, 90)
closeBtn.BackgroundTransparency = 0.5
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn
closeBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- ==================== SÜRÜKLEME (Dragging) ====================
local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

userInputService = game:GetService("UserInputService")
userInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ==================== SOL SIDEBAR ====================
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 130, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(255, 180, 195)
sidebar.BackgroundTransparency = 0.3
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

-- ==================== SIDEBAR BUTONLARI (Kalın font) ====================
local buttonNames = {"Main", "Fishing", "Teleport", "Player", "Settings"}
local buttons = {}

for i, name in ipairs(buttonNames) do
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.85, 0, 0, 38)
    btn.Position = UDim2.new(0.075, 0, 0, 12 + (i-1)*48)
    btn.BackgroundColor3 = Color3.fromRGB(255, 210, 220)
    btn.BackgroundTransparency = 0.6
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(70, 30, 45)
    btn.TextSize = 18
    btn.Font = Enum.Font.GothamBold  -- Kalın font
    btn.Parent = sidebar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        if btn.BackgroundColor3 ~= Color3.fromRGB(255, 120, 150) then
            btn.BackgroundColor3 = Color3.fromRGB(255, 190, 210)
        end
    end)
    btn.MouseLeave:Connect(function()
        if btn.BackgroundColor3 ~= Color3.fromRGB(255, 120, 150) then
            btn.BackgroundColor3 = Color3.fromRGB(255, 210, 220)
        end
    end)
    
    buttons[name] = btn
end

-- ==================== SAĞ İÇERİK ALANI ====================
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, -130, 1, -40)
contentArea.Position = UDim2.new(0, 130, 0, 40)
contentArea.BackgroundTransparency = 1
contentArea.Parent = mainFrame

-- Başlık
local contentTitle = Instance.new("TextLabel")
contentTitle.Name = "ContentTitle"
contentTitle.Size = UDim2.new(1, -20, 0, 35)
contentTitle.Position = UDim2.new(0, 10, 0, 8)
contentTitle.BackgroundTransparency = 1
contentTitle.Text = "✨ Main Features"
contentTitle.TextColor3 = Color3.fromRGB(80, 30, 50)
contentTitle.TextSize = 26
contentTitle.Font = Enum.Font.GothamBold
contentTitle.TextXAlignment = Enum.TextXAlignment.Left
contentTitle.Parent = contentArea

-- ScrollingFrame
local featureList = Instance.new("ScrollingFrame")
featureList.Name = "FeatureList"
featureList.Size = UDim2.new(1, -20, 1, -60)
featureList.Position = UDim2.new(0, 10, 0, 48)
featureList.BackgroundTransparency = 1
featureList.BorderSizePixel = 0
featureList.ScrollBarThickness = 5
featureList.CanvasSize = UDim2.new(0, 0, 0, 400)
featureList.Parent = contentArea

-- ==================== İÇERİK GÜNCELLEME ====================
local function updateContent(tabName)
    local data = tabData[tabName]
    if not data then return end
    
    contentTitle.Text = data.Title
    
    for _, child in ipairs(featureList:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end
    
    local yPos = 5
    for _, itemText in ipairs(data.Items) do
        local item = Instance.new("TextLabel")
        item.Size = UDim2.new(1, -10, 0, 26)
        item.Position = UDim2.new(0, 5, 0, yPos)
        item.BackgroundTransparency = 1
        item.Text = "🌸 " .. itemText
        item.TextColor3 = Color3.fromRGB(50, 20, 35)
        item.TextSize = 17
        item.Font = Enum.Font.SourceSans  -- İçerik metni okunaklı
        item.TextXAlignment = Enum.TextXAlignment.Left
        item.TextYAlignment = Enum.TextYAlignment.Top
        item.Parent = featureList
        yPos = yPos + 30
    end
    
    featureList.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
    
    -- Buton vurgulama
    for name, btn in pairs(buttons) do
        if name == tabName then
            btn.BackgroundColor3 = Color3.fromRGB(255, 120, 150)
            btn.BackgroundTransparency = 0.2
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            btn.BackgroundColor3 = Color3.fromRGB(255, 210, 220)
            btn.BackgroundTransparency = 0.6
            btn.TextColor3 = Color3.fromRGB(70, 30, 45)
        end
    end
end

-- ==================== BUTON TIKLAMALARI ====================
for name, btn in pairs(buttons) do
    btn.MouseButton1Click:Connect(function()
        updateContent(name)
    end)
end

-- ==================== AÇILIŞ ANİMASYONU ====================
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundTransparency = 1

game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 520, 0, 420),
    Position = UDim2.new(0.5, -260, 0.5, -210),
    BackgroundTransparency = 0.05
}):Play()

-- ==================== İLK SEKME ====================
updateContent("Main")

-- ==================== AÇ/KAPA (K tuşu) ====================
local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        if screenGui.Enabled then
            -- Kapatma animasyonu
            game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                BackgroundTransparency = 1
            }):Play()
            task.wait(0.2)
            screenGui.Enabled = false
        else
            screenGui.Enabled = true
            -- Açılma animasyonu (tekrar)
            mainFrame.Size = UDim2.new(0, 0, 0, 0)
            mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            mainFrame.BackgroundTransparency = 1
            game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 520, 0, 420),
                Position = UDim2.new(0.5, -260, 0.5, -210),
                BackgroundTransparency = 0.05
            }):Play()
        end
    end
end)

print("🌸 Kaiju Paradise HUB (Yenilenmiş) yüklendi! K tuşuyla aç/kapa.")

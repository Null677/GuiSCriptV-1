-- Bu scripti StarterPlayerScripts içinde bir LocalScript'e yapıştır.
-- GUI, oyuncu spawn olduğunda otomatik oluşur ve kalıcıdır.

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Aynı GUI'den iki kez oluşmasın diye kontrol
if playerGui:FindFirstChild("KaijuHubGui") then
    return
end

-- ==================== VERİLER ====================
local tabData = {
    Main = {
        Title = "Main Features",
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
        Title = "Fishing",
        Items = {"Fishing Rod", "Bait", "Catch Rates", "Fish Types", "Legendary Fish", "Fishing Spots"}
    },
    Teleport = {
        Title = "Teleport",
        Items = {"Spawn", "Shop", "Arena", "Island", "Hideout", "Mountain"}
    },
    Player = {
        Title = "Player",
        Items = {"Stats", "Inventory", "Skills", "Pets", "Badges", "Achievements"}
    },
    Settings = {
        Title = "Settings",
        Items = {"Volume", "Graphics", "Controls", "Accessibility", "Reset Character", "Keybinds"}
    }
}

-- ==================== ANA GUI ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KaijuHubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- ==================== ANA ÇERÇEVE ====================
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 650, 0, 480)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -240)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Köşe yuvarlama (UICorner)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- ==================== SOL SIDEBAR ====================
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 160, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

-- Sidebar köşesi (sadece sol üst için, ama tümüne uygulanabilir)
local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 8) -- Ana frame ile uyumlu
sidebarCorner.Parent = sidebar

-- ==================== SIDEBAR BUTONLARI ====================
local buttonNames = {"Main", "Fishing", "Teleport", "Player", "Settings"}
local buttons = {} -- Butonları saklamak için

for i, name in ipairs(buttonNames) do
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.85, 0, 0, 40)
    btn.Position = UDim2.new(0.075, 0, 0, 15 + (i - 1) * 55)
    btn.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
    btn.BackgroundTransparency = 0
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 20
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = sidebar
    
    -- Buton köşe yuvarlama
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    -- Hover efekti (fare ile üzerine gelince)
    btn.MouseEnter:Connect(function()
        if btn.BackgroundColor3 ~= Color3.fromRGB(255, 170, 0) then -- aktif değilse
            btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end
    end)
    btn.MouseLeave:Connect(function()
        if btn.BackgroundColor3 ~= Color3.fromRGB(255, 170, 0) then
            btn.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
        end
    end)
    
    buttons[name] = btn
end

-- ==================== SAĞ İÇERİK ALANI ====================
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, -160, 1, 0)
contentArea.Position = UDim2.new(0, 160, 0, 0)
contentArea.BackgroundTransparency = 1
contentArea.Parent = mainFrame

-- Başlık (Title)
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -20, 0, 45)
titleLabel.Position = UDim2.new(0, 10, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Main Features"
titleLabel.TextColor3 = Color3.fromRGB(255, 170, 0)
titleLabel.TextSize = 32
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = contentArea

-- Kaydırılabilir Özellik Listesi (ScrollingFrame)
local featureList = Instance.new("ScrollingFrame")
featureList.Name = "FeatureList"
featureList.Size = UDim2.new(1, -20, 1, -80)
featureList.Position = UDim2.new(0, 10, 0, 60)
featureList.BackgroundTransparency = 1
featureList.BorderSizePixel = 0
featureList.ScrollBarThickness = 6
featureList.CanvasSize = UDim2.new(0, 0, 0, 400) -- Dinamik olarak güncellenecek
featureList.Parent = contentArea

-- ==================== İÇERİK GÜNCELLEME FONKSİYONU ====================
local function updateContent(tabName)
    local data = tabData[tabName]
    if not data then return end
    
    -- 1. Başlığı güncelle
    titleLabel.Text = data.Title
    
    -- 2. Eski öğeleri temizle (TextLabel'ları sil)
    for _, child in ipairs(featureList:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    
    -- 3. Yeni öğeleri oluştur
    local yPos = 5
    for _, itemText in ipairs(data.Items) do
        local itemLabel = Instance.new("TextLabel")
        itemLabel.Size = UDim2.new(1, -10, 0, 28)
        itemLabel.Position = UDim2.new(0, 5, 0, yPos)
        itemLabel.BackgroundTransparency = 1
        itemLabel.Text = "• " .. itemText
        itemLabel.TextColor3 = Color3.fromRGB(210, 210, 210)
        itemLabel.TextSize = 19
        itemLabel.Font = Enum.Font.SourceSans
        itemLabel.TextXAlignment = Enum.TextXAlignment.Left
        itemLabel.TextYAlignment = Enum.TextYAlignment.Top
        itemLabel.Parent = featureList
        yPos = yPos + 32
    end
    
    -- 4. CanvasSize'ı güncelle (kaydırma alanı boyutu)
    featureList.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
    
    -- 5. Sidebar'daki aktif butonu vurgula
    for name, btn in pairs(buttons) do
        if name == tabName then
            btn.BackgroundColor3 = Color3.fromRGB(255, 170, 0) -- Sarı vurgu
            btn.TextColor3 = Color3.fromRGB(0, 0, 0) -- Siyah yazı
        else
            btn.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
end

-- ==================== BUTON TIKLAMA OLAYLARI ====================
for name, btn in pairs(buttons) do
    btn.MouseButton1Click:Connect(function()
        updateContent(name)
    end)
end

-- ==================== BAŞLANGIÇTA "MAIN" SEKMESİNİ GÖSTER ====================
updateContent("Main")

-- ==================== (İSTEĞE BAĞLI) GUI'Yİ KAPA/AÇ KISAYOLU ====================
local userInput = game:GetService("UserInputService")
userInput.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

print("Kaiju Paradise HUB GUI başarıyla yüklendi! (K tuşuyla aç/kapa)")

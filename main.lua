-- NullxHIGH Blox Fruits | LUCK BOOST + SERVER HOP + 100% SÜRÜKLENİR
if game.PlaceId ~= 2753915549 and game.PlaceId ~= 4442272183 and game.PlaceId ~= 7449423635 then return end

local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local desiredFruits = { "Kitsune", "Dragon", "Leopard", "T-Rex", "Venom", "Dough", "Mammoth" }

local function hopServer()
    pcall(function()
        local PlaceId = game.PlaceId
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for _, v in pairs(servers.data) do
            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(PlaceId, v.id, player)
                return
            end
        end
        TeleportService:Teleport(PlaceId, player)
    end)
end

-- GUI
local sg = Instance.new("ScreenGui")
sg.Name = "NullxHIGH"
sg.ResetOnSpawn = false
sg.Parent = pgui

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 312, 0, 62)
frame.Position = UDim2.new(0.5, -156, 0, 15)
frame.BackgroundColor3 = Color3.new(1,1,1)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)

-- Rainbow border
local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 3
spawn(function()
    while wait(0.03) do
        stroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    end
end)

-- Rainbow text funksiyası
local function rb(t)
    spawn(function()
        local h = 0
        while t.Parent do
            t.TextColor3 = Color3.fromHSV(h,1,1)
            h = (h + 0.01) % 1
            wait(0.03)
        end
    end)
end

local made = Instance.new("TextLabel", frame)
made.Size = UDim2.new(1,-10,0,16); made.Position = UDim2.new(0,5,0,3)
made.BackgroundTransparency = 1; made.Text = "Made: NullHIGH"; made.TextXAlignment = "Left"
made.Font = Enum.Font.GothamBold; made.TextScaled = true; rb(made)

local luck = Instance.new("TextLabel", frame)
luck.Size = UDim2.new(0.45,0,0,18); luck.Position = UDim2.new(0,6,0,20)
luck.BackgroundTransparency = 1; luck.Text = "Luck Boost 10x"; luck.TextXAlignment = "Left"
luck.Font = Enum.Font.GothamBold; luck.TextScaled = true; rb(luck)

local antiban = Instance.new("TextLabel", frame)
antiban.Size = UDim2.new(0.48,0,0,16); antiban.Position = UDim2.new(0,6,0,38)
antiban.BackgroundTransparency = 1; antiban.Text = "100% ANTIBAN"; antiban.TextXAlignment = "Left"
antiban.Font = Enum.Font.GothamBold; antiban.TextScaled = true; rb(antiban)

local check = Instance.new("TextLabel", frame)
check.Size = UDim2.new(0,28,0,16); check.Position = UDim2.new(1,-32,0,38)
check.BackgroundTransparency = 1; check.Text = "Checkmark"; check.TextColor3 = Color3.fromRGB(0,255,0)
check.TextScaled = true; rb(check)

-- Toggle (Luck Boost)
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0,55,0,26); btn.Position = UDim2.new(1,-64,0.5,-13)
btn.BackgroundColor3 = Color3.fromRGB(46,204,113); btn.Text = ""
Instance.new("UICorner", btn).CornerRadius = UDim.new(0,13)

local knob = Instance.new("Frame", btn)
knob.Size = UDim2.new(0,22,0,22); knob.Position = UDim2.new(1,-25,0.5,-11)
knob.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", knob).CornerRadius = UDim.new(0.5,0)

local stat = Instance.new("TextLabel", btn)
stat.Size = UDim2.new(1,0,1,0); stat.BackgroundTransparency = 1
stat.Text = "ON"; stat.TextColor3 = Color3.new(1,1,1); stat.TextScaled = true; stat.Font = Enum.Font.GothamBold

-- Hop düyməsi – indi 🤑 emoji ilə
local hopBtn = Instance.new("TextButton", frame)
hopBtn.Size = UDim2.new(0,55,0,26); hopBtn.Position = UDim2.new(1,-125,0.5,-13)
hopBtn.BackgroundColor3 = Color3.fromRGB(52,152,219)
hopBtn.Text = "🤑"   -- ← burda emoji
hopBtn.TextColor3 = Color3.new(1,1,1)
hopBtn.TextScaled = true
hopBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", hopBtn).CornerRadius = UDim.new(0,13)
hopBtn.MouseButton1Click:Connect(hopServer)

-- HİLE – LUCK BOOST
local active = true

spawn(function()
    while wait(0.5) do
        if active then
            pcall(function()
                CommF_:InvokeServer("Cousin", "Buy")
            end)
        end
    end
end)

spawn(function()
    while wait(0.1) do
        if active then
            for _, f in pairs(player.Backpack:GetChildren()) do
                if f:IsA("Tool") then
                    for _, good in pairs(desiredFruits) do
                        if f.Name == good then
                            pcall(function()
                                CommF_:InvokeServer("StoreFruit", good, f)
                                game.StarterGui:SetCore("SendNotification", {Title="NullxHIGH", Text=good.." saxlanıldı! Money", Duration=5})
                            end)
                        end
                    end
                end
            end
            if player.Character then
                for _, f in pairs(player.Character:GetChildren()) do
                    if f:IsA("Tool") then
                        for _, good in pairs(desiredFruits) do
                            if f.Name == good then
                                pcall(function()
                                    CommF_:InvokeServer("StoreFruit", good, f)
                                    game.StarterGui:SetCore("SendNotification", {Title="NullxHIGH", Text=good.." saxlanıldı! Money", Duration=5})
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

btn.MouseButton1Click:Connect(function()
    active = not active
    if active then
        btn.BackgroundColor3 = Color3.fromRGB(46,204,113)
        knob.Position = UDim2.new(1,-25,0.5,-11)
        stat.Text = "ON"
    else
        btn.BackgroundColor3 = Color3.fromRGB(158,158,158)
        knob.Position = UDim2.new(0,3,0.5,-11)
        stat.Text = "OFF"
    end
end)

print("NullxHIGH Money Luck Boost hazırdır! Toggle ON + Money bas → yaxşı fruit gəlsin!")￼Enter

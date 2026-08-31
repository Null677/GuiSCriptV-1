-- ==========================================
-- BENZERSİZ GUI KÜTÜPHANESİ (TOGGLE, YENİ FONTLAR VE GÖLGELER)
-- ==========================================
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Player = game.Players.LocalPlayer

if CoreGui:FindFirstChild("OzelGuiLib") then
    CoreGui.OzelGuiLib:Destroy()
end

local OzelLib = {}
local AktifOzellikler = {} 

function OzelLib:Olustur(Yapimci, OyunAdi, Surum)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "OzelGuiLib"
    ScreenGui.Parent = CoreGui
    
    local Nokta = Instance.new("Frame")
    Nokta.Size = UDim2.new(0, 15, 0, 15)
    Nokta.Position = UDim2.new(0.5, -7, -0.1, 0)
    Nokta.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Nokta.AnchorPoint = Vector2.new(0.5, 0.5)
    local NoktaCorner = Instance.new("UICorner")
    NoktaCorner.CornerRadius = UDim.new(1, 0)
    NoktaCorner.Parent = Nokta
    Nokta.Parent = ScreenGui
    
    local AnaPencere = Instance.new("Frame")
    AnaPencere.Size = UDim2.new(0, 0, 0, 0)
    AnaPencere.Position = UDim2.new(0.5, 0, 0.5, 0)
    AnaPencere.AnchorPoint = Vector2.new(0.5, 0.5)
    AnaPencere.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    AnaPencere.ClipsDescendants = true
    AnaPencere.Visible = false
    AnaPencere.Parent = ScreenGui
    
    local AnaCorner = Instance.new("UICorner")
    AnaCorner.CornerRadius = UDim.new(0, 10)
    AnaCorner.Parent = AnaPencere

    local TemaGradient = Instance.new("UIGradient")
    TemaGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(138, 43, 226)), 
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 105, 180))  
    }
    TemaGradient.Rotation = 45
    TemaGradient.Parent = AnaPencere

    local YapimciText = Instance.new("TextLabel")
    YapimciText.Size = UDim2.new(0, 200, 0, 20)
    YapimciText.Position = UDim2.new(0, 10, 0, 5)
    YapimciText.BackgroundTransparency = 1
    YapimciText.Text = "Made: " .. Yapimci
    YapimciText.TextColor3 = Color3.fromRGB(50, 10, 80) 
    YapimciText.TextStrokeColor3 = Color3.fromRGB(255, 255, 255) 
    YapimciText.TextStrokeTransparency = 0
    YapimciText.TextXAlignment = Enum.TextXAlignment.Left
    YapimciText.Font = Enum.Font.GothamBlack
    YapimciText.TextSize = 18
    YapimciText.Parent = AnaPencere

    local OyunText = Instance.new("TextLabel")
    OyunText.Size = UDim2.new(0, 200, 0, 15)
    OyunText.Position = UDim2.new(0, 10, 0, 24)
    OyunText.BackgroundTransparency = 1
    OyunText.Text = "Game: " .. OyunAdi
    OyunText.TextColor3 = Color3.fromRGB(50, 10, 80)
    OyunText.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    OyunText.TextStrokeTransparency = 0
    OyunText.TextXAlignment = Enum.TextXAlignment.Left
    OyunText.Font = Enum.Font.GothamBold
    OyunText.TextSize = 14
    OyunText.Parent = AnaPencere

    local SurumText = Instance.new("TextLabel")
    SurumText.Size = UDim2.new(0, 100, 0, 20)
    SurumText.Position = UDim2.new(1, -110, 1, -25)
    SurumText.BackgroundTransparency = 1
    SurumText.Text = Surum
    SurumText.TextColor3 = Color3.fromRGB(50, 10, 80)
    SurumText.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    SurumText.TextStrokeTransparency = 0
    SurumText.TextXAlignment = Enum.TextXAlignment.Right
    SurumText.Font = Enum.Font.GothamBlack
    SurumText.TextSize = 16
    SurumText.Parent = AnaPencere

    local KucultButon = Instance.new("TextButton")
    KucultButon.Size = UDim2.new(0, 30, 0, 30)
    KucultButon.Position = UDim2.new(1, -70, 0, 5)
    KucultButon.BackgroundTransparency = 1
    KucultButon.Text = "-"
    KucultButon.TextColor3 = Color3.fromRGB(255, 255, 255)
    KucultButon.TextSize = 24
    KucultButon.Font = Enum.Font.GothamBold
    KucultButon.ZIndex = 5
    KucultButon.Parent = AnaPencere

    local KapatButon = Instance.new("TextButton")
    KapatButon.Size = UDim2.new(0, 30, 0, 30)
    KapatButon.Position = UDim2.new(1, -35, 0, 5)
    KapatButon.BackgroundTransparency = 1
    KapatButon.Text = "X"
    KapatButon.TextColor3 = Color3.fromRGB(255, 50, 50)
    KapatButon.TextSize = 18
    KapatButon.Font = Enum.Font.GothamBold
    KapatButon.ZIndex = 5
    KapatButon.Parent = AnaPencere

    local KategoriAlani = Instance.new("ScrollingFrame")
    KategoriAlani.Size = UDim2.new(0, 130, 1, -50)
    KategoriAlani.Position = UDim2.new(0, 10, 0, 45)
    KategoriAlani.BackgroundTransparency = 1
    KategoriAlani.ScrollBarThickness = 2
    KategoriAlani.Parent = AnaPencere
    
    local KategoriLayout = Instance.new("UIListLayout")
    KategoriLayout.Parent = KategoriAlani
    KategoriLayout.Padding = UDim.new(0, 5)

    local IcerikAlani = Instance.new("Frame")
    IcerikAlani.Size = UDim2.new(1, -160, 1, -80)
    IcerikAlani.Position = UDim2.new(0, 150, 0, 45)
    IcerikAlani.BackgroundTransparency = 0.5
    IcerikAlani.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    IcerikAlani.Parent = AnaPencere
    local IcerikCorner = Instance.new("UICorner")
    IcerikCorner.CornerRadius = UDim.new(0, 8)
    IcerikCorner.Parent = IcerikAlani

    local OnayMenusu = Instance.new("Frame")
    OnayMenusu.Size = UDim2.new(1, 0, 1, 0)
    OnayMenusu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    OnayMenusu.BackgroundTransparency = 0.3
    OnayMenusu.Visible = false
    OnayMenusu.ZIndex = 10
    OnayMenusu.Parent = AnaPencere

    local SoruText = Instance.new("TextLabel")
    SoruText.Size = UDim2.new(1, 0, 0, 50)
    SoruText.Position = UDim2.new(0, 0, 0.4, -25)
    SoruText.BackgroundTransparency = 1
    SoruText.Text = "Hileyi kapatmak istediğine emin misin?"
    SoruText.TextColor3 = Color3.fromRGB(255, 255, 255)
    SoruText.Font = Enum.Font.GothamBold
    SoruText.TextSize = 18
    SoruText.ZIndex = 11
    SoruText.Parent = OnayMenusu

    local OnayKapat = Instance.new("TextButton")
    OnayKapat.Size = UDim2.new(0, 100, 0, 35)
    OnayKapat.Position = UDim2.new(0.5, -110, 0.6, 0)
    OnayKapat.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    OnayKapat.Text = "Kapat"
    OnayKapat.TextColor3 = Color3.fromRGB(255,255,255)
    OnayKapat.Font = Enum.Font.GothamBold
    OnayKapat.ZIndex = 11
    Instance.new("UICorner", OnayKapat).CornerRadius = UDim.new(0, 6)
    OnayKapat.Parent = OnayMenusu

    local OnayGeri = Instance.new("TextButton")
    OnayGeri.Size = UDim2.new(0, 100, 0, 35)
    OnayGeri.Position = UDim2.new(0.5, 10, 0.6, 0)
    OnayGeri.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    OnayGeri.Text = "Geri"
    OnayGeri.TextColor3 = Color3.fromRGB(255,255,255)
    OnayGeri.Font = Enum.Font.GothamBold
    OnayGeri.ZIndex = 11
    Instance.new("UICorner", OnayGeri).CornerRadius = UDim.new(0, 6)
    OnayGeri.Parent = OnayMenusu

    local AcikMi = true
    local AnimasyondaMi = false

    KucultButon.MouseButton1Click:Connect(function()
        if AnimasyondaMi then return end
        AnimasyondaMi = true
        AcikMi = not AcikMi

        if not AcikMi then
            KategoriAlani.Visible = false
            IcerikAlani.Visible = false
            SurumText.Visible = false
            
            local Kapanis = TweenService:Create(AnaPencere, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 500, 0, 40)
            })
            Kapanis:Play()
            Kapanis.Completed:Wait()
        else
            local Acilis = TweenService:Create(AnaPencere, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 500, 0, 350)
            })
            Acilis:Play()
            Acilis.Completed:Wait()
            
            KategoriAlani.Visible = true
            IcerikAlani.Visible = true
            SurumText.Visible = true
        end
        AnimasyondaMi = false
    end)

    KapatButon.MouseButton1Click:Connect(function()
        OnayMenusu.Visible = true
    end)

    OnayGeri.MouseButton1Click:Connect(function()
        OnayMenusu.Visible = false
    end)

    OnayKapat.MouseButton1Click:Connect(function()
        for _, obj in pairs(AktifOzellikler) do
            if type(obj) == "function" then pcall(obj) end
        end
        ScreenGui:Destroy()
    end)

    local DusmeAnim = TweenService:Create(Nokta, TweenInfo.new(1.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    DusmeAnim:Play()
    DusmeAnim.Completed:Wait()

    local PatlamaAnim = TweenService:Create(Nokta, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 90, 0, 90), 
        BackgroundTransparency = 1
    })
    PatlamaAnim:Play()
    PatlamaAnim.Completed:Wait()
    Nokta:Destroy()

    AnaPencere.Visible = true
    local AnaAcilis = TweenService:Create(AnaPencere, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 500, 0, 350)
    })
    AnaAcilis:Play()

    local surukleniyor, baslangicGiris, baslangicPozisyon
    AnaPencere.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            surukleniyor = true
            baslangicGiris = input.Position
            baslangicPozisyon = AnaPencere.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then surukleniyor = false end
            end)
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if surukleniyor then
                local delta = input.Position - baslangicGiris
                AnaPencere.Position = UDim2.new(baslangicPozisyon.X.Scale, baslangicPozisyon.X.Offset + delta.X, baslangicPozisyon.Y.Scale, baslangicPozisyon.Y.Offset + delta.Y)
            end
        end
    end)

    local IlkTabSecildi = false
    local Pencereler = {}

    local KategoriSistemi = {}
    function KategoriSistemi:KategoriEkle(isim)
        local TabButon = Instance.new("TextButton")
        TabButon.Size = UDim2.new(1, 0, 0, 35)
        TabButon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButon.BackgroundTransparency = 0.8
        TabButon.Text = isim
        
        TabButon.TextColor3 = Color3.fromRGB(50, 10, 80)
        TabButon.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        TabButon.TextStrokeTransparency = 0
        TabButon.Font = Enum.Font.GothamBlack
        TabButon.TextSize = 16
        
        TabButon.Parent = KategoriAlani
        Instance.new("UICorner", TabButon).CornerRadius = UDim.new(0, 4)

        local TabSayfasi = Instance.new("ScrollingFrame")
        TabSayfasi.Size = UDim2.new(1, -10, 1, -10)
        TabSayfasi.Position = UDim2.new(0, 5, 0, 5)
        TabSayfasi.BackgroundTransparency = 1
        TabSayfasi.ScrollBarThickness = 2
        TabSayfasi.Visible = false
        TabSayfasi.Parent = IcerikAlani
        table.insert(Pencereler, TabSayfasi)

        local SayfaLayout = Instance.new("UIListLayout")
        SayfaLayout.Parent = TabSayfasi
        SayfaLayout.Padding = UDim.new(0, 5)

        if not IlkTabSecildi then
            TabSayfasi.Visible = true
            TabButon.BackgroundTransparency = 0.5
            IlkTabSecildi = true
        end

        TabButon.MouseButton1Click:Connect(function()
            for _, pencere in pairs(Pencereler) do pencere.Visible = false end
            for _, btn in pairs(KategoriAlani:GetChildren()) do 
                if btn:IsA("TextButton") then btn.BackgroundTransparency = 0.8 end 
            end
            TabSayfasi.Visible = true
            TabButon.BackgroundTransparency = 0.5
        end)

        local TabOzellikleri = {}
        
        function TabOzellikleri:ButonEkle(butonIsmi, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, -5, 0, 40)
            Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Btn.BackgroundTransparency = 0.8
            Btn.Text = "  " .. butonIsmi
            
            Btn.TextColor3 = Color3.fromRGB(50, 10, 80)
            Btn.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            Btn.TextStrokeTransparency = 0
            Btn.Font = Enum.Font.GothamBlack
            Btn.TextSize = 16
            
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            Btn.Parent = TabSayfasi
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)

            Btn.MouseButton1Click:Connect(function()
                TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
                task.wait(0.1)
                TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundTransparency = 0.8}):Play()
                if callback then pcall(callback) end
            end)
        end

        function TabOzellikleri:ToggleEkle(toggleIsmi, callback)
            local TglBtn = Instance.new("TextButton")
            TglBtn.Size = UDim2.new(1, -5, 0, 40)
            TglBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TglBtn.BackgroundTransparency = 0.8
            TglBtn.Text = "  " .. toggleIsmi
            
            TglBtn.TextColor3 = Color3.fromRGB(50, 10, 80)
            TglBtn.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            TglBtn.TextStrokeTransparency = 0
            TglBtn.Font = Enum.Font.GothamBlack
            TglBtn.TextSize = 16
            
            TglBtn.TextXAlignment = Enum.TextXAlignment.Left
            TglBtn.Parent = TabSayfasi
            Instance.new("UICorner", TglBtn).CornerRadius = UDim.new(0, 4)

            local ToggleBg = Instance.new("Frame")
            ToggleBg.Size = UDim2.new(0, 44, 0, 22)
            ToggleBg.Position = UDim2.new(1, -50, 0.5, -11)
            ToggleBg.BackgroundColor3 = Color3.fromRGB(120, 120, 120) 
            ToggleBg.Parent = TglBtn
            Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(1, 0)

            local ToggleYuvarlak = Instance.new("Frame")
            ToggleYuvarlak.Size = UDim2.new(0, 18, 0, 18)
            ToggleYuvarlak.Position = UDim2.new(0, 2, 0.5, -9)
            ToggleYuvarlak.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleYuvarlak.Parent = ToggleBg
            Instance.new("UICorner", ToggleYuvarlak).CornerRadius = UDim.new(1, 0)

            local ToggleAcik = false

            TglBtn.MouseButton1Click:Connect(function()
                ToggleAcik = not ToggleAcik

                if ToggleAcik then
                    TweenService:Create(ToggleYuvarlak, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(1, -20, 0.5, -9)}):Play()
                    TweenService:Create(ToggleBg, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(180, 50, 210)}):Play()
                else
                    TweenService:Create(ToggleYuvarlak, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0, 2, 0.5, -9)}):Play()
                    TweenService:Create(ToggleBg, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(120, 120, 120)}):Play()
                end

                if callback then
                    pcall(callback, ToggleAcik)
                end
            end)
        end

        return TabOzellikleri
    end

    return KategoriSistemi
end

-- ==========================================
-- GUI'Yİ ÇALIŞTIRAN VE ÇİZEN KISIM
-- ==========================================
local Pencerem = OzelLib:Olustur("NullLegend", "Blox Fruits", "v1.0")
local OyuncuSekmesi = Pencerem:KategoriEkle("Oyuncu")

-- Örnek Buton
OyuncuSekmesi:ButonEkle("Hızlı Koşma (WalkSpeed)", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
end)

-- Örnek Toggle
OyuncuSekmesi:ToggleEkle("Yüksek Zıplama", function(acikMi)
    if acikMi then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 120
    else
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

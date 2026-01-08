-- Limpa tentativas anteriores para não pesar
print("Tentando carregar script de Brainrot...")

local function IniciarScript()
    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
    
    local Window = OrionLib:MakeWindow({
        Name = "Brainrot Stealer Pro", 
        HidePremium = false, 
        SaveConfig = false, 
        ConfigFolder = "DeltaScript"
    })

    local Tab = Window:MakeTab({
        Name = "Auto TP",
        Icon = "rbxassetid://4483345998"
    })

    _G.AutoTP = false

    local function Teleportar()
        while _G.AutoTP do
            local alvoEncontrado = false
            -- Busca o bicho no mapa inteiro
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Frulli Frulla" or v.Name == "Fragola La La La" then
                    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        -- TP com pequena altura para não bugar no chão
                        hrp.CFrame = v.CFrame * CFrame.new(0, 3, 0)
                        alvoEncontrado = true
                    end
                end
            end
            task.wait(0.5) -- Velocidade de busca (meio segundo)
        end
    end

    Tab:AddToggle({
        Name = "Auto TP (Frulli / Fragola)",
        Default = false,
        Callback = function(Value)
            _G.AutoTP = Value
            if Value then
                task.spawn(Teleportar)
            end
        end    
    })

    OrionLib:Init()
end

-- Tenta carregar o script com proteção contra erros
local success, err = pcall(IniciarScript)

if not success then
    warn("Erro ao carregar o menu: " .. tostring(err))
    -- Se o menu falhar, ele tenta dar o TP seco sem menu pra você não perder o bicho
    print("Tentando TP de emergência sem menu...")
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v.Name == "Frulli Frulla" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end
    end
end

print("--- BUSCADOR DE FRULLI INICIADO ---")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

-- Lista de itens raros
local alvos = {"Frulli Frulla", "Fragola La La La"}

_G.AutoFarm = true

task.spawn(function()
    while _G.AutoFarm do
        local encontrouNoMapa = false
        
        for _, obj in pairs(game.Workspace:GetDescendants()) do
            -- Verifica se o nome é um dos alvos
            local matches = false
            for _, nome in ipairs(alvos) do
                if obj.Name == nome then matches = true break end
            end

            if matches then
                -- O SEGREDO: Verifica se o item NÃO está dentro de um Slot ou de outro Player
                local noSlot = obj:FindFirstAncestor("Slots") or obj:FindFirstAncestor("Bases") or obj:FindFirstAncestorOfClass("Player")
                
                if not noSlot then
                    -- Se chegou aqui, o item está solto no mapa!
                    local targetPart = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart", true)
                    
                    if targetPart then
                        print("ITEM LIVRE DETECTADO! Dando TP...")
                        root.CFrame = targetPart.CFrame * CFrame.new(0, 3, 0)
                        encontrouNoMapa = true
                        task.wait(0.5) -- TP instantâneo
                    end
                end
            end
        end
        
        if not encontrouNoMapa then
            -- Opcional: print("Nenhum bicho livre agora...")
        end
        
        task.wait(0.1) -- Procura muito rápido (10 vezes por segundo)
    end
end)

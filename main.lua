print("--- RASTREADOR TOTAL ATIVADO (SEM LIMITES) ---")

local player = game.Players.LocalPlayer

-- Lista de bichos que o script vai perseguir
local nomesAlvo = {"Frulli", "Fragola", "Noobini", "Cakenini"}

local function iniciarBusca()
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")
    
    task.spawn(function()
        print("Varredura total iniciada em todo o Workspace...")
        while character and character:Parent() do
            for _, obj in pairs(game.Workspace:GetDescendants()) do
                
                -- Verifica se o nome bate com a lista
                local encontrouAlvo = false
                for _, alvo in ipairs(nomesAlvo) do
                    if obj.Name:find(alvo) then
                        encontrouAlvo = true
                        break
                    end
                end

                if encontrouAlvo then
                    -- REMOVI O FILTRO: Agora ele dá TP mesmo se estiver em bases/slots
                    local targetPart = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart", true)
                    
                    if targetPart then
                        -- Se o bicho for uma ferramenta (Tool), o CFrame fica na "Handle"
                        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                            targetPart = obj.Handle
                        end

                        print("ALVO LOCALIZADO EM: " .. obj:GetFullName())
                        -- Teleporta exatamente na posição do bicho
                        root.CFrame = targetPart.CFrame
                        task.wait(0.3) -- Pausa curta para o jogo processar a coleta
                    end
                end
            end
            task.wait(0.2) -- Busca super rápida (5 vezes por segundo)
        end
    end)
end

iniciarBusca()

-- Reinicia o script se você morrer ou o mapa mudar
player.CharacterAdded:Connect(function()
    print("Personagem renovado. Reiniciando busca total...")
    task.wait(1)
    iniciarBusca()
end)

print("Script Iniciado!")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local alvo = "Frulli Frulla"
local encontrado = false

for _, obj in pairs(game.Workspace:GetDescendants()) do
    if obj.Name == alvo or obj.Name:find("Frulli") then
        print("Achei o bicho! Dando TP...")
        local pos = obj:FindFirstChildWhichIsA("BasePart") or obj
        root.CFrame = pos.CFrame * CFrame.new(0, 3, 0)
        encontrado = true
        break
    end
end

if not encontrado then
    print("Nao achei nenhum " .. alvo .. " no mapa agora.")
end

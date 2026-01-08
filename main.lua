local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Brainrot Stealer Pro", HidePremium = false, SaveConfig = true, ConfigFolder = "BrainrotConfig"})

local Tab = Window:MakeTab({
	Name = "Auto Farm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

_G.AutoTP = false

-- Função para procurar e dar TP
function teleportToItem()
    while _G.AutoTP do
        local found = false
        -- Procura pelo nome "Frulli Frulla"
        for _, obj in pairs(game.Workspace:GetDescendants()) do
            if obj.Name == "Frulli Frulla" or (obj:IsA("Model") and obj.Name:find("Frulli")) then
                local rootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                -- Tenta achar uma parte do bicho para encostar
                local targetPart = obj:FindFirstChildWhichIsA("BasePart") or obj:FindFirstChild("HumanoidRootPart")
                
                if rootPart and targetPart then
                    rootPart.CFrame = targetPart.CFrame * CFrame.new(0, 3, 0)
                    OrionLib:MakeNotification({
                        Name = "Item Encontrado!",
                        Content = "Teleportado para Frulli Frulla!",
                        Time = 5
                    })
                    found = true
                    break
                end
            end
        end
        task.wait(1) -- Verifica a cada 1 segundo
    end
end

Tab:AddToggle({
	Name = "Auto TP Frulli Frulla",
	Default = false,
	Callback = function(Value)
		_G.AutoTP = Value
        if Value then
            task.spawn(teleportToItem) -- Roda em segundo plano
        end
	end    
})

OrionLib:Init()

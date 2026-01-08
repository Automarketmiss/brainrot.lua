local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Brainrot Stealer Pro", HidePremium = false, SaveConfig = true, ConfigFolder = "BrainrotConfig"})

local Tab = Window:MakeTab({
	Name = "Auto Farm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

_G.AutoTP = false

function teleportToFragola()
    while _G.AutoTP do
        local found = false
        -- Procura em todo o Workspace pelo nome do bicho
        for _, obj in pairs(game.Workspace:GetDescendants()) do
            if obj.Name == "Fragola La La La" or obj:IsA("Model") and obj.Name:find("Fragola") then
                local rootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local targetPart = obj:FindFirstChildWhichIsA("BasePart") or obj:FindFirstChild("HumanoidRootPart")
                
                if rootPart and targetPart then
                    -- TP Suave para evitar detecção imediata
                    rootPart.CFrame = targetPart.CFrame * CFrame.new(0, 3, 0)
                    OrionLib:MakeNotification({
                        Name = "Item Encontrado!",
                        Content = "Teleportado para Fragola!",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                    found = true
                    break
                end
            end
        end
        if not found then
            -- Se não achar, espera 2 segundos e tenta de novo
            task.wait(2)
        else
            -- Se achar, espera um pouco para não bugar o TP
            task.wait(5)
        end
    end
end

Tab:AddToggle({
	Name = "Auto TP Fragola (Secreto)",
	Default = false,
	Callback = function(Value)
		_G.AutoTP = Value
        if Value then
            teleportToFragola()
        end
	end    
})

OrionLib:Init()

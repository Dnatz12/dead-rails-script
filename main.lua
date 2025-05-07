--== DEAD RAILS MEGA SCRIPT ==-- -- Features: UI, Kill Aura++, ESP, FullBright, AutoWin, Auto Heal, Auto Revive --

-- UI Setup local ScreenGui = Instance.new("ScreenGui", game.CoreGui) ScreenGui.Name = "DeadRailsUI"

local Frame = Instance.new("Frame", ScreenGui) Frame.Size = UDim2.new(0, 320, 0, 360) Frame.Position = UDim2.new(0.5, -160, 0.5, -180) Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) Frame.Active = true Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)

local Title = Instance.new("TextLabel", Frame) Title.Size = UDim2.new(1, 0, 0, 30) Title.Text = "Dead Rails - Mega Menu" Title.TextColor3 = Color3.new(1,1,1) Title.Font = Enum.Font.SourceSansBold Title.TextSize = 20 Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local Minimize = Instance.new("TextButton", Frame) Minimize.Size = UDim2.new(0, 30, 0, 30) Minimize.Position = UDim2.new(1, -35, 0, 0) Minimize.Text = "-" Minimize.BackgroundColor3 = Color3.fromRGB(80, 80, 80) Minimize.TextColor3 = Color3.new(1,1,1)

local function makeButton(name, y, parent) local btn = Instance.new("TextButton", parent) btn.Size = UDim2.new(0, 280, 0, 35) btn.Position = UDim2.new(0, 20, 0, y) btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) btn.TextColor3 = Color3.new(1,1,1) btn.Font = Enum.Font.SourceSansBold btn.TextSize = 18 btn.Text = name return btn end

-- Button Instances local TeleportBtn = makeButton("Teleport ke Atap", 40, Frame) local KillAuraBtn = makeButton("Kill Aura: OFF", 80, Frame) local AutoWinBtn = makeButton("Auto Win: OFF", 120, Frame) local FullBrightBtn = makeButton("FullBright: ON", 160, Frame) local ESPBtn = makeButton("ESP: OFF", 200, Frame) local AutoHealBtn = makeButton("Auto Heal: OFF", 240, Frame) local AutoReviveBtn = makeButton("Auto Revive: OFF", 280, Frame)

-- States local killAuraEnabled = false local autoWin = false local fullBright = true local espEnabled = false local autoHeal = false local autoRevive = false

local espFolder = Instance.new("Folder", game.CoreGui) espFolder.Name = "ESPFolder"

-- Minimize Logic local minimized = false Minimize.MouseButton1Click:Connect(function() minimized = not minimized for _, v in ipairs(Frame:GetChildren()) do if v:IsA("TextButton") and v ~= Minimize then v.Visible = not minimized end end end)

-- Full Bright local function fullBrightFunc() game.Lighting.Brightness = 2 game.Lighting.ClockTime = 14 game.Lighting.FogEnd = 100000 game.Lighting.GlobalShadows = false end if fullBright then fullBrightFunc() end

-- Button Functions TeleportBtn.MouseButton1Click:Connect(function() local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if hrp then hrp.CFrame = CFrame.new(0, 30, 0) end end)

KillAuraBtn.MouseButton1Click:Connect(function() killAuraEnabled = not killAuraEnabled KillAuraBtn.Text = "Kill Aura: " .. (killAuraEnabled and "ON" or "OFF") end)

AutoWinBtn.MouseButton1Click:Connect(function() autoWin = not autoWin AutoWinBtn.Text = "Auto Win: " .. (autoWin and "ON" or "OFF") end)

FullBrightBtn.MouseButton1Click:Connect(function() fullBright = not fullBright FullBrightBtn.Text = "FullBright: " .. (fullBright and "ON" or "OFF") if fullBright then fullBrightFunc() end end)

ESPBtn.MouseButton1Click:Connect(function() espEnabled = not espEnabled ESPBtn.Text = "ESP: " .. (espEnabled and "ON" or "OFF") if not espEnabled then espFolder:ClearAllChildren() end end)

AutoHealBtn.MouseButton1Click:Connect(function() autoHeal = not autoHeal AutoHealBtn.Text = "Auto Heal: " .. (autoHeal and "ON" or "OFF") end)

AutoReviveBtn.MouseButton1Click:Connect(function() autoRevive = not autoRevive AutoReviveBtn.Text = "Auto Revive: " .. (autoRevive and "ON" or "OFF") end)

-- Loops -- Kill Aura coroutine.wrap(function() while true do if killAuraEnabled then local char = game.Players.LocalPlayer.Character if char and char:FindFirstChild("HumanoidRootPart") then for _, m in ipairs(workspace:GetDescendants()) do if m:IsA("Model") and m:FindFirstChild("Humanoid") and m:FindFirstChild("HumanoidRootPart") then if m ~= char and m.Humanoid.Health > 0 then local dist = (m.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude if dist < 40 then m.Humanoid:TakeDamage(50) end end end end end task.wait(0.3) end end)()

-- Auto Win coroutine.wrap(function() while true do if autoWin then local goal = workspace:FindFirstChild("WinTrigger") or workspace:FindFirstChild("Finish") local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if goal and hrp then hrp.CFrame = goal.CFrame + Vector3.new(0, 3, 0) end end task.wait(2) end end)()

-- ESP coroutine.wrap(function() while true do if espEnabled then espFolder:ClearAllChildren() for _, obj in pairs(workspace:GetDescendants()) do if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then local billboard = Instance.new("BillboardGui", espFolder) billboard.Adornee = obj.HumanoidRootPart billboard.Size = UDim2.new(0,100,0,30) billboard.AlwaysOnTop = true

local label = Instance.new("TextLabel", billboard)
				label.Size = UDim2.new(1,0,1,0)
				label.BackgroundTransparency = 1
				label.Text = obj.Name
				label.TextColor3 = Color3.new(1,0,0)
				label.TextScaled = true
				label.Font = Enum.Font.SourceSansBold
			end
		end
	end
	task.wait(1)
end

end)()

-- Auto Heal coroutine.wrap(function() while true do if autoHeal then local char = game.Players.LocalPlayer.Character local hum = char and char:FindFirstChild("Humanoid") if hum and hum.Health < hum.MaxHealth * 0.5 then hum.Health = math.min(hum.MaxHealth, hum.Health + 10) end end task.wait(1) end end)()

-- Auto Revive coroutine.wrap(function() while true do if autoRevive then local lp = game.Players.LocalPlayer if not lp.Character or not lp.Character:FindFirstChild("Humanoid") or lp.Character:FindFirstChild("Humanoid").Health <= 0 then lp:LoadCharacter() end end task.wait(2) end end)()


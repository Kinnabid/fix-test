local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:FindFirstChildWhichIsA("Humanoid")

local bag = localPlayer:WaitForChild("States"):WaitForChild("Bag")
local bagSizeLevel = localPlayer:WaitForChild("Stats"):WaitForChild("BagSizeLevel"):WaitForChild("CurrentAmount")
local robEvent = ReplicatedStorage:WaitForChild("GeneralEvents"):WaitForChild("Rob")
local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

local targetPosition = CFrame.new(1636.62537, 104.349976, -1736.184)

local function moveToTarget()
    if humanoidRootPart then
        humanoidRootPart.CFrame = targetPosition
    end
end

local function checkCashRegister()
    for _, item in ipairs(Workspace:GetChildren()) do
        if bag.Value == bagSizeLevel.Value then
            moveToTarget()
            break
        elseif item:IsA("Model") and item.Name == "CashRegister" then
            local openPart = item:FindFirstChild("Open")
            if openPart then
                humanoidRootPart.CFrame = openPart.CFrame
                robEvent:FireServer("Register", {
                    Part = item:FindFirstChild("Union"),
                    OpenPart = openPart,
                    ActiveValue = item:FindFirstChild("Active"),
                    Active = true
                })
                return true
            end
        end
    end
    return false
end

local function checkSafe()
    for _, item in ipairs(Workspace:GetChildren()) do
        if bag.Value == bagSizeLevel.Value then
            moveToTarget()
            break
        elseif item:IsA("Model") and item.Name == "Safe" and item:FindFirstChild("Amount").Value > 0 then
            local safePart = item:FindFirstChild("Safe")
            if safePart then
                humanoidRootPart.CFrame = safePart.CFrame
                local openFlag = item:FindFirstChild("Open")
                if openFlag and openFlag.Value then
                    robEvent:FireServer("Safe", item)
                else
                    local openSafe = item:FindFirstChild("OpenSafe")
                    if openSafe then
                        openSafe:FireServer("Completed")
                    end
                    robEvent:FireServer("Safe", item)
                end
                return true
            end
        end
    end
    return false
end

if humanoid then
    local clonedHumanoid = humanoid:Clone()
    clonedHumanoid.Parent = character
    localPlayer.Character = nil
    clonedHumanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    clonedHumanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    clonedHumanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
    humanoid:Destroy()
    localPlayer.Character = character
    camera.CameraSubject = clonedHumanoid
    camera.CFrame = camera.CFrame
    clonedHumanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    local animate = character:FindFirstChild("Animate")
    if animate then
        animate.Disabled = true
        task.wait()
        animate.Disabled = false
    end
    clonedHumanoid.Health = clonedHumanoid.MaxHealth
end

task.wait(2)

RunService.RenderStepped:Connect(function()
    if not checkCashRegister() then
        checkSafe()
    end
end)

task.spawn(function()
    repeat task.wait() until game:IsLoaded() and Players and Players.LocalPlayer and Players.LocalPlayer.Character
    local leaderstats = localPlayer:WaitForChild("leaderstats")
    local cashStat = leaderstats:WaitForChild("$$")
    local initialCash = cashStat.Value
    local function formatNumber(n)
        local formatted = tostring(n)
        local k
        while true do
            formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
            if k == 0 then break end
        end
        return formatted
    end
    if getgenv().AntiAfkExecuted and game.CoreGui:FindFirstChild("thisoneissocoldww") then
        getgenv().AntiAfkExecuted = false
        getgenv().zamanbaslaticisi = false
        game.CoreGui.thisoneissocoldww:Destroy()
    end
    getgenv().AntiAfkExecuted = true
    local thisoneissocoldww = Instance.new("ScreenGui")
    thisoneissocoldww.Name = "thisoneissocoldww"
    thisoneissocoldww.Parent = game.CoreGui
    thisoneissocoldww.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local madebybloodofbatus = Instance.new("Frame")
    madebybloodofbatus.Name = "madebybloodofbatus"
    madebybloodofbatus.Parent = thisoneissocoldww
    madebybloodofbatus.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    madebybloodofbatus.Position = UDim2.new(0.085, 0, 0.131, 0)
    madebybloodofbatus.Size = UDim2.new(0, 225, 0, 120)
    local UICornerw = Instance.new("UICorner")
    UICornerw.Name = "UICornerw"
    UICornerw.Parent = madebybloodofbatus
    local DestroyButton = Instance.new("TextButton")
    DestroyButton.Name = "DestroyButton"
    DestroyButton.Parent = madebybloodofbatus
    DestroyButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DestroyButton.BackgroundTransparency = 1.0
    DestroyButton.Position = UDim2.new(0.87, 0, 0.025, 0)
    DestroyButton.Size = UDim2.new(0, 27, 0, 15)
    DestroyButton.Font = Enum.Font.SourceSans
    DestroyButton.Text = "X"
    DestroyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DestroyButton.TextSize = 14
    DestroyButton.MouseButton1Click:Connect(function()
        getgenv().AntiAfkExecuted = false
        task.wait(0.1)
        thisoneissocoldww:Destroy()
    end)
    local uselesslabelone = Instance.new("TextLabel")
    uselesslabelone.Name = "uselesslabelone"
    uselesslabelone.Parent = madebybloodofbatus
    uselesslabelone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    uselesslabelone.BackgroundTransparency = 1.0
    uselesslabelone.Position = UDim2.new(0.30, 0, 0.0, 0)
    uselesslabelone.Size = UDim2.new(0, 95, 0, 24)
    uselesslabelone.Font = Enum.Font.SourceSans
    uselesslabelone.Text = "Fast Farm Money"
    uselesslabelone.TextColor3 = Color3.fromRGB(255, 255, 255)
    uselesslabelone.TextSize = 14
    local uselesslabeltwo = Instance.new("TextLabel")
    uselesslabeltwo.Name = "uselesslabeltwo"
    uselesslabeltwo.Parent = madebybloodofbatus
    uselesslabeltwo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    uselesslabeltwo.BackgroundTransparency = 1.0
    uselesslabeltwo.Position = UDim2.new(0.03, 0, 0.37, 0)
    uselesslabeltwo.Size = UDim2.new(0, 35, 0, 24)
    uselesslabeltwo.Font = Enum.Font.SourceSans
    uselesslabeltwo.Text = "Ping:"
    uselesslabeltwo.TextColor3 = Color3.fromRGB(255, 255, 255)
    uselesslabeltwo.TextSize = 14
    local pinglabel = Instance.new("TextLabel")
    pinglabel.Name = "pinglabel"
    pinglabel.Parent = madebybloodofbatus
    pinglabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pinglabel.BackgroundTransparency = 1.0
    pinglabel.Position = UDim2.new(0.16, 0, 0.37, 0)
    pinglabel.Size = UDim2.new(0, 35, 0, 24)
    pinglabel.Font = Enum.Font.SourceSans
    pinglabel.Text = "N/A"
    pinglabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    pinglabel.TextSize = 14
    local earnedLabelTag = Instance.new("TextLabel")
    earnedLabelTag.Name = "EarnedLabelTag"
    earnedLabelTag.Parent = madebybloodofbatus
    earnedLabelTag.BackgroundColor3 = Color3.fromRGB(255,255,255)
    earnedLabelTag.BackgroundTransparency = 1.0
    earnedLabelTag.Position = UDim2.new(0.36, 0, 0.37, 0)
    earnedLabelTag.Size = UDim2.new(0, 50, 0, 24)
    earnedLabelTag.Font = Enum.Font.SourceSans
    earnedLabelTag.Text = "C$:"
    earnedLabelTag.TextColor3 = Color3.new(1,1,1)
    earnedLabelTag.TextSize = 14
    local cashEarnedLabel = Instance.new("TextLabel")
    cashEarnedLabel.Name = "CashEarned"
    cashEarnedLabel.Parent = madebybloodofbatus
    cashEarnedLabel.BackgroundColor3 = Color3.fromRGB(255,255,255)
    cashEarnedLabel.BackgroundTransparency = 1.0
    cashEarnedLabel.Position = UDim2.new(0.47, 0, 0.37, 0)
    cashEarnedLabel.Size = UDim2.new(0, 60, 0, 24)
    cashEarnedLabel.Font = Enum.Font.SourceSans
    cashEarnedLabel.Text = "$0"
    cashEarnedLabel.TextColor3 = Color3.new(1,1,1)
    cashEarnedLabel.TextSize = 14
    local uselesslabelthree = Instance.new("TextLabel")
    uselesslabelthree.Name = "uselesslabelthree"
    uselesslabelthree.Parent = madebybloodofbatus
    uselesslabelthree.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    uselesslabelthree.BackgroundTransparency = 1.0
    uselesslabelthree.Position = UDim2.new(0.70, 0, 0.37, 0)
    uselesslabelthree.Size = UDim2.new(0, 30, 0, 24)
    uselesslabelthree.Font = Enum.Font.SourceSans
    uselesslabelthree.Text = "Fps:"
    uselesslabelthree.TextColor3 = Color3.fromRGB(255, 255, 255)
    uselesslabelthree.TextSize = 14
    local fpslabel = Instance.new("TextLabel")
    fpslabel.Name = "fpslabel"
    fpslabel.Parent = madebybloodofbatus
    fpslabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    fpslabel.BackgroundTransparency = 1.0
    fpslabel.Position = UDim2.new(0.80, 0, 0.37, 0)
    fpslabel.Size = UDim2.new(0, 40, 0, 24)
    fpslabel.Font = Enum.Font.SourceSans
    fpslabel.Text = "??"
    fpslabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    fpslabel.TextSize = 14
    local timerlabel = Instance.new("TextLabel")
    timerlabel.Name = "timerlabel"
    timerlabel.Parent = madebybloodofbatus
    timerlabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    timerlabel.BackgroundTransparency = 1.0
    timerlabel.Position = UDim2.new(0.65344, 0, 0.68194, 0)
    timerlabel.Size = UDim2.new(0, 60, 0, 24)
    timerlabel.Font = Enum.Font.SourceSans
    timerlabel.Text = "0:0:0"
    timerlabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timerlabel.TextSize = 14
    local uselessframeone = Instance.new("Frame")
    uselessframeone.Name = "uselessframeone"
    uselessframeone.Parent = madebybloodofbatus
    uselessframeone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    uselessframeone.Position = UDim2.new(0.0044, 0, 0.24331, 0)
    uselessframeone.Size = UDim2.new(0, 224, 0, 5)
    local UICornerww = Instance.new("UICorner")
    UICornerww.CornerRadius = UDim.new(0, 50)
    UICornerww.Name = "UICornerww"
    UICornerww.Parent = uselessframeone
    local uselesslabelfour = Instance.new("TextLabel")
    uselesslabelfour.Name = "uselesslabelfour"
    uselesslabelfour.Parent = madebybloodofbatus
    uselesslabelfour.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    uselesslabelfour.BackgroundTransparency = 1.0
    uselesslabelfour.Position = UDim2.new(0.05803, 0, 0.8125, 0)
    uselesslabelfour.Size = UDim2.new(0, 95, 0, 12)
    uselesslabelfour.Font = Enum.Font.SourceSans
    uselesslabelfour.Text = "Anti-Afk Auto Enabled"
    uselesslabelfour.TextColor3 = Color3.fromRGB(255, 255, 255)
    uselesslabelfour.TextSize = 14
    local Drag = madebybloodofbatus
    local gsTween = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos
    local function updateDrag(input)
        local delta = input.Position - dragStart
        local dragTime = 0.04
        local SmoothDrag = {}
        SmoothDrag.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        local dragSmoothFunction = gsTween:Create(Drag, TweenInfo.new(dragTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), SmoothDrag)
        dragSmoothFunction:Play()
    end
    Drag.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Drag.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    Drag.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging and Drag.Size then
            updateDrag(input)
        end
    end)
    local virtualUser = game:GetService("VirtualUser")
    Players.LocalPlayer.Idled:Connect(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
    end)
    local sec = tick()
    local FPS = {}
    local function updateFPS()
        local fr = tick()
        for i = #FPS, 1, -1 do
            FPS[i + 1] = (FPS[i] >= fr - 1) and FPS[i] or nil
        end
        FPS[1] = fr
        local fps = (tick() - sec >= 1 and #FPS) or (#FPS / (tick() - sec))
        fps = math.floor(fps)
        fpslabel.Text = tostring(fps)
    end
    RunService.RenderStepped:Connect(updateFPS)
    task.spawn(function()
        while pinglabel do
            task.wait(1)
            local perfStats = game:GetService("Stats"):FindFirstChild("PerformanceStats")
            if perfStats and perfStats:FindFirstChild("Ping") then
                local pingValue = tonumber(perfStats.Ping:GetValue())
                pingValue = math.floor(pingValue)
                pinglabel.Text = tostring(pingValue)
            end
        end
    end)
    local saniye = 0
    local dakika = 0
    local saat = 0
    getgenv().zamanbaslaticisi = true
    task.spawn(function()
        while true do
            if getgenv().zamanbaslaticisi then
                saniye += 1
                task.wait(1)
            end
            if saniye >= 60 then
                saniye = 0
                dakika += 1
            end
            if dakika >= 60 then
                dakika = 0
                saat += 1
            end
            timerlabel.Text = string.format("%d:%d:%d", saat, dakika, saniye)
        end
    end)
    task.spawn(function()
        while cashEarnedLabel and cashEarnedLabel.Parent do
            task.wait(1)
            local earned = cashStat.Value - initialCash
            cashEarnedLabel.Text = formatNumber(earned)
        end
    end)
end)

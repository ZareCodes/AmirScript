-- ============================================================
-- RAGE MODE - ALT++ to activate, ALT+- to cancel
-- Uses mouse clicks instead of remote events
-- ============================================================
local RageMode = {
    Active = false,
    Cancelled = false,
    SavedPosition = nil,
    Enemies = {},
    CurrentIndex = 0,
}

local function StartRageMode()
    if RageMode.Active then return end
    
    -- Check if alive
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        print("❌ You must be alive!")
        return
    end
    
    -- Save current position
    RageMode.SavedPosition = LocalPlayer.Character.HumanoidRootPart.CFrame
    
    -- Get all enemies
    RageMode.Enemies = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and not IsTeammate(player) then
            local head = player.Character:FindFirstChild("Head")
            if head then
                table.insert(RageMode.Enemies, player)
            end
        end
    end
    
    if #RageMode.Enemies == 0 then
        print("❌ No enemies found!")
        return
    end
    
    RageMode.Active = true
    RageMode.Cancelled = false
    RageMode.CurrentIndex = 1
    
    print("🔥 RAGE MODE STARTED!")
    print("🎯 " .. #RageMode.Enemies .. " enemies to eliminate!")
end

local function CancelRageMode()
    RageMode.Cancelled = true
    RageMode.Active = false
    print("🛑 RAGE MODE CANCELLED!")
    
    -- Teleport back
    if RageMode.SavedPosition and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = RageMode.SavedPosition
    end
end

local function ProcessRageMode()
    if not RageMode.Active then return end
    if RageMode.Cancelled then return end
    
    if RageMode.CurrentIndex > #RageMode.Enemies then
        -- All enemies eliminated!
        RageMode.Active = false
        print("✅ RAGE MODE COMPLETE!")
        if RageMode.SavedPosition and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = RageMode.SavedPosition
        end
        return
    end
    
    local enemy = RageMode.Enemies[RageMode.CurrentIndex]
    
    -- Check if enemy still alive
    if not enemy.Character or not enemy.Character:FindFirstChild("Head") then
        RageMode.CurrentIndex = RageMode.CurrentIndex + 1
        return
    end
    
    local head = enemy.Character:FindFirstChild("Head")
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if not root or not head then
        RageMode.CurrentIndex = RageMode.CurrentIndex + 1
        return
    end
    
    -- Teleport near enemy (behind them)
    local behindPos = head.Position + (head.CFrame.LookVector * -8) + Vector3.new(0, 3, 0)
    root.CFrame = CFrame.new(behindPos, head.Position)
    
    -- Aim camera at enemy head
    Camera.CFrame = CFrame.new(root.Position, head.Position)
    
    -- Move mouse to center of screen (where head should be)
    local headPos, onScreen = Camera:WorldToViewportPoint(head.Position)
    if onScreen then
        -- Move mouse to head position
        local mouse = LocalPlayer:GetMouse()
        local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        local moveVector = (Vector2.new(headPos.X, headPos.Y) - screenCenter)
        mousemoverel(moveVector.X, moveVector.Y)
        
        -- Click to shoot
        task.wait(0.05)
        mouse1click()
        
        -- Hold for automatic weapons
        task.wait(0.1)
        mouse1click()
    end
    
    -- Wait then move to next enemy
    task.wait(0.2)
    RageMode.CurrentIndex = RageMode.CurrentIndex + 1
end-- ============================================================
-- RAGE MODE - ALT++ to activate, ALT+- to cancel
-- Uses mouse clicks instead of remote events
-- ============================================================
local RageMode = {
    Active = false,
    Cancelled = false,
    SavedPosition = nil,
    Enemies = {},
    CurrentIndex = 0,
}

local function StartRageMode()
    if RageMode.Active then return end
    
    -- Check if alive
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        print("❌ You must be alive!")
        return
    end
    
    -- Save current position
    RageMode.SavedPosition = LocalPlayer.Character.HumanoidRootPart.CFrame
    
    -- Get all enemies
    RageMode.Enemies = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and not IsTeammate(player) then
            local head = player.Character:FindFirstChild("Head")
            if head then
                table.insert(RageMode.Enemies, player)
            end
        end
    end
    
    if #RageMode.Enemies == 0 then
        print("❌ No enemies found!")
        return
    end
    
    RageMode.Active = true
    RageMode.Cancelled = false
    RageMode.CurrentIndex = 1
    
    print("🔥 RAGE MODE STARTED!")
    print("🎯 " .. #RageMode.Enemies .. " enemies to eliminate!")
end

local function CancelRageMode()
    RageMode.Cancelled = true
    RageMode.Active = false
    print("🛑 RAGE MODE CANCELLED!")
    
    -- Teleport back
    if RageMode.SavedPosition and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = RageMode.SavedPosition
    end
end

local function ProcessRageMode()
    if not RageMode.Active then return end
    if RageMode.Cancelled then return end
    
    if RageMode.CurrentIndex > #RageMode.Enemies then
        -- All enemies eliminated!
        RageMode.Active = false
        print("✅ RAGE MODE COMPLETE!")
        if RageMode.SavedPosition and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = RageMode.SavedPosition
        end
        return
    end
    
    local enemy = RageMode.Enemies[RageMode.CurrentIndex]
    
    -- Check if enemy still alive
    if not enemy.Character or not enemy.Character:FindFirstChild("Head") then
        RageMode.CurrentIndex = RageMode.CurrentIndex + 1
        return
    end
    
    local head = enemy.Character:FindFirstChild("Head")
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if not root or not head then
        RageMode.CurrentIndex = RageMode.CurrentIndex + 1
        return
    end
    
    -- Teleport near enemy (behind them)
    local behindPos = head.Position + (head.CFrame.LookVector * -8) + Vector3.new(0, 3, 0)
    root.CFrame = CFrame.new(behindPos, head.Position)
    
    -- Aim camera at enemy head
    Camera.CFrame = CFrame.new(root.Position, head.Position)
    
    -- Move mouse to center of screen (where head should be)
    local headPos, onScreen = Camera:WorldToViewportPoint(head.Position)
    if onScreen then
        -- Move mouse to head position
        local mouse = LocalPlayer:GetMouse()
        local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        local moveVector = (Vector2.new(headPos.X, headPos.Y) - screenCenter)
        mousemoverel(moveVector.X, moveVector.Y)
        
        -- Click to shoot
        task.wait(0.05)
        mouse1click()
        
        -- Hold for automatic weapons
        task.wait(0.1)
        mouse1click()
    end
    
    -- Wait then move to next enemy
    task.wait(0.2)
    RageMode.CurrentIndex = RageMode.CurrentIndex + 1
end

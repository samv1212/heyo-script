local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Heyo Hub ",
    LoadingTitle = "Heyo Hub Loading...",
    LoadingSubtitle = "enjoy brah",

    ConfigurationSaving = {
        Enabled = true,
        FolderName = "HeyoHub",
        FileName = "Config"
    },

    Discord = {
        Enabled = true,
        Invite = "nTSF8qMYbA",
        RememberJoins = true
    },

    KeySystem = true,
    KeySettings = {
        Title = "Heyo Hub Key",
        Subtitle = "Key System",
        Note = "Join Discord to get key",
        FileName = "HeyoKey",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {"heyo1234567890"}
    }
})

Rayfield:Notify({
   Title = "Thanks for using our script enjoy brah",
   Content = "just a thank you note",
   Duration = 6.5,
   Image = 11176073563,
})

--  AMETHYST THEME
Rayfield:LoadConfiguration() -- keep config

-- Tabs
local HackTab = Window:CreateTab("Hacks", 4483362458)
local ScriptTab = Window:CreateTab("Launching Scripts", 4483362458)

-- Services
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer

-- Vars
local flying = false
local flySpeed = 50
_G.infJump = false

-- FULLBRIGHT
local function fullbright(v)
    if v then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
    end
end

-- FLY
local function startFly()
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9,1e9,1e9)
    bv.Parent = hrp

    while flying do
        local cam = workspace.CurrentCamera
        local move = Vector3.new()

        if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0,1,0) end

        if move.Magnitude > 0 then
            bv.Velocity = move.Unit * flySpeed
        else
            bv.Velocity = Vector3.new()
        end

        task.wait()
    end

    bv:Destroy()
end

-- HACK TAB

HackTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(v)
        flying = v
        if v then task.spawn(startFly) end
    end
})

HackTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10,300},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(v)
        flySpeed = v
    end
})

HackTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16,300},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        local h = LP.Character and LP.Character:FindFirstChild("Humanoid")
        if h then h.WalkSpeed = v end
    end
})

HackTab:CreateSlider({
    Name = "JumpPower",
    Range = {50,300},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(v)
        local h = LP.Character and LP.Character:FindFirstChild("Humanoid")
        if h then h.JumpPower = v end
    end
})

HackTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(v)
        _G.infJump = v
    end
})

UIS.JumpRequest:Connect(function()
    if _G.infJump then
        local h = LP.Character and LP.Character:FindFirstChild("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

HackTab:CreateToggle({
    Name = "Fullbright",
    CurrentValue = false,
    Callback = function(v)
        fullbright(v)
    end
})

--  SCRIPT TAB

ScriptTab:CreateButton({
    Name = "Launch Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

Window.ModifyTheme('Amethyst')

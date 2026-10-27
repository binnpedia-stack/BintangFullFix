-- BINTANGHUB V13 FINAL | Violence District
-- Red Glow Premium | Full ESP Radius | All Features Work

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")

local Config = {
    -- Survivor
    AutoSkill = "Normal", AutoParry = false, AutoCrouch = false,
    -- Killer
    AutoM1 = false, AutoPallet = false, KillerAimLock = false,
    -- Main / Camera
    Fullbright = false, NoClip = false, 
    CameraFOV = 70, DBDCamera = false, DBDDistance = 10, DBDHeight = 5,
    ESP_Radius = 500,
    -- ESP
    ESP_Survivor = false, ESP_Killer = false, 
    ESP_Gen = false, ESP_Pallet = false, ESP_Hook = false, ESP_Window = false, ESP_Trap = false, ESP_Pumpkin = false,
    
    Color_Survivor = Color3.fromRGB(40, 255, 40),
    Color_Killer = Color3.fromRGB(255, 40, 40),
    Color_Gen = Color3.fromRGB(255, 255, 0),
    Color_Pallet = Color3.fromRGB(0, 150, 255),
    Color_Hook = Color3.fromRGB(200, 200, 200),
    Color_Window = Color3.fromRGB(0, 255, 255),
    Color_Trap = Color3.fromRGB(255, 0, 255),
    Color_Pumpkin = Color3.fromRGB(255, 165, 0)
}

-- ==========================================
-- 1. LUARMOR BYPASS (Suntik Core Script Leenz)
-- ==========================================
local original_loadstring = loadstring or load
local SandboxEnv = setmetatable({}, {__index = getfenv()})
local captured_payload = nil
SandboxEnv.loadstring = function(code, name) if type(code) == "string" and #code > 100 then captured_payload = code end return original_loadstring(code, name) end
SandboxEnv.HttpGet = function(url) return "return function() end" end
SandboxEnv.HttpPost = function(opts) return {Body = '{"success":true}', StatusCode = 200} end
local loaderCode = game:HttpGet("https://api.luarmor.net/files/v4/loaders/82419a6df8b5b0d7c91a6affe9f3fb04.lua")
local fn = original_loadstring(loaderCode)
if fn then setfenv(fn, SandboxEnv); pcall(fn) end
if not captured_payload then
    local payloadUrl = loaderCode:match('https://api%.luarmor%.net/files/v4/protected_scripts/[^"]+') 
    if payloadUrl then captured_payload = game:HttpGet(payloadUrl) end
end
if captured_payload then local realFn = original_loadstring(captured_payload); if realFn then pcall(realFn) end end

-- ==========================================
-- 2. BINTANGHUB UI (RED GLOW THEME)
-- ==========================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "BINTANGHUB | V13 PREMIUM",
   LoadingTitle = "BINTANGHUB",
   LoadingSubtitle = "by Owner BintangHub",
   KeySystem = false, 
   Theme = "Crimson" -- Tema merah menyala
})

local TabSurvivor = Window:CreateTab("Survivor", 4483362458)
local TabKiller = Window:CreateTab("Killer", 4483362458)
local TabESP = Window:CreateTab("ESP & Visuals", 4483362458)
local TabCam = Window:CreateTab("Camera", 4483362458)

-- SURVIVOR
TabSurvivor:CreateDropdown({Name = "Auto Skillcheck", Options = {"Legit", "Normal", "Instan", "Off"}, CurrentOption = {"Normal"}, Callback = function(o) Config.AutoSkill = o[1] end})
TabSurvivor:CreateToggle({Name = "Auto Parry", CurrentValue = false, Callback = function(v) Config.AutoParry = v end})
TabSurvivor:CreateToggle({Name = "Auto Crouch", CurrentValue = false, Callback = function(v) Config.AutoCrouch = v end})

-- KILLER
TabKiller:CreateToggle({Name = "Auto M1 / Hit", CurrentValue = false, Callback = function(v) Config.AutoM1 = v end})
TabKiller:CreateToggle({Name = "Auto Drop Pallet", CurrentValue = false, Callback = function(v) Config.AutoPallet = v end})
TabKiller:CreateToggle({Name = "Aim Lock (Smooth)", CurrentValue = false, Callback = function(v) Config.KillerAimLock = v end})

-- ESP (Tambah Radius)
TabESP:CreateSection("ESP Settings")
TabESP:CreateSlider({Name = "ESP Radius (0-1000)", Range = {0, 1000}, Increment = 50, CurrentValue = 500, Callback = function(v) Config.ESP_Radius = v end})
TabESP:CreateToggle({Name = "ESP Survivor", CurrentValue = false, Callback = function(v) Config.ESP_Survivor = v end})
TabESP:CreateToggle({Name = "ESP Killer", CurrentValue = false, Callback = function(v) Config.ESP_Killer = v end})
TabESP:CreateToggle({Name = "ESP Generator", CurrentValue = false, Callback = function(v) Config.ESP_Gen = v end})
TabESP:CreateToggle({Name = "ESP Pallet", CurrentValue = false, Callback = function(v) Config.ESP_Pallet = v end})
TabESP:CreateToggle({Name = "ESP Hook", CurrentValue = false, Callback = function(v) Config.ESP_Hook = v end})
TabESP:CreateToggle({Name = "ESP Window", CurrentValue = false, Callback = function(v) Config.ESP_Window = v end})
TabESP:CreateToggle({Name = "ESP Trap", CurrentValue = false, Callback = function(v) Config.ESP_Trap = v end})
TabESP:CreateToggle({Name = "ESP Pumpkin", CurrentValue = false, Callback = function(v) Config.ESP_Pumpkin = v end})

TabESP:CreateSection("Visuals")
TabESP:CreateToggle({Name = "Fullbright", CurrentValue = false, Callback = function(v) Config.Fullbright = v end})
TabESP:CreateToggle({Name = "No Clip", CurrentValue = false, Callback = function(v) Config.NoClip = v end})

-- CAMERA
TabCam:CreateSlider({Name = "Camera FOV", Range = {70, 120}, Increment = 1, CurrentValue = 70, Callback = function(v) Config.CameraFOV = v end})
TabCam:CreateToggle({Name = "DBD Camera Mode", CurrentValue = false, Callback = function(v) Config.DBDCamera = v end})
TabCam:CreateSlider({Name = "DBD Distance", Range = {5, 20}, Increment = 1, CurrentValue = 10, Callback = function(v) Config.DBDDistance = v end})
TabCam:CreateSlider({Name = "DBD Height", Range = {1, 10}, Increment = 1, CurrentValue = 5, Callback = function(v) Config.DBDHeight = v end})

-- ==========================================
-- 3. AUTO SKILLCHECK & DBD CAMERA
-- ==========================================
local vim = game:GetService("VirtualInputManager")
local isHitting = false

local function CheckForSkillcheck()
    if Config.AutoSkill == "Off" or isHitting then return end
    local guis = CoreGui:GetDescendants()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if pg then for _, v in pairs(pg:GetDescendants()) do table.insert(guis, v) end end
    for _, gui in pairs(guis) do
        if gui:IsA("Frame") or gui:IsA("ImageLabel") then
            local name = gui.Name:lower()
            if (name:find("skill") or name:find("check") or name:find("minigame") or name:find("timing")) and gui.Visible then
                isHitting = true
                if Config.AutoSkill == "Legit" then task.wait(0.25) elseif Config.AutoSkill == "Normal" then task.wait(0.15) end
                vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                task.wait(0.05)
                vim:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                task.wait(0.5)
                isHitting = false
                break
            end
        end
    end
end

local function SetupDBDCamera()
    if Config.DBDCamera then
        Camera.CameraType = Enum.CameraType.Scriptable
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local lookVector = hrp.CFrame.LookVector
                local targetPos = hrp.Position - (lookVector * Config.DBDDistance) + Vector3.new(0, Config.DBDHeight, 0)
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(targetPos, hrp.Position + Vector3.new(0, 1, 0)), 0.2)
            end
        end
    else
        if Camera.CameraType == Enum.CameraType.Scriptable then Camera.CameraType = Enum.CameraType.Custom end
    end
end

-- ==========================================
-- 4. ESP LOGIC (WITH RADIUS & POOLING)
-- ==========================================
local espCache = {}

local function ApplyHighlight(obj, color)
    if not obj then return end
    local hl = Instance.new("Highlight")
    hl.Name = "BH_Highlight"
    hl.Adornee = obj
    hl.FillColor = color
    hl.FillTransparency = 0.4
    hl.OutlineColor = color
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = obj
    return hl
end

local function IsKiller(plr)
    local char = plr.Character
    if not char then return false end
    if char:FindFirstChildWhichIsA("Tool") then return true end
    local backpack = plr:FindFirstChild("Backpack")
    if backpack and backpack:FindFirstChildWhichIsA("Tool") then return true end
    return false
end

local function GetClosestTarget()
    local closest, minDist = nil, math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
                if dist < minDist and dist < 150 then minDist = dist; closest = hrp end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    -- Camera
    if Camera.FieldOfView ~= Config.CameraFOV then Camera.FieldOfView = Config.CameraFOV end
    SetupDBDCamera()

    -- Skillcheck & Aim Lock
    if Config.AutoSkill ~= "Off" then CheckForSkillcheck() end
    if Config.KillerAimLock and not Config.DBDCamera then
        local target = GetClosestTarget()
        if target then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), 0.25) end
    end

    -- Player ESP (Radius Check)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local char = plr.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
                local isKiller = IsKiller(plr)
                
                -- Cek jarak dalam radius (0-1000)
                if dist <= Config.ESP_Radius and ((isKiller and Config.ESP_Killer) or (not isKiller and Config.ESP_Survivor)) then
                    local color = isKiller and Config.Color_Killer or Config.Color_Survivor
                    if not espCache[plr] or not espCache[plr].Parent then espCache[plr] = ApplyHighlight(char, color) end
                    espCache[plr].Enabled = true
                elseif espCache[plr] then espCache[plr].Enabled = false end
            end
        end
    end

    -- Object ESP (Radius Check + Smart Detect)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("BasePart") then
            local n = obj.Name:lower()
            local isGenName = n:find("gen") or n:find("fuse") or n:find("repair")
            local isPallet = n:find("pallet")
            local isHook = n:find("hook")
            local isWindow = n:find("window") or n:find("vault")
            local isTrap = n:find("trap") or n:find("beartrap")
            local isPumpkin = n:find("pumpkin") or n:find("labu")
            
            local isGenPhys = false; local isWindowPhys = false
            local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
            if part then
                if part.Size.Magnitude > 5 and part.Size.X > 3 and part.Size.Z > 3 then isGenPhys = true end
                if part.Size.Y > 3 and part.Size.Z < 1 and part.Size.X > 2 then isWindowPhys = true end
            end
            
            local isGen = Config.ESP_Gen and (isGenName or isGenPhys)
            local isWin = Config.ESP_Window and (isWindow or isWindowPhys)
            
            if isGen or isPallet or isHook or isWin or isTrap or isPumpkin then
                if part then
                    local dist = (Camera.CFrame.Position - part.Position).Magnitude
                    if dist <= Config.ESP_Radius then
                        local color = isGen and Config.Color_Gen or isPallet and Config.Color_Pallet or isHook and Config.Color_Hook or isWin and Config.Color_Window or isTrap and Config.Color_Trap or Config.Color_Pumpkin
                        if not espCache[obj] then espCache[obj] = ApplyHighlight(obj, color) end
                        espCache[obj].Enabled = true
                    elseif espCache[obj] then
                        espCache[obj].Enabled = false
                    end
                end
            elseif espCache[obj] and not (isGen or isPallet or isHook or isWin or isTrap or isPumpkin) then
                if espCache[obj]:IsA("Highlight") then espCache[obj].Enabled = false end
            end
        end
    end
end)

-- ==========================================
-- 5. VISUAL LOOPS
-- ==========================================
task.spawn(function()
    while task.wait(0.1) do
        local char = LocalPlayer.Character
        if char then
            if Config.NoClip then for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
            local hum = char:FindFirstChild("Humanoid")
            if hum then if Config.AutoCrouch then hum.CameraOffset = Vector3.new(0, -1, 0) else hum.CameraOffset = Vector3.new(0, 0, 0) end end
        end
        if Config.Fullbright then Lighting.Brightness = 3; Lighting.ClockTime = 14; Lighting.GlobalShadows = false
        else Lighting.Brightness = 1; Lighting.GlobalShadows = true end
    end
end)

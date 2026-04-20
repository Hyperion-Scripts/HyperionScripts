local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

local function clickButton(btn)
    if not btn then return false end
    local ok1 = pcall(function()
        for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do
            conn:Fire()
        end
    end)
    if ok1 then return true end
    local ok2 = pcall(function() firesignal(btn.MouseButton1Click) end)
    if ok2 then return true end
    local ok3 = pcall(function()
        for _, conn in ipairs(getconnections(btn.Activated)) do
            conn:Fire()
        end
    end)
    return ok3
end

local function maxSlider(sliderFrame)
    if not sliderFrame then return false end
    for _, desc in ipairs(sliderFrame:GetDescendants()) do
        pcall(function()
            if desc:IsA("Frame") or desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
                local nameLow = desc.Name:lower()
                if nameLow:find("bar") or nameLow:find("fill") or nameLow:find("progress") then
                    desc.Size = UDim2.new(1, 0, desc.Size.Y.Scale, desc.Size.Y.Offset)
                end
                if nameLow:find("knob") or nameLow:find("handle") or nameLow:find("button") or nameLow:find("drag") then
                    desc.Position = UDim2.new(1, 0, desc.Position.Y.Scale, desc.Position.Y.Offset)
                end
            end
            if desc:IsA("NumberValue") or desc:IsA("IntValue") then
                desc.Value = 1
            end
        end)
    end
    pcall(function()
        if sliderFrame:IsA("TextButton") or sliderFrame:IsA("ImageButton") then
            clickButton(sliderFrame)
        end
    end)
    return true
end

local voice = PG:FindFirstChild("hub")
    and PG.hub:FindFirstChild("bg")
    and PG.hub.bg:FindFirstChild("voice")

if not voice then return end

local eqActivate = voice:FindFirstChild("effect")
    and voice.effect:FindFirstChild("equalier")
    and voice.effect.equalier:FindFirstChild("activate")

if eqActivate then
    clickButton(eqActivate)
end

task.wait(1)

local eqDrag = voice:FindFirstChild("bg")
    and voice.bg:FindFirstChild("drag")
    and voice.bg.drag:FindFirstChild("equalier")

if eqDrag then
    local eqInner = eqDrag:FindFirstChild("drag") or eqDrag
    for _, gainName in ipairs({"low_gain", "mid_gain", "high_gain"}) do
        local slider = eqInner:FindFirstChild(gainName)
        if slider then maxSlider(slider) end
        task.wait(0.5)
    end
end

local propRemote = RS:FindFirstChild("event_effect_property")
if propRemote then
    task.wait(0.5)
    propRemote:FireServer("equalier", "LowGain", 9.999999999999999999999999999999999)
    task.wait(0.3)
    propRemote:FireServer("equalier", "MidGain", 9.999999999999999999999999999999999)
    task.wait(0.3)
    propRemote:FireServer("equalier", "HighGain", 9.999999999999999999999999999999999)
end

print("\n[Hyperion] ═══ EQUALIZER MAXED ═══")

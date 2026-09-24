--// LoadLucideIcon.lua (ModuleScript)
local Module = {}

local LucideModule
do
    local ok, result = pcall(function()
        return (loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/mstudio45/lucide-roblox-direct/refs/heads/main/source.lua"
        )) :: () -> any)()
    end)
    if ok and result then LucideModule = result end
end

local IconCache = {}

local function GetIcon(Name)
    if IconCache[Name] then return IconCache[Name] end
    if not LucideModule then return nil end
    local ok, Icon = pcall(LucideModule.GetAsset, Name)
    if not ok or not Icon then return nil end
    IconCache[Name] = Icon
    return Icon
end

function Module.Load(name, frame, color, rotation)
    local Icon = GetIcon(name)
    if not Icon then return nil end

    local ImageGui = frame:FindFirstChild("__LucideIcon")
    if not ImageGui then
        ImageGui = Instance.new("ImageLabel")
        ImageGui.Name = "__LucideIcon"
        ImageGui.BackgroundTransparency = 1
        ImageGui.BorderSizePixel = 0
        ImageGui.Size = UDim2.fromScale(1, 1)
        ImageGui.ScaleType = Enum.ScaleType.Fit
        ImageGui.Parent = frame
    end

    ImageGui.ImageColor3 = typeof(color) == "Color3" and color or Color3.new(1,1,1)
    ImageGui.Rotation = tonumber(rotation) or 0
    ImageGui.Image = Icon.Url
    ImageGui.ImageRectOffset = Icon.ImageRectOffset or Vector2.zero
    ImageGui.ImageRectSize = Icon.ImageRectSize or Vector2.zero

    return ImageGui
end

return Module

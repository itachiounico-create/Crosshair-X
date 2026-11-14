
-- CROSSHAIR X V5.3
-- INTERFACE + SISTEMA DE SHADERS REALISTAS

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Terrain = workspace.Terrain

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Old = PlayerGui:FindFirstChild("CrosshairX")
if Old then Old:Destroy() end

local C = {
	Red = Color3.fromRGB(255, 25, 48),
	Dark = Color3.fromRGB(8, 8, 11),
	Panel = Color3.fromRGB(14, 14, 18),
	Card = Color3.fromRGB(23, 22, 27),
	White = Color3.fromRGB(245, 245, 248),
	Gray = Color3.fromRGB(145, 140, 150),
	Border = Color3.fromRGB(57, 34, 42),
	RedDark = Color3.fromRGB(65, 13, 27)
}

local T = {
	Armor = Color3.fromRGB(32, 30, 38),
	Armor2 = Color3.fromRGB(48, 45, 56),
	Light = Color3.fromRGB(95, 90, 105),
	Black = Color3.fromRGB(10, 10, 14),
	RedDark = Color3.fromRGB(95, 18, 35)
}

local function New(class, props, parent)
	local obj = Instance.new(class)
	for k, v in pairs(props) do
		obj[k] = v
	end
	obj.Parent = parent
	return obj
end

local function Round(obj, radius)
	New("UICorner", {
		CornerRadius = UDim.new(0, radius)
	}, obj)
end

local function Stroke(obj, color, thickness)
	return New("UIStroke", {
		Color = color or C.Border,
		Thickness = thickness or 1
	}, obj)
end

local function Label(parent, text, size, pos, color, font)
	return New("TextLabel", {
		BackgroundTransparency = 1,
		Size = size,
		Position = pos,
		Text = text,
		TextColor3 = color or C.White,
		TextSize = 13,
		Font = font or Enum.Font.Gotham,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextWrapped = true
	}, parent)
end

local function Animate(obj, props)
	TweenService:Create(
		obj,
		TweenInfo.new(0.16, Enum.EasingStyle.Quad),
		props
	):Play()
end

-- GUI PRINCIPAL

local Gui = New("ScreenGui", {
	Name = "CrosshairX",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 100
}, PlayerGui)

-- BOTÃO FLUTUANTE

local Floating = New("TextButton", {
	Size = UDim2.fromOffset(55, 55),
	Position = UDim2.new(0, 14, 0.5, -27),
	BackgroundColor3 = C.Dark,
	Text = "CX",
	TextColor3 = C.Red,
	TextSize = 20,
	Font = Enum.Font.GothamBlack,
	AutoButtonColor = false,
	ZIndex = 10
}, Gui)

Round(Floating, 50)
Stroke(Floating, C.Red, 2)

-- JANELA

local Main = New("Frame", {
	Name = "Main",
	Size = UDim2.fromOffset(900, 460),
	Position = UDim2.fromScale(0.5, 0.5),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = C.Dark,
	BorderSizePixel = 0,
	ClipsDescendants = false
}, Gui)

Round(Main, 12)
Stroke(Main, C.Red, 1.5)

local Scale = New("UIScale", {
	Scale = 1
}, Main)

-- ESCALA RESPONSIVA

local function UpdateScale()
	local camera = workspace.CurrentCamera
	if not camera then return end
	local v = camera.ViewportSize
	Scale.Scale = math.max(0.1, math.min(1, (v.X - 18) / 900, (v.Y - 35) / 460))
end

local cameraConnection
local function ConnectCamera()
	if cameraConnection then cameraConnection:Disconnect() end
	local camera = workspace.CurrentCamera
	if not camera then return end
	UpdateScale()
	cameraConnection = camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
end

ConnectCamera()
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(ConnectCamera)

-- CABEÇALHO

local Header = New("Frame", {
	Size = UDim2.new(1, 0, 0, 70),
	BackgroundColor3 = Color3.fromRGB(17, 13, 17),
	BorderSizePixel = 0,
	ZIndex = 2
}, Main)

Label(Header, "CROSSHAIR X", UDim2.fromOffset(300, 39), UDim2.fromOffset(20, 4), C.White, Enum.Font.GothamBlack).TextSize = 32
Label(Header, "INTERFACE PREMIUM  /  V5.3", UDim2.fromOffset(280, 19), UDim2.fromOffset(22, 40), C.Red, Enum.Font.GothamBold).TextSize = 11

local Status = Label(Header, "● VISUAL ATIVO", UDim2.fromOffset(150, 30), UDim2.new(1, -205, 0, 20), C.Red, Enum.Font.GothamBold)
Status.TextXAlignment = Enum.TextXAlignment.Right
Status.TextSize = 12

local Close = New("TextButton", {
	Size = UDim2.fromOffset(36, 36),
	Position = UDim2.new(1, -47, 0, 17),
	BackgroundColor3 = C.RedDark,
	Text = "×",
	TextColor3 = C.Red,
	TextSize = 26,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
}, Header)

Round(Close, 7)

New("Frame", {
	Size = UDim2.new(1, 0, 0, 2),
	Position = UDim2.new(0, 0, 1, -2),
	BackgroundColor3 = C.Red,
	BorderSizePixel = 0
}, Header)

local MenuTitle = New("TextLabel", {
	Name = "MenuTitle",
	Size = UDim2.new(1, -418, 0, 30),
	Position = UDim2.fromOffset(181, 72),
	BackgroundTransparency = 1,
	Text = "CROSSHAIR X",
	TextColor3 = C.White,
	TextSize = 17,
	Font = Enum.Font.GothamBlack,
	TextXAlignment = Enum.TextXAlignment.Center,
	TextYAlignment = Enum.TextYAlignment.Center,
	ZIndex = 5
}, Main)

-- ESTRUTURA PRINCIPAL

local Sidebar = New("Frame", {
	Size = UDim2.new(0, 165, 1, -82),
	Position = UDim2.fromOffset(8, 76),
	BackgroundColor3 = C.Panel,
	BorderSizePixel = 0
}, Main)

Round(Sidebar, 8)
Stroke(Sidebar)

local Content = New("Frame", {
	Size = UDim2.new(1, -418, 1, -114),
	Position = UDim2.fromOffset(181, 108),
	BackgroundColor3 = C.Panel,
	BorderSizePixel = 0,
	ClipsDescendants = true
}, Main)

Round(Content, 8)
Stroke(Content)

local Preview = New("Frame", {
	Size = UDim2.new(0, 225, 1, -82),
	Position = UDim2.new(1, -233, 0, 76),
	BackgroundColor3 = C.Panel,
	BorderSizePixel = 0
}, Main)

Round(Preview, 8)
Stroke(Preview)

-- MENU LATERAL

Label(Sidebar, "NAVEGAÇÃO", UDim2.new(1, -20, 0, 30), UDim2.fromOffset(12, 9), C.Gray, Enum.Font.GothamBold).TextSize = 12

New("Frame", {
	Size = UDim2.new(1, -20, 0, 1),
	Position = UDim2.fromOffset(10, 42),
	BackgroundColor3 = C.Border,
	BorderSizePixel = 0
}, Sidebar)

local PageData = {
	{"⌂", "Início"},
	{"◈", "Visual"},
	{"⚔", "Combate"},
	{"✧", "Visual Shaders"},
	{"◎", "Crosshair"},
	{"▣", "Interface"},
	{"⚙", "Configurações"},
	{"ⓘ", "Sobre"}
}

local Pages = {}
local PageButtons = {}
local CategoryButtons = {}
local CurrentPage = "Início"
local CurrentCategory = "Geral"

local TopBar = New("Frame", {
	Size = UDim2.new(1, -16, 0, 39),
	Position = UDim2.fromOffset(8, 8),
	BackgroundColor3 = C.Card,
	BorderSizePixel = 0
}, Content)

Round(TopBar, 6)

local function CreateCard(parent, title, description, index)
	local card = New("Frame", {
		Size = UDim2.new(1, -24, 0, 76),
		Position = UDim2.fromOffset(12, 12 + (index - 1) * 88),
		BackgroundColor3 = C.Card,
		BorderSizePixel = 0
	}, parent)

	Round(card, 7)
	Stroke(card, C.Border)

	New("Frame", {
		Size = UDim2.fromOffset(3, 45),
		Position = UDim2.fromOffset(10, 15),
		BackgroundColor3 = C.Red,
		BorderSizePixel = 0
	}, card)

	Label(card, title, UDim2.new(1, -35, 0, 27), UDim2.fromOffset(22, 8), C.White, Enum.Font.GothamBold).TextSize = 14
	Label(card, description, UDim2.new(1, -35, 0, 24), UDim2.fromOffset(22, 39), C.Gray, Enum.Font.Gotham).TextSize = 11
end

local CombatStates = {}
local CombatValues = {}
local ShaderCallbacks = {}

-- ==========================================
-- SISTEMA DE SHADERS REALISTAS (V1, V2, V3)
-- ==========================================

local ActiveEffects = {}
local OriginalProps = {}
local DayCycleConn = nil
local RimLights = {}

local function SaveProp(obj, prop)
	if OriginalProps[obj] and OriginalProps[obj][prop] ~= nil then return end
	local ok, val = pcall(function() return obj[prop] end)
	if ok then
		OriginalProps[obj] = OriginalProps[obj] or {}
		OriginalProps[obj][prop] = val
	end
end

local function SafeSet(obj, prop, val)
	pcall(function() obj[prop] = val end)
end

local function ClearAllShaders()
	if DayCycleConn then
		DayCycleConn:Disconnect()
		DayCycleConn = nil
	end

	for _, eff in ipairs(ActiveEffects) do
		if eff and eff.Parent then eff:Destroy() end
	end
	table.clear(ActiveEffects)

	for _, hl in ipairs(RimLights) do
		if hl and hl.Parent then hl:Destroy() end
	end
	table.clear(RimLights)

	for obj, props in pairs(OriginalProps) do
		if obj and obj.Parent then
			for prop, val in pairs(props) do
				SafeSet(obj, prop, val)
			end
		end
	end
	table.clear(OriginalProps)
end

local function AddEffect(className, name, props)
	local eff = Instance.new(className)
	eff.Name = "CrosshairX_" .. name
	for k, v in pairs(props) do SafeSet(eff, k, v) end
	eff.Parent = Lighting
	table.insert(ActiveEffects, eff)
	return eff
end

local function BackupBase()
	for _, p in ipairs({"Technology", "GlobalShadows", "Brightness", "ExposureCompensation", "Ambient", "OutdoorAmbient", "EnvironmentDiffuseScale", "EnvironmentSpecularScale", "ShadowSoftness", "ColorShift_Top", "ColorShift_Bottom", "ClockTime"}) do
		SaveProp(Lighting, p)
	end
	for _, p in ipairs({"WaterColor", "WaterTransparency", "WaterReflectance", "WaterWaveSize", "WaterWaveSpeed"}) do
		SaveProp(Terrain, p)
	end
end

-- SHADERS V1 (Leve e Limpo)
ShaderCallbacks["SHADERS V1"] = function(enabled)
	ClearAllShaders()
	if not enabled then return end
	BackupBase()

	SafeSet(Lighting, "Technology", Enum.Technology.Future)
	SafeSet(Lighting, "GlobalShadows", true)
	SafeSet(Lighting, "Brightness", 2.4)
	SafeSet(Lighting, "EnvironmentDiffuseScale", 0.8)
	SafeSet(Lighting, "EnvironmentSpecularScale", 1)

	AddEffect("ColorCorrectionEffect", "CC_V1", { Brightness = 0.03, Contrast = 0.14, Saturation = 0.18, TintColor = Color3.fromRGB(255, 246, 238) })
	AddEffect("BloomEffect", "Bloom_V1", { Intensity = 0.35, Size = 24, Threshold = 1.1 })
end

-- SHADERS V2 (Água Realista + Ciclo Dinâmico)
ShaderCallbacks["SHADERS V2"] = function(enabled)
	ClearAllShaders()
	if not enabled then return end
	BackupBase()

	SafeSet(Lighting, "Technology", Enum.Technology.Future)
	SafeSet(Lighting, "GlobalShadows", true)
	SafeSet(Lighting, "Brightness", 2.8)
	SafeSet(Lighting, "EnvironmentDiffuseScale", 1)
	SafeSet(Lighting, "EnvironmentSpecularScale", 1)
	SafeSet(Lighting, "Ambient", Color3.fromRGB(60, 70, 90))
	SafeSet(Lighting, "OutdoorAmbient", Color3.fromRGB(100, 115, 140))

	local function Detail(parent, size, pos, color, radius, z)
local obj = New("Frame", { Size = size, Position = pos, BackgroundColor3 = color, BorderSizePixel = 0, ZIndex = z or 5 }, parent)
Round(obj, radius or 3)
return obj
end
local function BodyPart(name, size, pos, radius)
local group = New("Frame", { Size = size, Position = pos, BackgroundTransparency = 1 }, Figure)
local hitbox = New("TextButton", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = T.Armor, BorderSizePixel = 0, Text = "", AutoButtonColor = false, ZIndex = 2 }, group)
Round(hitbox, radius or 7)
local outline = Stroke(hitbox, T.Light, 1)
table.insert(Parts, { Name = name, Hitbox = hitbox, Outline = outline })
hitbox.MouseButton1Click:Connect(function()
CombatValues["Região visual"] = name
for _, item in ipairs(Parts) do
local active = item.Name == name
item.Hitbox.BackgroundColor3 = active and T.RedDark or T.Armor
item.Outline.Color = active and C.Red or T.Light
item.Outline.Thickness = active and 2 or 1
end
SelectionLabel.Text = "REGIÃO: " .. string.upper(name)
end)
return group
end
BodyPart("Cabeça", UDim2.fromOffset(54, 49), UDim2.fromOffset(78, 1), 19)
BodyPart("Braços", UDim2.fromOffset(27, 75), UDim2.fromOffset(34, 88), 10)
BodyPart("Braços", UDim2.fromOffset(27, 75), UDim2.fromOffset(149, 88), 10)
BodyPart("Peito", UDim2.fromOffset(88, 95), UDim2.fromOffset(61, 59), 10)
BodyPart("Pernas", UDim2.fromOffset(36, 82), UDim2.fromOffset(66, 162), 9)
BodyPart("Pernas", UDim2.fromOffset(36, 82), UDim2.fromOffset(104, 162), 9)
local function PreviewRow(title, value, y)
local row = New("Frame", { Size = UDim2.new(1, -20, 0, 43), Position = UDim2.fromOffset(10, y), BackgroundColor3 = C.Card, BorderSizePixel = 0 }, Preview)
Round(row, 6)
Label(row, title, UDim2.new(1, -15, 0, 16), UDim2.fromOffset(9, 3), C.Gray, Enum.Font.GothamBold).TextSize = 9
Label(row, value, UDim2.new(1, -15, 0, 19), UDim2.fromOffset(9, 20), C.White, Enum.Font.GothamBold).TextSize = 11
end
PreviewRow("TEMA", "PRETO / VERMELHO", 214)
PreviewRow("ESTILO", "PREMIUM", 264)
PreviewRow("VERSÃO", "5.3", 314)
-- INICIAR PÁGINA
SelectPage("Início")
-- ABRIR / FECHAR E ARRASTAR
local function Toggle()
Main.Visible = not Main.Visible
end
Close.MouseButton1Click:Connect(Toggle)
Floating.MouseButton1Click:Connect(Toggle)
local dragging, dragStart, startPosition, dragInput
Header.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = input.Position
startPosition = Main.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then dragging = false end
end)
end
end)
Header.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
dragInput = input
end
end)
UIS.InputChanged:Connect(function(input)
if dragging and input == dragInput then
local delta = input.Position - dragStart
Main.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
end
end)
print("CROSSHAIR X V5.3 + Shaders carregados com sucesso!")

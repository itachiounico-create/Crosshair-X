
-- CROSSHAIR X V5.3
-- INTERFACE PROFISSIONAL
-- SOMENTE VISUAL

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

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
        TextYAlignment = Enum.TextYAlignment.Center
    }, parent)
end

local function Animate(obj, props)
    TweenService:Create(
        obj,
        TweenInfo.new(0.16, Enum.EasingStyle.Quad),
        props
    ):Play()
end

-- GUI

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

-- JANELA PRINCIPAL

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

local NormalSize = UDim2.fromOffset(900, 460)
local Minimized = false

-- ESCALA RESPONSIVA

local function UpdateScale()
    local camera = workspace.CurrentCamera
    if not camera then return end

    local v = camera.ViewportSize

    Scale.Scale = math.max(
        0.1,
        math.min(1, (v.X - 18) / 900, (v.Y - 35) / 460)
    )
end

local cameraConnection

local function ConnectCamera()
    if cameraConnection then
        cameraConnection:Disconnect()
    end

    local camera = workspace.CurrentCamera
    if not camera then return end

    UpdateScale()

    cameraConnection =
        camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
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

Label(
    Header,
    "CROSSHAIR X",
    UDim2.fromOffset(300, 39),
    UDim2.fromOffset(20, 4),
    C.White,
    Enum.Font.GothamBlack
).TextSize = 32

Label(
    Header,
    "INTERFACE PREMIUM / V5.3",
    UDim2.fromOffset(280, 19),
    UDim2.fromOffset(22, 40),
    C.Red,
    Enum.Font.GothamBold
).TextSize = 11

local Status = Label(
    Header,
    "● VISUAL ATIVO",
    UDim2.fromOffset(150, 30),
    UDim2.new(1, -245, 0, 20),
    C.Red,
    Enum.Font.GothamBold
)

Status.TextXAlignment = Enum.TextXAlignment.Right
Status.TextSize = 12

local Minimize = New("TextButton", {
    Size = UDim2.fromOffset(36, 36),
    Position = UDim2.new(1, -91, 0, 17),
    BackgroundColor3 = C.RedDark,
    Text = "−",
    TextColor3 = C.White,
    TextSize = 25,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
}, Header)

Round(Minimize, 8)
Stroke(Minimize, C.Red)

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

Round(Close, 8)
Stroke(Close, C.Red)

New("Frame", {
    Size = UDim2.new(1, 0, 0, 2),
    Position = UDim2.new(0, 0, 1, -2),
    BackgroundColor3 = C.Red,
    BorderSizePixel = 0
}, Header)

-- BARRINHA DE MINIMIZAÇÃO

local MiniBar = New("Frame", {
    Name = "MiniBar",
    Size = UDim2.new(1, 0, 0, 48),
    Position = UDim2.fromOffset(0, 0),
    BackgroundColor3 = C.Dark,
    BorderSizePixel = 0,
    Visible = false,
    ZIndex = 20
}, Main)

Round(MiniBar, 10)
Stroke(MiniBar, C.Red, 1.5)

New("TextLabel", {
    Size = UDim2.new(1, -130, 1, 0),
    Position = UDim2.fromOffset(15, 0),
    BackgroundTransparency = 1,
    Text = "CROSSHAIR X",
    TextColor3 = C.White,
    TextSize = 18,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 21
}, MiniBar)

local Restore = New("TextButton", {
    Size = UDim2.fromOffset(36, 32),
    Position = UDim2.new(1, -86, 0.5, -16),
    BackgroundColor3 = C.RedDark,
    Text = "+",
    TextColor3 = C.White,
    TextSize = 23,
    Font = Enum.Font.GothamBold,
    ZIndex = 21
}, MiniBar)

Round(Restore, 7)

local MiniClose = New("TextButton", {
    Size = UDim2.fromOffset(36, 32),
    Position = UDim2.new(1, -43, 0.5, -16),
    BackgroundColor3 = C.RedDark,
    Text = "×",
    TextColor3 = C.Red,
    TextSize = 23,
    Font = Enum.Font.GothamBold,
    ZIndex = 21
}, MiniBar)

Round(MiniClose, 7)

-- TÍTULO NA FAIXA VAZIA

local MenuTitle = New("TextLabel", {
    Name = "MenuTitle",
    Size = UDim2.new(1, 0, 0, 30),
    Position = UDim2.fromOffset(0, 70),
    BackgroundTransparency = 1,
    Text = "CROSSHAIR X",
    TextColor3 = C.White,
    TextSize = 17,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 5
}, Main)

-- ESTRUTURA PRINCIPAL

local Sidebar = New("Frame", {
    Size = UDim2.new(0, 165, 1, -114),
    Position = UDim2.fromOffset(8, 108),
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
    Size = UDim2.new(0, 225, 1, -114),
    Position = UDim2.new(1, -233, 0, 108),
    BackgroundColor3 = C.Panel,
    BorderSizePixel = 0
}, Main)

Round(Preview, 8)
Stroke(Preview)

-- MENU LATERAL

Label(
    Sidebar,
    "NAVEGAÇÃO",
    UDim2.new(1, -20, 0, 30),
    UDim2.fromOffset(12, 9),
    C.Gray,
    Enum.Font.GothamBold
).TextSize = 12

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

-- CATEGORIAS

local TopBar = New("Frame", {
    Size = UDim2.new(1, -16, 0, 39),
    Position = UDim2.fromOffset(8, 8),
    BackgroundColor3 = C.Card,
    BorderSizePixel = 0
}, Content)

Round(TopBar, 6)

-- DADOS DAS PÁGINAS

local Data = {
    ["Início"] = {
        ["Geral"] = {
            {"PAINEL PRINCIPAL", "Bem-vindo à interface CROSSHAIR X."},
            {"SISTEMA VISUAL", "Estrutura carregada com sucesso."}
        },
        ["Aparência"] = {
            {"IDENTIDADE VISUAL", "Preto, vermelho e acabamento neon."},
            {"ESTILO", "Interface escura premium."}
        },
        ["Informações"] = {
            {"VERSÃO", "CROSSHAIR X V5.3"},
            {"STATUS", "Interface visual ativa."}
        }
    },

    ["Visual"] = {
        ["Geral"] = {
            {"TEMA ATUAL", "Preto e vermelho."},
            {"ESTILO VISUAL", "Identidade CROSSHAIR X."}
        },
        ["Aparência"] = {
            {"CORES", "Paleta preta com detalhes vermelhos."},
            {"ACABAMENTO", "Bordas e detalhes neon."}
        },
        ["Informações"] = {
            {"PRÉVIA", "Demonstração visual decorativa."},
            {"IDENTIDADE", "Tema CROSSHAIR X."}
        }
    },

    ["Combate"] = {
        ["Geral"] = {
            {"PAINEL DE COMBATE", "Área visual de demonstração."},
            {"ELEMENTOS", "Organização dos componentes."}
        },
        ["Aparência"] = {
            {"ESTILO", "Tema vermelho e preto."},
            {"DESTAQUES", "Detalhes visuais em vermelho."}
        },
        ["Informações"] = {
            {"MODO", "Somente interface visual."},
            {"STATUS", "Painel demonstrativo."}
        }
    },

    ["Visual Shaders"] = {
        ["Geral"] = {
            {"VISUAL SHADERS", "Painel de apresentação visual."},
            {"EFEITOS", "Prévia decorativa de efeitos."}
        },
        ["Aparência"] = {
            {"ILUMINAÇÃO", "Estilo visual escuro."},
            {"CONTRASTE", "Identidade CROSSHAIR X."}
        },
        ["Informações"] = {
            {"PREVIEW", "Demonstração de aparência."},
            {"SISTEMA", "Elementos decorativos."}
        }
    },

    ["Crosshair"] = {
        ["Geral"] = {
            {"CROSSHAIR", "Prévia decorativa de mira."},
            {"FORMATO", "Modelo visual centralizado."}
        },
        ["Aparência"] = {
            {"COR", "Vermelho neon."},
            {"ESTILO", "Minimalista e personalizado."}
        },
        ["Informações"] = {
            {"PRÉVIA", "Elemento exclusivamente visual."},
            {"STATUS", "Sem interação com o jogo."}
        }
    },

    ["Interface"] = {
        ["Geral"] = {
            {"ESTRUTURA", "Layout horizontal."},
            {"ORGANIZAÇÃO", "Elementos separados por áreas."}
        },
        ["Aparência"] = {
            {"CARTÕES", "Elementos com bordas arredondadas."},
            {"NAVEGAÇÃO", "Botões com destaque visual."}
        },
        ["Informações"] = {
            {"DIMENSÃO", "Estrutura adaptável à tela."},
            {"LAYOUT", "Menu lateral e painel central."}
        }
    },

    ["Configurações"] = {
        ["Geral"] = {
            {"PREFERÊNCIAS", "Área de demonstração visual."},
            {"EXIBIÇÃO", "Organização da interface."}
        },
        ["Aparência"] = {
            {"TEMA", "Preto e vermelho neon."},
            {"ESTILO", "Visual escuro premium."}
        },
        ["Informações"] = {
            {"INTERFACE", "CROSSHAIR X V5.3"},
            {"MODO", "Somente visual."}
        }
    },

    ["Sobre"] = {
        ["Geral"] = {
            {"CROSSHAIR X", "Projeto de interface visual."},
            {"DESENVOLVIMENTO", "Menu premium."}
        },
        ["Aparência"] = {
            {"IDENTIDADE", "Preto e vermelho."},
            {"DESIGN", "Interface horizontal."}
        },
        ["Informações"] = {
            {"VERSÃO", "5.3"},
            {"FINALIDADE", "Demonstração visual."}
        }
    }
}

-- CARTÕES

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

    Label(
        card,
        title,
        UDim2.new(1, -35, 0, 27),
        UDim2.fromOffset(22, 8),
        C.White,
        Enum.Font.GothamBold
    ).TextSize = 14

    Label(
        card,
        description,
        UDim2.new(1, -35, 0, 24),
        UDim2.fromOffset(22, 39),
        C.Gray,
        Enum.Font.Gotham
    ).TextSize = 11
end

local function CreatePage(name)
    local page = New("Frame", {
        Name = name,
        Size = UDim2.new(1, 0, 1, -55),
        Position = UDim2.fromOffset(0, 55),
        BackgroundTransparency = 1,
        Visible = false
    }, Content)

    local title = Label(
        page,
        string.upper(name),
        UDim2.new(1, -24, 0, 30),
        UDim2.fromOffset(14, 5),
        C.White,
        Enum.Font.GothamBlack
    )

    title.TextSize = 19

    local subtitle = Label(
        page,
        "Organização por categoria",
        UDim2.new(1, -24, 0, 22),
        UDim2.fromOffset(14, 34),
        C.Gray
    )

    subtitle.TextSize = 11

    New("Frame", {
        Size = UDim2.new(1, -28, 0, 1),
        Position = UDim2.fromOffset(14, 60),
        BackgroundColor3 = C.Border,
        BorderSizePixel = 0
    }, page)

    local groups = {}

    for _, category in ipairs({"Geral", "Aparência", "Informações"}) do
        local scroll = New("ScrollingFrame", {
            Name = category,
            Size = UDim2.new(1, 0, 1, -68),
            Position = UDim2.fromOffset(0, 68),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = C.Red,
            CanvasSize = UDim2.new(0, 0, 0, 210),
            Visible = false
        }, page)

        groups[category] = scroll

        for i, item in ipairs(Data[name][category]) do
            CreateCard(scroll, item[1], item[2], i)
        end
    end

    Pages[name] = {
        Frame = page,
        Groups = groups
    }
end

for _, data in ipairs(PageData) do
    CreatePage(data[2])
end

-- SELEÇÃO DE CATEGORIA

local function SelectCategory(category)
    CurrentCategory = category

    for name, button in pairs(CategoryButtons) do
        local active = name == category

        Animate(button, {
            BackgroundColor3 = active and C.RedDark or C.Card,
            TextColor3 = active and C.Red or C.Gray
        })
    end

    for _, page in pairs(Pages) do
        for name, group in pairs(page.Groups) do
            group.Visible = name == category
        end
    end
end

for i, category in ipairs({"Geral", "Aparência", "Informações"}) do
    local button = New("TextButton", {
        Size = UDim2.new(0, 135, 1, -8),
        Position = UDim2.fromOffset(5 + (i - 1) * 140, 4),
        BackgroundColor3 = i == 1 and C.RedDark or C.Card,
        Text = string.upper(category),
        TextColor3 = i == 1 and C.Red or C.Gray,
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    }, TopBar)

    Round(button, 5)
    CategoryButtons[category] = button

    button.MouseButton1Click:Connect(function()
        SelectCategory(category)
    end)
end

-- SELEÇÃO DE PÁGINA

local function SelectPage(name)
    CurrentPage = name

    for pageName, page in pairs(Pages) do
        page.Frame.Visible = pageName == name
    end

    for pageName, button in pairs(PageButtons) do
        local active = pageName == name

        Animate(button, {
            BackgroundColor3 = active and C.RedDark or C.Card,
            TextColor3 = active and C.White or C.Gray
        })

        local marker = button:FindFirstChild("Marker")
        if marker then
            marker.Visible = active
        end
    end

    SelectCategory(CurrentCategory)
end

-- BOTÕES LATERAIS

for i, data in ipairs(PageData) do
    local icon, name = data[1], data[2]

    local button = New("TextButton", {
        Size = UDim2.new(1, -14, 0, 31),
        Position = UDim2.fromOffset(7, 49 + (i - 1) * 35),
        BackgroundColor3 = C.Card,
        Text = icon .. "    " .. string.upper(name),
        TextColor3 = C.Gray,
        TextSize = 10,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    }, Sidebar)

    Round(button, 6)

    local marker = New("Frame", {
        Name = "Marker",
        Size = UDim2.fromOffset(3, 21),
        Position = UDim2.new(0, 0, 0.5, -10),
        BackgroundColor3 = C.Red,
        BorderSizePixel = 0,
        Visible = false
    }, button)

    Round(marker, 4)

    PageButtons[name] = button

    button.MouseButton1Click:Connect(function()
        SelectPage(name)
    end)
end

-- RODAPÉ

New("Frame", {
    Size = UDim2.new(1, -20, 0, 1),
    Position = UDim2.new(0, 10, 1, -42),
    BackgroundColor3 = C.Border,
    BorderSizePixel = 0
}, Sidebar)

Label(
    Sidebar,
    "CROSSHAIR X  •  V5.3",
    UDim2.new(1, -20, 0, 25),
    UDim2.new(0, 10, 1, -35),
    C.Gray,
    Enum.Font.GothamBold
).TextSize = 10

-- PAINEL DE PRÉVIA

Label(
    Preview,
    "PAINEL DE PRÉVIA",
    UDim2.new(1, -20, 0, 30),
    UDim2.fromOffset(12, 8),
    C.Gray,
    Enum.Font.GothamBold
).TextSize = 12

New("Frame", {
    Size = UDim2.new(1, -20, 0, 1),
    Position = UDim2.fromOffset(10, 43),
    BackgroundColor3 = C.Border,
    BorderSizePixel = 0
}, Preview)

local PreviewBox = New("Frame", {
    Size = UDim2.fromOffset(135, 135),
    Position = UDim2.new(0.5, -67, 0, 62),
    BackgroundColor3 = C.Card,
    BorderSizePixel = 0
}, Preview)

Round(PreviewBox, 70)
Stroke(PreviewBox, C.Red, 1.5)

local Dot = New("Frame", {
    Size = UDim2.fromOffset(10, 10),
    Position = UDim2.new(0.5, -5, 0.5, -5),
    BackgroundColor3 = C.Red,
    BorderSizePixel = 0
}, PreviewBox)

Round(Dot, 50)

local function PreviewRow(title, value, y)
    local row = New("Frame", {
        Size = UDim2.new(1, -20, 0, 43),
        Position = UDim2.fromOffset(10, y),
        BackgroundColor3 = C.Card,
        BorderSizePixel = 0
    }, Preview)

    Round(row, 6)

    Label(
        row,
        title,
        UDim2.new(1, -15, 0, 16),
        UDim2.fromOffset(9, 3),
        C.Gray,
        Enum.Font.GothamBold
    ).TextSize = 9

    Label(
        row,
        value,
        UDim2.new(1, -15, 0, 19),
        UDim2.fromOffset(9, 20),
        C.White,
        Enum.Font.GothamBold
    ).TextSize = 11
end

PreviewRow("TEMA", "PRETO / VERMELHO", 214)
PreviewRow("ESTILO", "PREMIUM", 264)
PreviewRow("VERSÃO", "5.3", 314)

-- PÁGINA INICIAL

SelectPage("Início")

-- MINIMIZAR / RESTAURAR / FECHAR

local function MinimizeMenu()
    if Minimized then return end

    Minimized = true

    Header.Visible = false
    MenuTitle.Visible = false
    Sidebar.Visible = false
    Content.Visible = false
    Preview.Visible = false

    MiniBar.Visible = true
    Main.Size = UDim2.fromOffset(900, 48)
end

local function RestoreMenu()
    if not Minimized then return end

    Minimized = false

    Main.Size = NormalSize

    MiniBar.Visible = false
    Header.Visible = true
    MenuTitle.Visible = true
    Sidebar.Visible = true
    Content.Visible = true
    Preview.Visible = true

    UpdateScale()
end

local function CloseMenu()
    Main.Visible = false
end

local function OpenMenu()
    Main.Visible = true
    RestoreMenu()
end

Minimize.MouseButton1Click:Connect(MinimizeMenu)
Restore.MouseButton1Click:Connect(RestoreMenu)

Close.MouseButton1Click:Connect(CloseMenu)
MiniClose.MouseButton1Click:Connect(CloseMenu)

Floating.MouseButton1Click:Connect(OpenMenu)

-- ARRASTAR PELA BARRA SUPERIOR

local dragging = false
local dragStart
local startPosition
local dragInput

local function StartDrag(input)
    if input.UserInputType == Enum.UserI
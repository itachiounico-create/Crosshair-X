-- CROSSHAIR X
-- INICIALIZADOR V5.3

local Config = require(script.Parent.Config)
local Pages = require(script.Parent.Pages)

local Main = {}

Main.Config = Config
Main.Pages = Pages

function Main.GetVersion()
    return Config.Version
end

function Main.GetPage(name)
    return Pages.Data[name]
end

return Main

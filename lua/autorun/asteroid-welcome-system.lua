AWS = AWS or {}

if SERVER then

    local tResources = {
        "resource/fonts/*.ttf"
    }

    for _, sPath in ipairs(tResources) do
		local tFiles = file.Find("addons/asteroid-welcome-system/"..sPath, "GAME")

		for _, sFile in ipairs(tFiles or {}) do
			resource.AddSingleFile(string.GetPathFromFilename(sPath)..sFile)
		end
	end
    
    AddCSLuaFile("core/cl_imageFetcher.lua")
    AddCSLuaFile("core/cl_core.lua")

end

if CLIENT then
    
    AWS.Client = AWS.Client or {}
    
    AWS.Client.ServerLogo = "https://i.imgur.com/p9mvYmp.png"

    AWS.Client.Links = {
        {name = "discord", link = "https://google.fr"},
        {name = "forum", link = "https://google.fr"}
    }

    AWS.Client.Colors = AWS.Client.Colors or {
        ["color0"] = Color(0,0,0, 0),
        ["color1"] = Color(44,44,44, 240),
        ["color2"] = Color(136,48,78, 240),
        ["text"] = Color(247,55,79),
        ["bg1"] = Color(82,37,70, 120),
        ["bg2"] = Color(82, 37, 70, 220)
    }

    AWS.Client.ImageFetcher = include("core/cl_imageFetcher.lua")

    include("core/cl_core.lua")
    
end
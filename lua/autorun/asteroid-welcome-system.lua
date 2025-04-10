AWS = AWS or {}

if SERVER then
    
    include("core/sv_core.lua")
    AddCSLuaFile("core/cl_core.lua")

end

if CLIENT then
    
    include("core/cl_core.lua")

end
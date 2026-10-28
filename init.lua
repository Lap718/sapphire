path = core.get_modpath("sapphire") .. "/"
colours = {"Pink", "Blue", "Green", "Black"}
tools = {"Sword", "Shovel", "Pick", "Axe", "Hoe"}
flowers = core.settings:get("sp_flowers")
toolGroups = {"fleshy", "crumbly", "cracky", "choppy", "oddly_breakable_by_hand"}
dofile(path .. "functions.lua")
dofile(path .. "quads.lua")
dofile(path .. "dyes.lua")
dofile(path .. "wool.lua")
dofile(path .. "obsidian.lua")
dofile(path .. "plants.lua")
dofile(path .. "qol.lua")
dofile(path .. "deco.lua")
dofile(path .. "version.lua")
dofile(path .. "wood.lua")
dofile(path .. "abm.lua")
dofile(path .. "hub.lua")
dofile(path .. "moves.lua")
dofile(path .. "chunks.lua")
path = nil
flowers = nil
tools = nil
toolGroups = nil
add = nil

-- TODO:
--v add more biomes
---> add more wood types
---> add grass variants
--- add workbench types
--- chatcommands for setting the versionstring per-world
--- add the low river
--- add more building blocks
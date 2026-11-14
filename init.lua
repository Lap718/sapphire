path = core.get_modpath("sapphire") .. "/"
colours = {
	"Pink", "Blue", "Green", "Black"
}
tools = {
	"Sword", "Shovel", "Pick", "Axe", "Hoe"
}
flowers = core.settings:get("sp_flowers")
toolGroups = {
	"fleshy", "crumbly", "cracky", "choppy", "oddly_breakable_by_hand"
}
S = core.get_translator("sapphire")
local scripts = {
	"functions",
	"quads",
	"greenstone",
	"dyes",
	"wool",
	"obsidian",
	"plants",
	"qol",
	"deco",
	"version",
	"abm",
	"hub",
	"moves",
	"chunks",
	"plates",
	"biomes",
	"flowers",
	"chat",
	"wood"
}
for _, name in ipairs(scripts) do
dofile(path..name..".lua")
end
path = nil
flowers = nil
tools = nil
toolGroups = nil
add = nil
S = nil

-- TODO:
--v add more biomes
---> add more wood types
---> add grass variants
--- add workbench types
--- add the low river
--- add more building blocks
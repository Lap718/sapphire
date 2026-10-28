-- actually register the plants
--- the ones that are always there
add.plant("minecraft:papyrus", "Sugarcane", terrain(73))
add.invimage("minecraft:papyrus", item(25) .."^[colorizehsl:117:40^[makealpha:0,0,0")
add.group("minecraft:papyrus", "attached_node", 1)
add.plant("minecraft:flame_ingot", "Celestial Flame", terrain(172), 1)
add.glow("minecraft:flame_ingot", 15)
add.plant("alphaver:waterlily", "Waterlily", terrain(171), 1)
add.glow("alphaver:waterlily", 15)
add.plant("alphaver:bush", "Tallgrass", terrain(111))
---- burning burger
add.item("minecraft:flame", "Burning Burger", terrain(172) .."^[transformR90")

---- sp_plant_grass logic
if core.settings:get_bool("sp_plant_grass") then
	core.override_item("alphaver:bush", {
		on_construct = function(pos)
			local below = core.get_node(vector.offset(pos, 0, -1, 0))["name"]
			if string.find(below, "farmland") then
				core.set_node(pos, {name = "minecraft:wheatblock_1", param2 = 3})
			end
		end
	})
end
---- infused waterlilies
local ingots = {"Flame", "Gold", "Obsidian"}
for num, name in ipairs(ingots)
do
	add.plant("alphaver:waterlily_"..name:lower(), name.." Infused Waterlily", terrain(172 + num), 1)
	add.glow("alphaver:waterlily_"..name:lower(), 15)
	core.register_craft({
    recipe = {{"alphaver:waterlily", "minecraft:" .. name:lower() .. "_ingot"}},
    output = "alphaver:waterlily_" .. name:lower()
	})
end
-- add the plants to mapgen via decorations
core.register_decoration({
    deco_type = "simple",
    place_on = "minecraft:water_source",
    decoration = "alphaver:waterlily",
    sidelen = 16,
    fill_ratio = .08,
    y_min = -14,
    y_max = 56,
    biomes = {"grasslands", "beach", "sea"}
})
core.register_decoration({
    deco_type = "simple",
    place_on = "minecraft:water_source",
    decoration = "alphaver:waterlily",
    sidelen = 16,
    flags = {"liquid_surface"},
    fill_ratio = .08,
    y_min = -14,
    y_max = 56,
    biomes = {"grasslands", "beach", "sea"}
})
core.register_decoration({
    deco_type = "simple",
    place_on = "minecraft:sand",
    decoration = "alphaver:waterlily",
    sidelen = 16,
    fill_ratio = .08,
    y_min = -14,
    y_max = 56,
    biomes = {"grasslands", "beach", "sea"}
})
core.register_decoration({
    deco_type = "simple",
    place_on = "minecraft:grass",
    decoration = "alphaver:bush",
    sidelen = 16,
    fill_ratio = .08,
    y_min = -14,
    y_max = 56,
    biomes = {"grasslands", "beach", "sea"}
})
core.register_decoration({
    deco_type = "simple",
    place_on = "minecraft:sand",
    decoration = "minecraft:papyrus",
    sidelen = 16,
    height_max = 3,
    fill_ratio = .02,
    y_min = -14,
    y_max = 56,
    biomes = {"grasslands", "beach", "sea"}
})
core.register_decoration({
    deco_type = "simple",
    place_on = "air",
    decoration = "minecraft:flame_ingot",
    sidelen = 16,
    fill_ratio = .08,
    y_min = -14,
    y_max = 3100,
    biomes = {"grasslands", "beach", "sea"}
})
core.register_decoration({
    deco_type = "simple",
    place_on = "minecraft:leaves",
    decoration = "minecraft:flame_ingot",
    sidelen = 16,
    fill_ratio = .08,
    y_min = -14,
    y_max = 3100,
    biomes = {"grasslands", "beach", "sea"}
})
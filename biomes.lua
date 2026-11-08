-- cities
core.register_biome({
	name = "city",
	node_top = "minecraft:path",
	depth_top = 1,
	node_filler = "minecraft:dirt",
	depth_filler = 3,
	node_riverbed = "minecraft:gravel",
	depth_riverbed = 1,
	y_min = -14,
	y_max = 56,
	heat_point = 55.0,
	humidity_point = 10
})
--- decorations
core.register_decoration({
	deco_type = "schematic",
	place_on = "minecraft:path",
	schematic = "schematics/tower.mts",
	sidelen = 16,
	fill_ratio = 0.005,
	y_min = -14,
	y_max = 56,
	biomes = {
		"city"
	}
})
-- frigid fields
--- nodes/blocks
add.snow("minecraft:snow", "Snowy Grass", {
	terrain(66), terrain(2), terrain(68)})
add.snow("minecraft:snowy_grass", "Snowy Grass (with Snow Layer)", {
	terrain(66), terrain(2), terrain(68)})
add.drop("minecraft:snow", "minecraft:dirt")
add.snow("minecraft:snow_layer", "Snow Layer", {
	terrain(66)})
add.nodebox("minecraft:snow_layer", {
	type = "fixed",
	fixed = {
		{
			-0.5000, -0.5000, -0.5000, 0.5000, -0.3125, 0.5000
		}
	}
})
add.drop("minecraft:snow_layer", "mobs_mc:snowball")
add.group("minecraft:snow_layer", "falling_node", 1)
add.override("minecraft:snow_layer", "buildable_to", true)
add.snow("minecraft:snow_block", "Snow", {
	terrain(66)})
add.drop("minecraft:snow_block", "mobs_mc:snowball 4")
add.glass("minecraft:ice", "Ice", {
	terrain(67)})
add.glass("minecraft:ice_layer", "Ice Layer", {
	terrain(67)})
add.nodebox("minecraft:ice_layer", core.registered_nodes["minecraft:snow_layer"].node_box)
add.drop("minecraft:ice_layer", "minecraft:ice")
add.glass("minecraft:ice_leaves", "Frigid Leaves", {terrain(224)})
add.plant("minecraft:ice_stem", "Frigid Trunk", terrain(131))
--- decorations
core.register_biome({
	name = "frigidfields",
	node_top = "minecraft:snowy_grass",
	depth_top = 1,
	node_filler = "minecraft:dirt",
	depth_filler = 3,
	node_riverbed = "minecraft:snow",
	depth_riverbed = 3,
	y_max = 2000,
	y_min = 0,
	heat_point = 43,
	humidity_point = 15
})
core.register_decoration({
	deco_type = "simple",
	place_on = "minecraft:snowy_grass",
	decoration = "minecraft:ice_stem",
	sidelen = 16,
	fill_ratio = 0.08,
	y_min = 0,
	y_max = 85,
	height_max = 3,
	height_min = 2,
	biomes = {"frigidfields"}
})
core.register_decoration({
	deco_type = "simple",
	place_on = "minecraft:water_source",
	decoration = "minecraft:ice_layer",
	sidelen = 16,
	fill_ratio = 1,
	y_min = 0,
	y_max = 85,
	height_max = 3,
	height_min = 2,
	biomes = {"frigidfields"}
})
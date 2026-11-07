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
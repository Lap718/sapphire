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
core.register_decoration({
	deco_type = "schematic",
	place_on = "minecraft:path",
	schematic = "schematics/tower.mts",
	sidelen = 16,
	fill_ratio = 0.005,
	y_min = -14,
	y_max = 56,
	biomes = {"city"}
})
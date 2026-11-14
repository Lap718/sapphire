add.stone("minecraft:dbg1", "DEBUG", {terrain(150)})
add.stone("minecraft:dw", "Dimension Wall", {terrain(149)})
add.grass("minecraft:path", "Grass Path", {terrain(228), terrain(2), terrain(229)})
add.gravel("minecraft:df", "Dimension Floor", {terrain(148)})
add.stone("minecraft:slatebricks", "Slate Bricks", {terrain2(6)})
add.stone("minecraft:slatebeacon", "Slate Beacon", {terrain2(7)})
add.stone("minecraft:stoneblock", "Smooth Stone Block", {terrain(195)})
add.stone("minecraft:slatepillar", "Slate Pillar", {terrain2(9), terrain2(9), terrain2(8)})
add.grass("minecraft:df_blue", "Blue Dimension Tile", {terrain(151)})
add.wood("minecraft:bookshelf_empty", "Shelf", {terrain(4), terrain(4), terrain(109)})
add.snow("minecraft:df_yellow", "Yellow Dimension Tile", {terrain(152)})
add.plant("minecraft:dbg2", "DEBUG (2D)", terrain(150))
add.glow("minecraft:dbg2", 15)
add.item("minecraft:paper", "Paper", "bloood_nature.png^[colorizehsl:0:0^[makealpha:0,0,0^[brighten")
add.item("minecraft:book", "Book", alphacutout("mobs_fallback.png^strip.png", item(23)))
add.wood("minecraft:pillar", "Pillar (Wooden)", {terrain(144)})
add.stone("alphaver:recruit", "Recruiter", {terrain(17) .. "^[multiply:black"})
add.nodebox("alphaver:recruit", { 	type = "fixed", 	fixed = { 		{-0.06250, -0.4375, -0.06250, 0.06250, 1.438, 0.06250} 	} })
add.mesh("alphaver:recruit", "alphaver_recruit.obj")
add.override("alphaver:recruit", "collision_box", { 	type = "fixed", 	fixed = { 		{-0.5000, -0.5000, -0.5000, 0.5000, 1.500, 0.5000} 	} })
add.override("alphaver:recruit", "on_punch", function(pos)
	core.set_node(pos, {name = "air"})
end) 
local unbreaking = {
	"minecraft:dw",
	"minecraft:df",
	"minecraft:df_blue",
	"minecraft:df_yellow",
	"alphaver:recruit"
}
for num, name in ipairs(unbreaking)
do
	add.unbreaking(name)
end
local recipes = {
	stoneblock = {
		{"minecraft:stone", "minecraft:stone"},
		{"minecraft:stone", "minecraft:stone"}
	},
	df = {
		{"minecraft:df_yellow", "minecraft:df_blue"},
		{"minecraft:df_blue", "minecraft:df_yellow"},
	},
	pillar = {
		{"minecraft:plank", "minecraft:stick", "minecraft:plank"},
		{"minecraft:stick", "", "minecraft:stick"},
		{"minecraft:plank", "minecraft:stick", "minecraft:plank"}
	},
	["df 1"] = {
		{"minecraft:df_blue", "minecraft:df_yellow"},
		{"minecraft:df_yellow", "minecraft:df_blue"},
	},
	bookshelf_empty = {
		{"minecraft:plank", "minecraft:stick", "minecraft:plank"},
		{"", "minecraft:stick", ""},
		{"minecraft:plank", "minecraft:stick", "minecraft:plank"}
	},
	bookshelf = {
		{"minecraft:book", "minecraft:book", "minecraft:book"},
		{"", "minecraft:bookshelf_empty", ""},
		{"minecraft:book", "minecraft:book", "minecraft:book"}
	},
	["paper 3"] = {
		{"minecraft:papyrus", "minecraft:papyrus", "minecraft:papyrus"}
	},
	book = {
		{"minecraft:paper", "minecraft:paper"},
		{"minecraft:paper", "mobs:leather"}
	},
	
}
if core.settings:get_bool("sp_craft_paths", false) == true then
	recipes["path"] = {
		{"minecraft:wool"},
		{"alphaver:bush"},
		{"minecraft:dirt"}
	}
end
for output, recipe in pairs(recipes)
do
	core.register_craft({
		output = "minecraft:"..output,
		recipe = recipe
	})
end
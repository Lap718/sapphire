add.stone("minecraft:dbg1", "DEBUG", {terrain(150)})
add.stone("minecraft:dw", "Dimension Wall", {terrain(149)})
add.grass("minecraft:path", "Grass Path", {terrain(228), terrain(2), terrain(229)})
add.gravel("minecraft:df", "Dimension Floor", {terrain(148)})
add.grass("minecraft:df_blue", "Blue Dimension Tile", {terrain(151)})
add.wood("minecraft:bookshelf_empty", "Shelf", {terrain(4), terrain(4), terrain(109)})
add.snow("minecraft:df_yellow", "Yellow Dimension Tile", {terrain(152)})
add.plant("minecraft:dbg2", "DEBUG (2D)", terrain(150))
add.glow("minecraft:dbg2", 15)
core.register_craftitem(":minecraft:paper", {
    description = "Paper",
    inventory_image = "bloood_nature.png^[colorizehsl:0:0^[makealpha:0,0,0^[brighten"
})
core.register_craftitem(":minecraft:book", {
    description = "Book",
    inventory_image = alphacutout("mobs_fallback.png^strip.png", item(23))
})
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
core.register_craft({
    output = "minecraft:df",
    recipe = {
        {"minecraft:df_yellow", "minecraft:df_blue"},
        {"minecraft:df_blue", "minecraft:df_yellow"}
    }
})
if core.settings:get_bool("sp_craft_paths", false) == true then
	core.register_craft({
  	  output = "minecraft:path 4",
    	recipe = {
     	   {"minecraft:wool"},
     	   {"alphaver:bush"},
     	   {"minecraft:dirt"}
    	}
	})
end
core.register_craft({
    output = "minecraft:bookshelf_empty",
    recipe = {
        {"minecraft:plank", "minecraft:stick", "minecraft:plank"},
        {"", "minecraft:stick", ""},
        {"minecraft:plank", "minecraft:stick", "minecraft:plank"}
    }
})
core.register_craft({
    output = "minecraft:bookshelf",
    recipe = {
        {"minecraft:book", "minecraft:book", "minecraft:book"},
        {"", "minecraft:bookshelf_empty", ""},
        {"minecraft:book", "minecraft:book", "minecraft:book"}
    }
})
core.register_craft({
    output = "minecraft:paper 3",
    recipe = {
        {"minecraft:papyrus", "minecraft:papyrus", "minecraft:papyrus"}
    }
})
core.register_craft({
    output = "minecraft:book",
    recipe = {
        {"minecraft:paper", "minecraft:paper"},
        {"minecraft:paper", "mobs:leather"}
    }
})
core.register_craft({
    output = "minecraft:df",
    recipe = {
        {"minecraft:df_yellow", "minecraft:df_blue"},
        {"minecraft:df_blue", "minecraft:df_yellow"}
    }
})
core.register_craft({
    output = "minecraft:df",
    recipe = {
        {"minecraft:df_blue", "minecraft:df_yellow"},
        {"minecraft:df_yellow", "minecraft:df_blue"}
    }
})


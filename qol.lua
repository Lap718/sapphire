-- slab changes
--- planks slab change
add.override("minecraft:plank_slab", "tiles", {terrain(138), terrain(138), terrain(137)})
add.wood("minecraft:plank_slab_block", "tile.woodSlab", {terrain(138), terrain(138), terrain(137)})
add.drop("minecraft:plank_slab_block", "minecraft:plank_slab")
local slabs = {
	cobble = "cobble",
	stone = "stone_slab_block",
	plank = "plank_slab_block"
}
for name, full in pairs(slabs)
do
	add.override("minecraft:"..name.."_slab", "on_construct", function(pos)
		connect_slab(pos, "minecraft:"..name.."_slab", "minecraft:"..full)
	end)
end
-- recipe for leather
core.register_craft({
	output = "mobs:leather 2",
	recipe = {"minecraft:paper", "mobs_mc:rotten_flesh"},
	type = "shapeless"
})
core.override_item("minecraft:water_source", {
    inventory_image = terrain(207),
    wield_image = terrain(207)
})
core.override_item("minecraft:lava_source", {
    inventory_image = terrain(255),
    wield_image = terrain(255)
})
local mushroomColours = {
    mushroom = "Red",
    mushroom2 = "Pink"
}
for mushroom, colour in pairs(mushroomColours)
do
    core.override_item("minecraft:"..mushroom, {
        description = colour.." Mushroom"
    })
end
local flowerColours = {
    rose = "Flower", 
    flower = "Rose"
}
add.exchange("mobs:leather", "minecraft:string 5")
add.plant("minecraft:sign", "Sign", "mcla_signs_icon.png")
add.override("minecraft:sign", "on_construct", function(pos)
	core.set_node(pos, {name = "mcla_signs:wall_sign"})
end)
for old, new in pairs(flowerColours)
do
    core.override_item("minecraft:"..old,{description = new})
end
for num, name in ipairs({"", "_wall"})
do
    core.override_item("minecraft:torch"..name,{use_texture_alpha=true})
end
core.override_item("minecraft:bookshelf", {tiles = {
    terrain(4), terrain(4), terrain(108)
}})
core.override_item("minecraft:leaves", {tiles = {
    "(".. terrain(52) ..")^((".. terrain(53) ..")^[opacity:1)"
}})

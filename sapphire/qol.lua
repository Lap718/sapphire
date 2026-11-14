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
add.leaves("minecraft:leaves", "Oak Leaves", terrain(52), terrain(53))
add.override("minecraft:ladder", "climbable", true)
add.override("minecraft:ladder", "sounds", block_sound("ladder"))
if not core.settings:get_bool("sp_items", false) then
	dtimes = {}
	add.playerstep(function(dtime, player)
		dtimes[#dtimes +1] = dtime
		for num, obj in ipairs(core.get_objects_inside_radius(player:get_pos(), 37)) do
			local item = obj:get_luaentity()
			if item and item.itemstring and core.registered_items[item.itemstring] and core.registered_items[item.itemstring].inventory_image and item.name == "__builtin:item" and core.registered_items[item.itemstring].inventory_image:find(".") and not core.get_node({x=math.floor(obj:get_pos().x),y=math.floor(obj:get_pos().y+.5),z=math.floor(obj:get_pos().z)})["name"]:find("water") then
				the_dtime = 0
				for num, the_time in pairs(dtimes)
				do
					the_dtime = the_dtime + the_time + 0.1
				end
				the_dtime = the_dtime / #dtimes
				image = core.registered_items[item.itemstring].inventory_image
				shadow = "shadow.png"
				if player:get_look_vertical() > 1 or player:get_look_vertical() < -1 then
					shadow = "object_marker_red.png^[colorize:black:255"
				end
				shadowtex = shadow.."^[opacity:80^"
				shadow = core.get_spawn_level(math.floor(obj:get_pos().x), math.floor(obj:get_pos().z)) or math.floor(obj:get_pos().y+.5) - 1
				expirationtime = the_dtime +.1
				repeat
					shadow = shadow - 1
				until shadow < obj:get_pos().y and core.get_node({x=math.floor(obj:get_pos().x), y=shadow,z=math.floor(obj:get_pos().z)})["name"] ~= "air"
				if obj:get_velocity() ~= {x=0, y=0, z=0} then
					expirationtime = 0.01
					velocity = {x=0,y=0,z=0}
				end
				core.add_particle({
					pos = {x=obj:get_pos().x, y=shadow+0.7, z=obj:get_pos().z},
					velocity = {x=velocity.x, y=0, z=velocity.z},
					expirationtime = expirationtime,
					size = 5,
					texture = shadowtex
				})
				core.add_particle({
					pos = vector.offset(obj:get_pos(), 0, 0.25 - (((os.time()or (#dtimes / 10000)) % 2) / 6), 0),
					vertical = true,
					velocity = velocity,
					expirationtime = expirationtime,
					size = 5,
					texture = image
				})
				obj:set_properties({
					visual = "mesh",
					mesh = "alphaver_ice_branches_big"
				})
				image = nil
				shadow = nil
				expirationtime = nil
			end
		end
	end)
end
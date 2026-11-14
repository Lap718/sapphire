-- recruiter stuff
core.register_abm({
	label = "recruiter vanishing",
	nodenames = "alphaver:recruit",
	interval = 5.0,
	chance = 2,
	action = function(pos)
	core.set_node(pos, {
		name = "air"
	})
	end
})
core.register_abm({
	label = "recruiter dying",
	nodenames = "alphaver:recruit",
	neighbors = {
		"minecraft:tnt", "minecraft:torch", "minecraft:torch_wall"
	},
	interval = 1.0,
	chance = 1,
	action = function(pos)
	core.set_node(pos, {
		name = "air"
	})
	end
})
core.register_abm({
	label = "recruiter spawning",
	nodenames = {
		"group:crumbly", "group:cracky"
	},
	interval = 30.0,
	chance = 2111,
	action = function(pos)
	if core.get_node(vector.offset(pos, 0, 1, 0))["name"] == "air" then
	core.set_node(vector.offset(pos, 0, 1, 0), {
		name = "alphaver:recruit"
	})
	end
	end
})
-- snow and grass
--- for frigidfields mapgen
core.register_abm({
	label = "snow goes on sand",
	nodenames = "minecraft:sand",
	neighbors = {
		"minecraft:snowy_grass", "minecraft:snow_layer", "minecraft:snow", "minecraft:snow_block"
	},
	interval = 0.1,
	chance = 1,
	action = function(pos)
	core.set_node(pos, {
		name = "minecraft:snow_block"
	})
	end
})
core.register_abm({
	label = "ice goes on water",
	nodenames = "minecraft:water_source",
	neighbors = {
		"minecraft:snowy_grass", "minecraft:snow_layer", "minecraft:snow", "minecraft:snow_block"
	},
	interval = 0.1,
	chance = 1,
	action = function(pos)
	if core.get_node(vector.offset(pos, 0, 1, 0))["name"] == "air" then
	core.set_node(vector.offset(pos, 0, 1, 0), {
		name = "minecraft:ice_layer"
	})
	end
	end
})
core.register_abm({
	label = "snow goes on mapgen snow",
	nodenames = "minecraft:snowy_grass",
	interval = 0.1,
	chance = 1,
	action = function(pos)
	core.set_node(pos, {
		name = "minecraft:snow"
	})
	if core.get_node(vector.offset(pos, 0, 1, 0))["name"] == "air" then
	core.set_node(vector.offset(pos, 0, 1, 0), {
		name = "minecraft:snow_layer"
	})
	end
	end
})
core.register_abm({
	label = "frigid trunk goes down",
	nodenames = "minecraft:ice_stem",
	interval = 0.1,
	chance = 1,
	action = function(pos)
	if core.get_node(vector.offset(pos, 0, -1, 0))["name"] == "minecraft:snow_layer" then
	core.set_node(vector.offset(pos, 0, -1, 0), {
		name = "minecraft:ice_stem"
	})
	end
	end
})
core.register_abm({
	label = "sugar canes freeze",
	nodenames = "minecraft:papyrus",
	neighbors = {
		"minecraft:snow_block", "minecraft:ice_stem"
	},
	interval = 0.1,
	chance = 1,
	action = function(pos)
	core.set_node(pos, {
		name = "minecraft:ice_stem"
	})
	end
})
core.register_abm({
	label = "frigid branches grow",
	nodenames = "minecraft:ice_stem",
	interval = 0.1,
	chance = 1,
	action = function(pos)
	if core.get_node(vector.offset(pos, 0, 1, 0))["name"] == "air" and core.get_node(pos)["param2"] == 0 then
	core.set_node(vector.offset(pos, 0, 1, 0), {
		name = "flowers:ice_stem_v",
		param2 = 1
	})
	core.swap_node(pos, {
		name = "minecraft:ice_stem",
		param2 = 1
	})
	end
	end
})
core.register_abm({
	label = "frigid leaves grow",
	nodenames = "flowers:ice_stem_v",
	interval = 0.1,
	chance = 1,
	action = function(pos)
	if core.get_node(vector.offset(pos, 0, 1, 0))["name"] == "air" then
	core.set_node(vector.offset(pos, 0, 1, 0), {
		name = "minecraft:ice_leaves"
	})
	end
	end
})
--- frozen lilies
core.register_abm({
	label = "lily freezing",
	nodenames = "alphaver:waterlily",
	neighbors = "minecraft:ice_layer",
	interval = 0.1,
	chance = 1,
	action = function(pos)
	core.set_node(pos, {
		name = "flowers:frozenlily"
	})
	end
})
core.register_abm({
	label = "lily connecting",
	nodenames = "flowers:frozenlily",
	neighbors = "minecraft:flame_ingot",
	interval = 0.1,
	chance = 1,
	action = function(pos)
	if core.get_node(vector.offset(pos, 0, 1, 0))["name"] == "minecraft:flame_ingot" then
	core.set_node(pos, {
		name = "flowers:frozenlily_connect"
	})
	end
	end
})
core.register_abm({
	label = "lily disconnecting",
	nodenames = "flowers:frozenlily_connect",
	neighbors = "air",
	interval = 0.1,
	chance = 1,
	action = function(pos)
	if not(core.get_node(vector.offset(pos, 0, 1, 0))["name"] == "minecraft:flame_ingot") then
	core.set_node(pos, {
		name = "flowers:frozenlily_disc"
	})
	end
	end
})
core.register_abm({
	label = "lily reconnecting",
	nodenames = "flowers:frozenlily_disc",
	neighbors = "minecraft:flame_ingot",
	interval = 0.1,
	chance = 1,
	action = function(pos)
	if core.get_node(vector.offset(pos, 0, 1, 0))["name"] == "minecraft:flame_ingot" then
	core.set_node(pos, {
		name = "flowers:frozenlily"
	})
	end
	end
})
--- for gameplay
core.register_abm({
	label = "particles for frigid leaves",
	nodenames = "minecraft:ice_leaves",
	interval = 1,
	chance = 2,
	action = function(pos)
	core.add_particle({
		pos = vector.offset(pos, math.random(-1,1), math.random(-1,1), math.random(-1,1)),
		velocity = {
			x = 0, y = -0.5 * math.random(1, 1.5), z = 0
		},
		expirationtime = 8 * math.random(0.3, 1),
		size = 3.0 * math.random(0.8, 1),
		texture = "mobs_sand_particles.png^[hsl:0:-100:75"
	})
	end
})
core.register_abm({
	label = "snow goes on grass",
	nodenames = "minecraft:grass",
	neighbors = {
		"minecraft:snow_layer", "minecraft:snow_block"
	},
	interval = 0.1,
	chance = 1,
	action = function(pos)
	core.set_node(pos, {
		name = "minecraft:snow"
	})
	end
})
core.register_abm({
	label = "snow goes off grass",
	nodenames = "minecraft:snow",
	without_neighbors = {
		"minecraft:snow_layer", "minecraft:snow_block"
	},
	interval = 0.2,
	chance = 1,
	action = function(pos)
	core.set_node(pos, {
		name = "minecraft:grass"
	})
	end
})
-- hub stuff
core.register_abm({
	label = "hub spawns when bedrock is broken",
	nodenames = "air",
	neighbors = "minecraft:bedrock",
	without_neighbors = "minecraft:dw",
	interval = 1.0,
	chance = 1,
	action = function(pos)
	low = vector.offset(pos, 0, -4, 0)
	if core.get_node(low)["name"] == "air" and core.get_node(vector.offset(pos, 1, 0, 1))["name"] == "minecraft:bedrock" then
	math.randomseed(pos.x + pos.z % 99)
	core.place_schematic(vector.offset(low, -3, 0, -3), core.get_modpath("sapphire").."/schematics/hub_room_"..math.random(1, 8) ..".mts")
	end
	end
})
-- plants
core.register_abm({
	label = "papyrus growing",
	nodenames = "minecraft:papyrus",
	interval = 6.25,
	chance = 7,
	action = function(pos)
	if core.get_node(vector.offset(pos, 0, 1, 0))["name"] == "air" then
	core.set_node(vector.offset(pos, 0, 1, 0), {
		name = "minecraft:papyrus"
	})
	end
	end
})
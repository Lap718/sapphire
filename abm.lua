-- recruiter stuff
core.register_abm({
	label = "recruiter vanishing",
	nodenames = "alphaver:recruit",
	interval = 5.0,
	chance = 2,
	action = function(pos)
		core.set_node(pos, {name = "air"})
	end
})
core.register_abm({
	label = "recruiter dying",
	nodenames = "alphaver:recruit",
	neighbors = {"minecraft:tnt", "minecraft:torch", "minecraft:torch_wall"},
	interval = 1.0,
	chance = 1,
	action = function(pos)
		core.set_node(pos, {name = "air"})
	end
})
core.register_abm({
	label = "recruiter spawning",
	nodenames = {"group:crumbly", "group:cracky"},
	interval = 30.0,
	chance = 2111,
	action = function(pos)
		if core.get_node(vector.offset(pos, 0, 1, 0))["name"] == "air" then
			core.set_node(vector.offset(pos, 0, 1, 0), {name = "alphaver:recruit"})
		end
	end
})
-- snow and grass
--- for frigidfields mapgen
core.register_abm({
	label = "snow goes on sand",
	nodenames = "minecraft:sand",
	neighbors = {"minecraft:snowy_grass", "minecraft:snow_layer", "minecraft:snow", "minecraft:snow_block"},
	interval = 0.1,
	chance = 1,
	action = function(pos)
		core.set_node(pos, {name = "minecraft:snow_block"})
	end
})
core.register_abm({
	label = "ice goes on water",
	nodenames = "minecraft:water_source",
	neighbors = {"minecraft:snowy_grass", "minecraft:snow_layer", "minecraft:snow", "minecraft:snow_block"},
	interval = 0.1,
	chance = 1,
	action = function(pos)
		if core.get_node(vector.offset(pos, 0, 1, 0))["name"] == "air" then
		core.set_node(vector.offset(pos, 0, 1, 0), {name = "minecraft:ice_layer"})
		end
	end
})
core.register_abm({
	label = "snow goes on mapgen snow",
	nodenames = "minecraft:snowy_grass",
	interval = 0.1,
	chance = 1,
	action = function(pos)
		core.set_node(pos, {name = "minecraft:snow"})
		if core.get_node(vector.offset(pos, 0, 1, 0))["name"] == "air" then
		core.set_node(vector.offset(pos, 0, 1, 0), {name = "minecraft:snow_layer"})
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
		core.set_node(vector.offset(pos, 0, -1, 0), {name = "minecraft:ice_stem"})
		end
	end
})
core.register_abm({
	label = "frigid leaves grow",
	nodenames = "minecraft:ice_stem",
	interval = 0.1,
	chance = 1,
	action = function(pos)
		if core.get_node(vector.offset(pos, 0, 1, 0))["name"] == "air" then
		core.set_node(pos, {name = "minecraft:ice_leaves"})
		end
	end
})
--- for gameplay
core.register_abm({
	label = "snow goes on grass",
	nodenames = "minecraft:grass",
	neighbors = {"minecraft:snow_layer", "minecraft:snow_block"},
	interval = 0.1,
	chance = 1,
	action = function(pos)
		core.set_node(pos, {name = "minecraft:snow"})
	end
})
core.register_abm({
	label = "snow goes off grass",
	nodenames = "minecraft:snow",
	without_neighbors = {"minecraft:snow_layer", "minecraft:snow_block"},
	interval = 0.2,
	chance = 1,
	action = function(pos)
		core.set_node(pos, {name = "minecraft:grass"})
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
			core.set_node(vector.offset(pos, 0, 1, 0), {name = "minecraft:papyrus"})
		end
	end
})
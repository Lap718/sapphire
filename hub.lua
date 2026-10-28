-- make bedrock bottom look like dimension wall
add.override("minecraft:bedrock", "tiles", {
	terrain(17), terrain(149), terrain(17)
})
-- make doors
--- hallway doors
local ns = { "n", "s" }
local ew = { "e", "w" }
local news = {ew, ns}
local halves = {"Top", "Bottom"}
hubdoors = {}
for num, name in ipairs(news)
do
	for nnum, nletter in ipairs(name)
	do
		for hnum, hname in ipairs(halves)
		do
			local nodename = "hub:hallway_"..nletter.."_"..hname:lower()
			add.glass(nodename, "Hub Door (Hallway "..hname..")", {terrain( (16 * (4 + hnum)) + 2 )})
			add.unbreaking(nodename)
		end
	end
end
---- hallways
local overrides = {
	{"hub:hallway_n_top", "on_rightclick", function(pos)
		core.place_schematic({x = pos.x - 2, y = -66, z = pos.z + 1}, core.get_modpath("sapphire").."/schematics/hub_hallway_n.mts", "west")
		if math.random(1, 4) == 2 then
			core.place_schematic({x = pos.x - 3, y = -66, z = pos.z}, core.get_modpath("sapphire").."/schematics/hub_room_"..math.random(1, 2)..".mts", "west")
		end
		core.set_node(pos, {name = "air"})
		core.set_node(vector.offset(pos, 0, -1, 0), {name = "hub:deco_b", param2 = 1})
	end},
	{"hub:hallway_s_top", "on_rightclick", function(pos)
		core.place_schematic({x = pos.x - 2, y = -66, z = pos.z - 7}, core.get_modpath("sapphire").."/schematics/hub_hallway_s.mts", "west")
		if math.random(1, 4) == 2 then
			core.place_schematic({x = pos.x - 3, y = -66, z = pos.z - 6}, core.get_modpath("sapphire").."/schematics/hub_room_"..math.random(3, 4)..".mts", "west")
		end
		core.set_node(pos, {name = "air"})
		core.set_node(vector.offset(pos, 0, -1, 0), {name = "hub:deco_b", param2 = 1})
	end},
 {"hub:hallway_e_top", "on_rightclick", function(pos)
		core.place_schematic({x = pos.x + 1, y = -66, z = pos.z - 2}, core.get_modpath("sapphire").."/schematics/hub_hallway_e.mts", "west")
		if math.random(1, 4) == 2 then
			core.place_schematic({x = pos.x, y = -66, z = pos.z - 3}, core.get_modpath("sapphire").."/schematics/hub_room_"..math.random(5, 6)..".mts", "west")
		end
		core.set_node(pos, {name = "air"})
		core.set_node(vector.offset(pos, 0, -1, 0), {name = "hub:deco_c"})
	end},
	{"hub:hallway_w_top", "on_rightclick", function(pos)
		core.place_schematic({x = pos.x - 7, y = -66, z = pos.z - 2}, core.get_modpath("sapphire").."/schematics/hub_hallway_w.mts", "west")
		if math.random(1, 4) == 2 then
			core.place_schematic({x = pos.x - 6, y = -66, z = pos.z - 3}, core.get_modpath("sapphire").."/schematics/hub_room_"..math.random(7, 8)..".mts", "west")
		end
		core.set_node(pos, {name = "air"})
		core.set_node(vector.offset(pos, 0, -1, 0), {name = "hub:deco_c"})
	end}
}
for num, ttable in ipairs(overrides)
do
	add.override(ttable[1], ttable[2], function(pos)
		local how = core.get_spawn_level(pos.x, pos.z) or 36
		math.randomseed(pos.x + pos.z % how)
		ttable[3](pos)
	end)
end
--- entrance door
add.door("hub:entrance", "Hub Door", door("iron_door.png"), item(43).."^[colorizehsl:0:0^[makealpha:0,0,0^[brighten", "minecraft:iron_ingot", "cracky")
add.group("hub:entrance_a", "falling_node", 1)
---- entrance rooms
add.override("hub:entrance_a", "on_rightclick", function(pos, node, clicker)
	hubdoors[pos.x..pos.z] = pos.y
	local privs = core.get_player_privs(clicker:get_player_name())
	privs.shout = false
	core.set_player_privs(clicker:get_player_name(), privs)
	local how = core.get_spawn_level(pos.x, pos.z) or 36
	math.randomseed(pos.x + pos.z % how)
	core.place_schematic({x = pos.x - 3, y = -66, z = pos.z - 3}, core.get_modpath("sapphire").."/schematics/hub_room_"..math.random(1, 8) ..".mts")
	clicker:set_pos({x = pos.x, y = -64, z = pos.z})
	core.after(1, function()
		if clicker:get_pos()["y"] < -67 then
			core.place_schematic({x = pos.x - 3, y = -66, z = pos.z - 3}, core.get_modpath("sapphire").."/schematics/hub_room_"..math.random(1, 8) ..".mts")
			clicker:set_pos({x = pos.x, y = -64, z = pos.z})
		end
	end)
end)
--- decoration door (for mapmakers)
add.door("hub:deco", "Hub Door (Decoration)", door("iron_door.png"), item(43).."^[colorizehsl:0:0^[makealpha:0,0,0^[brighten", "unknown", "unbreaking")
--- exit door
add.metal("hub:exit", "Hub Door (Exit)", {"iron_door.png"})
add.nodebox("hub:exit", { 	type = "fixed", 	fixed = { 		{-0.5000, -0.5000, -0.5000, 0.5000, 1.500, 0.5000} 	} })
add.mesh("hub:exit", "alphaver_diagonal_door.obj")
add.fallthrough("hub:exit")
add.override("hub:exit", "on_rightclick", function(pos, node, clicker)
	local privs = core.get_player_privs(clicker:get_player_name())
	privs.shout = true
	core.set_player_privs(clicker:get_player_name(), privs)
	local pheight = hubdoors[pos.x..pos.z] or core.get_spawn_level(pos.x, pos.z)
	if pheight == nil then
			core.set_node(pos, {name = "air"})
		else
			core.set_node({x = pos.x, y = pheight, z = pos.z}, {name = "hub:entrance_a"})
			core.check_for_falling({x = pos.x, y = pheight, z = pos.z})
			clicker:set_pos({x = pos.x, y =  pheight, z = pos.z})
	end
end)
-- green skybox in the hub
core.register_globalstep(function(dtime)
	for num, player in ipairs(core.get_connected_players())
	do
		if player:get_pos()["y"] < -62 then
			player:set_sky("chartreuse", "plain", {}, true)
			player:hud_set_flags({
				healthbar = false,
				chat = false
			})
		else
			player:set_sky({
				type = "regular"
			})
			player:hud_set_flags({
				healthbar = true,
				chat = false
			})
		end
	end
end)
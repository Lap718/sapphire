-- init for the tables
zoomdb = {}
dashbarids = {}
--- stuff for aratox so dashing is legal
backup_checks = aratox_checks
fakeup_checks = {}
---- build fakeup_checks
local fake_checks = {"fly_1", "fly_2", "speed_1"}
for num, name in ipairs(fake_checks)
do
  fakeup_checks[name] = function()
  end
end
-- basic setup for the moveset
core.register_on_joinplayer(function(player)
	zoomdb[player:get_player_name()] = 2
	core.after(0.1, function()
		player:set_physics_override({
			sneak = true
		})
	end)
	if core.settings:get_bool("sp_dashotbar", false) == false then
		dashbarids[player:get_player_name()] = player:hud_add({
			hud_elem_type = "image",
			position = {x = 0.5, y = 0.7},
			offset = {x = 0, y = 0},
			text = "blank.png",
			alignment = {x = 0, y = 0},
			scale = {x = -24, y = -4},
		})
  else
		dashbarids[player:get_player_name()] = -1
	end 
end)
-- actually make the new moves
core.register_globalstep(function(dtime)
	for num, player in pairs(core.get_connected_players())
	do
	local vel = player:get_velocity()
	if vel.x == 0 and vel.z == 0 then
	velly = false
	if vel.y == 0 then
	vell = false
	else
		vell = true
	end
	else
		velly = true
	vell = true
	end
	local playername = player:get_player_name()
	if zoomdb[playername] < 2 then
	zoomdb[playername] = zoomdb[playername] + dtime
	dsb = core.settings:get_bool("sp_dashotbar", false) 
	if zoomdb[playername] < 0.9 then
    aratox_checks = fakeup_checks
		if dsb then
	player:hud_set_hotbar_image("mcla_inventory_hotbar_cd.png^[lowpart:"..zoomdb[playername] * 50 ..":mcla_inventory_hotbar_cd_y.png^[transformR270")
	else
		player:hud_change(dashbarids[playername], "text", "alphaver_dashbar_bg.png^[lowpart:"..zoomdb[playername] * 50 ..":alphaver_dashbar_y.png^[transformR270")
		end
	elseif zoomdb[playername] < 2 then
		if dsb then
	player:hud_set_hotbar_image("mcla_inventory_hotbar_cd.png^[lowpart:"..zoomdb[playername] * 50 ..":mcla_inventory_hotbar_cd_b.png^[transformR270")
	else
		player:hud_change(dashbarids[playername], "text", "alphaver_dashbar_bg.png^[lowpart:"..zoomdb[playername] * 50 ..":alphaver_dashbar_b.png^[transformR270")
		end
	else
		player:hud_set_hotbar_image("mcla_inventory_hotbar.png")
		core.sound_play("ready", {
			object = player, max_hear_distance = 40
		}, true)
		player:set_physics_override({speed = 1})
    aratox_checks = backup_checks
		if not dsb then
		player:hud_change(dashbarids[playername], "text", "blank.png")
		end
	end
	end
	if player:get_player_control()["zoom"] and vell and zoomdb[playername] >= 1 and zoomdb[playername] < 2 then
	zoomdb[playername] = 0
	player:add_velocity({
		x = vel.x * 2.25, y = vel.y * 1, z = vel.z * 2.25
	})
	core.sound_play("longjump", {
		object = player, max_hear_distance = 40
	}, true)
	end
	if player:get_player_control()["zoom"] and vell and zoomdb[playername] >= 2 then
	zoomdb[playername] = 0
	player:add_velocity({
		x = vel.x * 4.5, y = vel.y * 2, z = vel.z * 4.5
	})
	core.sound_play("dash", {
		object = player, max_hear_distance = 40
	}, true)
	end
	if player:get_player_control()["jump"] and player:get_player_control()["sneak"] and vell and zoomdb[playername] >= 2 then
	core.sound_play("longjump", {
		object = player, max_hear_distance = 40
	}, true)
	player:add_velocity({x = math.sin(player:get_look_horizontal()) * -16, y = 0, z = math.cos(player:get_look_horizontal()) * 16})
	zoomdb[playername] = 0
	end
	end
	velly = nil
	vell = nil
	end)

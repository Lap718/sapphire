-- define tables
chunknames = {
	"BA",
	"FE",
	"GE",
	"IL",
	"MU",
	"RU",
	"TU",
	"SU",
	"YA"
}
chunknameids = {}
-- give the hud element
core.register_on_joinplayer(function(player)
	chunknameids[player:get_player_name()] = player:hud_add({
		hud_elem_type = "text",
		position = {
			x = 0.7,
			y = 0.2
		},
		alignment = {x=0,y=0},
		offset = {x=0, y=0},
		text = "ANO-NAMAN-ITO",
		size = {x = 2},
		number = 0xDDEEEEEE,
		style = 5
	})
end)
core.register_globalstep(function(dtime)
	for _, player in ipairs(core.get_connected_players())
	do
		local seed = math.random(-99, 99)
		math.randomseed(math.floor(player:get_pos().x / 16) + math.floor(player:get_pos().z / 16))
		x = ((math.floor(player:get_pos().x / 16) * math.random(-1, 3)).. ""):gsub("-", "KA")
		z = (math.floor(player:get_pos().z / 16)* math.random(-1, 3)) .. ""
		math.randomseed(seed)
		for num, syllable in ipairs(chunknames)
		do
			x = x:gsub(num.."", syllable)
			x = x:gsub("0", "HA")
			z = z:gsub("0", "HU")
			z = z:gsub(num.."", syllable)
		end
		player:hud_change(chunknameids[player:get_player_name()], "text", x..z)
		x = nil
		z = nil
		end
end)
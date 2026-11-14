if core.settings:get_bool("sp_flowers", true) then
add.plant("flowers:frozenlily", "Frozen Lily", "frozen_lily.png", 1)
add.glow("flowers:frozenlily", 10)
add.plant("flowers:frozenlily_disc", "Frozen Lily (Disonnect)", "frozen_lily_disc.png", 1)
add.drop("flowers:frozenlily_disc", "flowers:frozenlily")
add.glow("flowers:frozenlily_disc", 12)
add.plant("flowers:frozenlily_connect", "Frozen Lily (Connect)", "frozen_lily_connect.png")
add.glow("flowers:frozenlily_connect", 15)
add.plant("flowers:ice_stem_v", "Frigid Branches", "ice_branches.png")
add.drop("flowers:frozenlily_connect", "flowers:frozenlily")
add.plant("flowers:bush", "Firefly Bush", "firefly_bush.png")
add.glow("flowers:bush", 15)
else
	local aliases = {
	["alphaver:waterlily"] = {
		"frozenlily",
		"frozenlily_connect",
		"frozenlily_disc"
	},
	["minecraft:ice_stem"] = {
		"ice_stem_v"
	},
	["alphaver:bush"] = {
		"flowers:bush"
	}
}
for to, list in pairs(aliases)
do
for num, name in ipairs(list)
do
core.register_alias("flowers:"..name, to)
end
end
end
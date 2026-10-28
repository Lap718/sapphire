add.glass("windowblocks:window", "Fortified Glass", {terrain(145)})
core.register_alias("hub:window", "windowblocks:window")
core.register_craft({
	output = "windowblocks:window 2",
	recipe = {
		{"", "minecraft:cobble", ""},
		{"minecraft:cobble", "minecraft:glass", "minecraft:cobble"},
		{"", "minecraft:cobble", ""}
	}
})
core.register_craft({
	output = "windowblocks:window 8",
	recipe = {
		{"minecraft:glass", "minecraft:obsidian", "minecraft:glass"},
		{"minecraft:obsidian", "minecraft:obsidian", "minecraft:obsidian"},
		{"minecraft:glass", "minecraft:obsidian", "minecraft:glass"}
	}
})
for num, name in ipairs(colours)
do

	add.glass("windowblocks:".. name:lower() .."_window", "Fortified "..name.." Glass", {terrain(116 + num)})
	core.register_craft({
		output = "windowblocks:"..name:lower() .."_window",
		recipe = {"windowblocks:window", "dyes:dye_"..name:lower()},
		type = "shapeless"
	})
-- make the dyed glass recipe, but only if sp_dyed_glass is on
if core.settings:get_bool("sp_dyed_glass", false) == true then
	minetest.register_craft({
		output = "minecraft:glass_" .. name:lower(),
		recipe = {
			{"minecraft:glass", "dyes:dye_" .. name:lower() },
				}
		})
end
end

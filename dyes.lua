-- make the dyes
for num, name in ipairs(colours)
do
    add.item("dyes:dye_" .. name:lower(), " Dye", item(55) .. "^[colorizehsl:0:0^[makealpha:0,0,0^[colorize:".. name:lower() ..":128^[contrast:64")
    add.override("dyes:dye_"..name:lower(), "description", S(name) ..S(" Dye"))
end

-- add green stone
core.register_item(":minecraft:greenstone", {
    description = S("Greenstone"),
    sounds = block_sound("sand"),
    tiles = {
    "(" .. terrain(101) .. ")^[transformR90",
    "greenstone_curve.png",
    "greenstone_t_junction.png",
    terrain(100)
    },
    selection_box = { type = "fixed", fixed = { {-0.5, -0.5, -0.5, 0.5, -0.38, 0.5} } },
    groups = {oddly_breakable_by_hand = 1},
    walkable = false,
    sunlight_propagates = true,
    paramtype = "light",
    type = "node",
    drawtype = "raillike",
    inventory_image = item(40) .."^[colorize:green:128^[contrast:64",
    wield_image = item(55).."^[colorize:green:128^[contrast:64",
    _tt_help = S("this is a conductive material")
})
add.ore("minecraft:greenstone", "Greenstone Ore", {terrain(51)}, "minecraft:stone", 30)
add.glow("minecraft:greenstone_ore", 5)
local sources = {"mushroom2", "flower", "greenstone", "coal"}
for num, name in ipairs(colours)
do
core.register_craft({
    type = "cooking",
    output = "dyes:dye_".. name:lower() .." 4",
    recipe = "minecraft:" .. sources[num],
    cooktime = "8"
})
end
-- add dyed glass
for num, name in ipairs(colours)
do
			add.glass("minecraft:glass_"..name:lower(), name.. " Glass", {terrain(132 + num), "glass.png^[colorize:" .. name:lower() .. ":128"})
end


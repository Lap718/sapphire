-- make the dyes
for num, name in ipairs(colours)
do
    add.item("dyes:dye_" .. name:lower(), " Dye", item(55) .. "^[colorizehsl:0:0^[makealpha:0,0,0^[colorize:".. name:lower() ..":128^[contrast:64")
    add.override("dyes:dye_"..name:lower(), "description", S(name) ..S(" Dye"))
end


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


add.woodtype("alphaver:fire", "Flamewood", terrain(182), terrain(182), terrain(183), terrain(184), terrain(185), path.."/schematics/firetree.mts")
if core.settings:get_bool("sp_firewood", false) == true then
    core.override_item("alphaver:firewood", {
        tiles = {terrain(199), terrain(199), terrain(182)}
    })
end
core.register_decoration({
    deco_type = "schematic",
    place_on = "minecraft:grass",
    schematic = "schematics/firetree.mts",
    sidelen = 16,
    fill_ratio = .005,
    y_min = -14,
    y_max = 56,
    biomes = {"grasslands", "beach", "sea"}
})
if core.settings:get_bool("sp_workbench", true) == false then
    add.override("minecraft:crafting_table", "tiles", {
            "workbench_top_brown.png",
             terrain(4),
            "workbench_side_brown.png",
            "workbench_front_brown.png",
            "workbench_side_brown.png",
            "workbench_front_brown.png"
    })
    add.override("minecraft:crafting_table", "description", S("Wooden Workbench"))
end
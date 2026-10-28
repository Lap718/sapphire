core.register_craftitem(":minecraft:obsidian_ingot", {
    description = "Obsidian Ingot",
    inventory_image = item(23) .."^[multiply:purple"
})
core.register_craft({
    type = "cooking",
    output = "minecraft:obsidian_ingot 9",
    recipe = "minecraft:obsidian",
    cooktime = "8"
})
local armorNames = {"Helm", "Chestplate", "Leggings", "Boots"}
local armorTypes = {"head", "torso", "legs", "feet"}
local armorDurability = {528, 768, 720, 624}
local armorPoints = {3, 8, 6, 3}
for num, name in ipairs(armorNames)
do
core.register_tool(":mcla_armor:obsidian_" .. name:lower(), {
    description = "Obsidian " .. name,
    inventory_image = item(16 * (-1 + num) + 2) .."^[multiply:purple",
    on_place = armor.on_armor_use,
    on_secondary_use = armor.on_armor_use,
})
    local tool = core.registered_tools["mcla_armor:obsidian_"..name:lower()]
    tool.groups["armor" .. armorTypes[num]] = 1
    tool.groups.mcla_armor_uses = armorDurability[num]
    tool.groups.mcla_armor_points = armorPoints[num]
    core.override_item("mcla_armor:obsidian_" .. name:lower(), {
    groups = tool.groups
})
end
-- make recipes
core.register_craft(
{
    recipe = {
    {"minecraft:obsidian_ingot", "minecraft:obsidian_ingot", "minecraft:obsidian_ingot"},
    {"minecraft:obsidian_ingot", "", "minecraft:obsidian_ingot"}

},
    output = "mcla_armor:obsidian_helm"
}
)
core.register_craft(
{
    recipe = {

    {"minecraft:obsidian_ingot", "", "minecraft:obsidian_ingot"},
    {"minecraft:obsidian_ingot", "minecraft:obsidian_ingot", "minecraft:obsidian_ingot"},
        {"minecraft:obsidian_ingot", "minecraft:obsidian_ingot", "minecraft:obsidian_ingot"}
},
    output = "mcla_armor:obsidian_chestplate"
})
core.register_craft(
{
    recipe = {
    {"minecraft:obsidian_ingot", "minecraft:obsidian_ingot", "minecraft:obsidian_ingot"},
    {"minecraft:obsidian_ingot", "", "minecraft:obsidian_ingot"},
    {"minecraft:obsidian_ingot", "", "minecraft:obsidian_ingot"}

},
    output = "mcla_armor:obsidian_leggings"
}
)
core.register_craft(
{
    recipe = {
    {"minecraft:obsidian_ingot", "", "minecraft:obsidian_ingot"},
    {"minecraft:obsidian_ingot", "", "minecraft:obsidian_ingot"}

},
    output = "mcla_armor:obsidian_boots"
}
)


-- fix the obsidian sword

core.override_item("ethereal_bosses:sword_obsidian", {
    inventory_image = tool(43, 1, 53),
    wield_image = tool(37, 1, 53)
})
-- register crafts for the obsidian tools
core.register_craft(
{
    recipe = {

        { "minecraft:obsidian_ingot"},
        { "minecraft:obsidian_ingot"},
        { "minecraft:stick"}
},
    output = "ethereal_bosses:sword_obsidian"
})
core.register_craft(
{
    recipe = {

        { "minecraft:obsidian_ingot"},
        { "minecraft:stick"},
        { "minecraft:stick"}
},
    output = "ethereal_bosses:shovel_obsidian"
})
core.register_craft(
{
    recipe = {

        { "minecraft:obsidian_ingot", "minecraft:obsidian_ingot", "minecraft:obsidian_ingot"},
        { "", "minecraft:stick", ""},
        { "", "minecraft:stick", ""}
},
    output = "ethereal_bosses:pick_obsidian"
})
core.register_craft(
{
    recipe = {

        {"minecraft:obsidian_ingot", "minecraft:obsidian_ingot"},
        { "minecraft:obsidian_ingot", "minecraft:stick"},
        { "", "minecraft:stick"}
},
    output = "ethereal_bosses:axe_obsidian"
})
core.register_craft(
{
    recipe = {

        { "minecraft:obsidian_ingot", "minecraft:obsidian_ingot"},
        { "", "minecraft:stick"},
        { "", "minecraft:stick"}
},
    output = "ethereal_bosses:hoe_obsidian"
})
-- register the rest of the obsidian tools
for num, name in ipairs(tools)
do
    if num > 1 then
        local grops = {}
        grops[toolGroups[num]] = {
            times = { [1] = 0.08, [2] = 0.60, [3] = 1.00 },
            uses = 2272,
            maxlevel = 4
        }
        core.register_tool(":ethereal_bosses:" .. name:lower() .. "_obsidian", {
    wield_image = tool(37, num, 53),
    inventory_image = tool(43, num, 53),
    description = "Obsidian " .. name,
    tool_capabilities = {
        full_punch_interval = 1.4,
        max_drop_level = 4,
        groupcaps = grops
  }
})
end
end

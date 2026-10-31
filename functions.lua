-- functions for certain atlases
function upper(id)
return atlas_id("terrain", id)
end
function item(id)
return atlas_id("items", id)
end
-- sneakily swap out the terrain atlas with the extra atlas
function terrain(id)
return upper(id)
end
function door(tex)
return "[combine:256x256:16,80="..tex
end
-- function to apply(, assuming it doesn't have invisible color,) another texture's alpha onto a texture
function alphacutout(source, destination)
return "("..source.."^[screen:#010101)^("..destination.."^[invert:a)^[makealpha:0,0,0"
end
-- function for easy building of custom tool textures
function tool(tile, num, stick)
return alphacutout(terrain(tile) .."^".. item(stick), item(16 *(num + 3) + 2))
end
--function for making slabs connect
function connect_slab(pos, name, full)
local below = vector.offset(pos, 0, -1, 0)
if core.get_node(below)["name"] == name then
core.set_node(below, {
	name = full
})
core.set_node(pos, {
	name = "air"
})
end
end
-- make the functions to easily make nodes
local materials = {
	cloth = "crumbly",
	snow = "crumbly",
	wood = "choppy",
	gravel = "crumbly",
	metal = "cracky",
	grass = "crumbly",
	stone = "cracky",
	ladder = "choppy"
}
add = {}
--- iterate over the local table
for material, group in pairs(materials)
do
add[material] = function(name, description, tiles)
local groups = {}
groups[group] = 2
core.register_node(":"..name, {
	description = S(description),
	sounds = block_sound(material),
	groups = groups,
	tiles = tiles
})
end
end
--- add a few extra add functions
---- basic overrides to be used later
add.override = function(name, key, value)
core.override_item(name, {
	[key] = value
})
end
local simple_overrides = {
	invimage = "inventory_image",
	glow = "light_source",
	waving = "waving",
	rotate = "paramtype2",
	drop = "drop",
	drawtype = "drawtype",
}
for short, long in pairs(simple_overrides)
do
add[short] = function(name, value)
core.override_item(name, {
	[long] = value
})
end
end
add.light = function(name)
add.override(name, "paramtype", "light")
add.override(name, "sunlight_propagates", true)
add.override(name, "use_texture_alpha", true)
end
add.group = function(name, group, value)
if not value then
local value = 2
end
local groups = core.registered_nodes[name].groups
groups[group] = value
core.override_item(name, {
	groups = groups
})
end
add.fallthrough = function(name)
add.override(name, "walkable", false)
end
add.nodebox = function(name, nodebox)
add.drawtype(name, "nodebox")
add.light(name)
add.override(name, "node_box", nodebox)
add.override(name, "selection_box", nodebox)
end
add.unbreaking = function(name)
local digroups = {
	"cracky", "crumbly", "choppy"
}
for num, gname in ipairs(digroups)
do
add.group(name, gname, 0)
end
end
add.mesh = function(name, mesh)
add.drawtype(name, "mesh")
add.light(name)
add.override(name, "mesh", mesh)
end
---- functions that register new items with some special properties
add.clone = function(name, newname)
core.register_node(":"..newname, core.registered_nodes[name])
end
add.glass = function(name, description, tiles)
add.stone(name, description, tiles)
add.light(name)
add.drawtype (name, "glasslike_framed_optional")
add.group(name, "oddly_breakable_by_hand")
end
add.item = function(name, description, invimage)
core.register_craftitem(":"..name, {})
add.override(name, "description", S(description))
add.invimage(name, invimage)
end
add.plant = function(name, description, tile, waving)
add.grass(name, description, {
	tile, tile.."^[transformFX"
})
add.light(name)
add.fallthrough(name)
add.invimage(name, tile)
add.waving(name, waving)
add.drawtype(name, "plantlike")
end
add.leaves = function(name, description, fancy, simple)
add.grass(name, description, {
	"("..fancy..")^("..simple.."^[opacity:1)"
})
add.light(name)
add.waving(name, 2)
add.drawtype(name, "allfaces_optional")
end
add.exchange = function(old, new)
core.register_craft({
	recipe = {{
		old
	}},
	output = new
})
end
add.stairs = function(name, description, tiles, material, full)
	local desc = core.translate("sapphire", description)
add[material](name.."_slab", S("@1 Slab", desc), tiles)
add.nodebox(name.."_slab", {
	type = "fixed", fixed = {
		{
			-0.5000, -0.5000, -0.5000, 0.5000, 0.000, 0.5000
		}
	}
})
add.override(name.."_slab", "on_construct", function(pos)
	connect_slab(pos, name.."_slab", full)
	end)
add[material](name.."_stair", S("@1 Stairs", desc), tiles)
add.rotate(name.."_stair", "facedir")
add.nodebox(name.."_stair", {
	type = "fixed", fixed = {
		{
			-0.5000, -0.5000, -0.5000, 0.5000, 0.000, 0.5000
		}, {
			-0.5000, 0.000, 0.000, 0.5000, 0.5000, 0.5000
		}
	}
})
end
add.ore = function(material, description, tiles, wherein, y_max)
add.stone(material.."_ore", description, tiles)
add.drop(material.."_ore", material)
core.register_ore({
	ore_type = "scatter",
	ore = material.."_ore",
	wherein = wherein,
	clust_scarcity = 8 ^ 3,
	clust_size = 8,
	clust_num_ores = 16,
	y_min = -3100,
	y_max = y_max,
})
end
add.door = function(name, description, sheet, invimage, base, material)
doors.register(name, {
	description = S(description),
	tiles = {{
		name = sheet, backface_culling = true
	}},
	inventory_image = invimage,
	groups = {
		[material] = 1
	},
	recipe = {
		{
			base, base
		},
		{
			base, base
		},
		{
			base, base
		}
	}
})
end
add.woodtype = function(name, description, bark, treetop, fancy, simple, planks, schema)
add.plant(name.."wood_sapling", S("@1 Sapling", description), "sapling_"..description:lower()..".png", 1)
add.wood(name.."wood", S("@1 Log", description), {
	treetop, treetop, bark
})
add.leaves(name.."leaves", S("@1 Leaves", description), fancy, simple)
add.wood(name.."planks", S("@1 Planks", description), {
	planks
})
add.stairs(name.."plank", description, {
	planks
}, "wood", name.."planks")
add.exchange(name.."wood", name.."planks 4")
if core.settings:get_bool("sp_saplings", true) == true then
add.drop(name.."leaves", name.."wood_sapling")
core.register_abm({
	label = description:lower() .." sapling growing",
	nodenames = name.."wood_sapling",
	interval = 12.5,
	chance = 32,
	action = function(pos)
	if can_grow(pos) then
	core.place_schematic(vector.offset(pos, -2, 0, -2), schema)
	end
	end
})
end
end
local plates = {
	Solar = terrain(62),
	Denial = terrain(63),
	Part = terrain(79),
	Loop = terrain(78),
	Switch = terrain(77),
	Mirrors = terrain2(30),
	Syllables = terrain2(29),
	Dialect = terrain2(27),
	Association = terrain2(28),
	Trinity = terrain2(26)
}
for name, tile in pairs(plates)
do
add.stone("alphaver:plate_"..name:lower(), S("@1 Plate", name), {
	tile
})
add.nodebox("alphaver:plate_"..name:lower(), {
	type = "fixed",
	fixed = {
		{
			-0.5000, -0.5000, -0.5000, 0.5000, -0.4375, 0.5000
		}
	}
})
add.invimage("alphaver:plate_"..name:lower(), tile)
add.instamine("alphaver:plate_"..name:lower())
add.glow("alphaver:plate_"..name:lower(), 11)
add.drawtype("alphaver:plate_"..name:lower(), "signlike")
add.rotate("alphaver:plate_"..name:lower(), "wallmounted")
end
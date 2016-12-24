module Roster
		
		# --- CURRENT UCM SHIPS ---

#[name, scan, signature, thrust, hull, armor, point_defense, group_size_id, tonnage, special, points]
	beijing = ["Beijing", 8, 12, 6, 18, "3+", 10, 1, "S", nil, 252]
	new_york = ["New York", 8, 12, 6, 18, "3+", 10, 1, "S", "Launch", 260]
	tokyo = ["Tokyo", 8, 12, 6, 18, "3+", 10, 1, "S", nil, 220]
	atlantis = ["Atlantis", 6, 6, 8, 14, "3+", 7, 1, "H", "Launch", 205]
	avalon = ["Avalon", 6, 6, 8, 14, "3+", 7, 1, "H", "Rare", 195]
	moscow = ["Moscow", 6, 6, 7, 12, "3+", 5, 1, "H", nil, 163]
	st_petersburg = ["St Petersburg", 6, 6, 7, 12, "3+", 5, 1, "H", "Rare", 155]
	rio = ["Rio", 6, 6, 8, 10, "3+", 5, 2, "M", nil, 105]
	berlin = ["Berlin", 6, 6, 8, 10, "3+", 5, 2, "M", nil, 105]
	madrid = ["Madrid", 6, 6, 8, 10, "3+", 5, 2, "M", nil, 79]
	seattle = ["Seattle", 6, 6, 8, 10, "3+", 1, "M", "Launch", 132]
	osaka = ["Osaka", 6, 6, 10, 8, "4+", 5, 5, "M", nil, 86]
	new_cairo = ["New Cairo", 6, 6, 10, 8, "4+", 5, 5, "M", nil, 88]
	san_francisco = ["San Fransisco", 6, 6, 8, 10, "3+", 5, 1, "M", "Launch", 111]
	toulon = ["Toulon", 6, 3, 10, 4, "4+", 3, 6, "L", nil, 35]
	taipei = ["Taipei", 6, 3, 10, 4, "4+", 3, 7, "L", nil, 39]
	jakarta = ["Jakarta", 6, 3, 10, 4, "4+", 3, 4, "L", "Aegis", 32]
	lima = ["Lima", 6, 3, 10, 4, "4+", 3, 2, "L", "Detector, Outlier, Rare", 37]
	new_orleans = ["New Orleans", 6, 3, 10, 4, "4+", 3, 2, "L", "Atmospheric, Launch, Open", 32]
	santiago = ["Santiago", 6, 2, 14, 2, "5+", 2, 3, "L", "Atmospheric, Outlier", 22]

	UCM_ROSTER = [beijing, new_york, tokyo, atlantis, avalon, moscow, st_petersburg, rio, berlin, madrid, seattle, osaka, new_cairo, san_francisco, toulon, taipei, jakarta, lima, new_orleans, santiago]


	# Example roster method = not a mix-in, use SELF to denote and call
	# by MODULE::method(or constant)

	# def self.create_ships(ship_roster)
	# end
end


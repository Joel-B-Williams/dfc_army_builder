module Roster

		# --- DEFAULT NONE VALUE ---
	default_ship = ["none", 0, 0, 0, 0, "0", 0, 1, "none", nil, 0, "none"]
	
		# --- CURRENT UCM SHIPS ---

#[name, scan, signature, thrust, hull, armor, point_defense, group_size_id, tonnage, special, points]
	beijing = ["Beijing", 8, 12, 6, 18, "3+", 10, 1, "S", nil, 252, "ucm"]
	new_york = ["New York", 8, 12, 6, 18, "3+", 10, 1, "S", "Launch", 260, "ucm"]
	tokyo = ["Tokyo", 8, 12, 6, 18, "3+", 10, 1, "S", nil, 220, "ucm"]
	atlantis = ["Atlantis", 6, 6, 8, 14, "3+", 7, 1, "H", "Launch", 205, "ucm"]
	avalon = ["Avalon", 6, 6, 8, 14, "3+", 7, 1, "H", "Rare", 195, "ucm"]
	moscow = ["Moscow", 6, 6, 7, 12, "3+", 5, 1, "H", nil, 163, "ucm"]
	st_petersburg = ["St Petersburg", 6, 6, 7, 12, "3+", 5, 1, "H", "Rare", 155, "ucm"]
	rio = ["Rio", 6, 6, 8, 10, "3+", 5, 2, "M", nil, 105, "ucm"]
	berlin = ["Berlin", 6, 6, 8, 10, "3+", 5, 2, "M", nil, 105, "ucm"]
	madrid = ["Madrid", 6, 6, 8, 10, "3+", 5, 2, "M", nil, 79, "ucm"]
	seattle = ["Seattle", 6, 6, 8, 10, "3+", 5, 1, "M", "Launch", 132, "ucm"]
	osaka = ["Osaka", 6, 6, 10, 8, "4+", 5, 5, "M", nil, 86, "ucm"]
	new_cairo = ["New Cairo", 6, 6, 10, 8, "4+", 5, 5, "M", nil, 88, "ucm"]
	san_francisco = ["San Fransisco", 6, 6, 8, 10, "3+", 5, 1, "M", "Launch", 111, "ucm"]
	toulon = ["Toulon", 6, 3, 10, 4, "4+", 3, 6, "L", nil, 35, "ucm"]
	taipei = ["Taipei", 6, 3, 10, 4, "4+", 3, 7, "L", nil, 39, "ucm"]
	jakarta = ["Jakarta", 6, 3, 10, 4, "4+", 3, 4, "L", "Aegis", 32, "ucm"]
	lima = ["Lima", 6, 3, 10, 4, "4+", 3, 2, "L", "Detector, Outlier, Rare", 37, "ucm"]
	new_orleans = ["New Orleans", 6, 3, 10, 4, "4+", 3, 2, "L", "Atmospheric, Launch, Open", 32, "ucm"]
	santiago = ["Santiago", 6, 2, 14, 2, "5+", 2, 3, "L", "Atmospheric, Outlier", 22, "ucm"]

	FULL_ROSTER = [default_ship, beijing, new_york, tokyo, atlantis, avalon, moscow, st_petersburg, rio, berlin, madrid, seattle, osaka, new_cairo, san_francisco, toulon, taipei, jakarta, lima, new_orleans, santiago]

	def self.create_ships(roster, db)
		created_ships = []
		roster.each_with_index do |ship, index|
			created_ship = []
			created_ship << ship = Ship.new(roster, index, db)
			created_ships << created_ship
		end
		created_ships
	end
	# Example roster method = not a mix-in, use SELF to denote and call
	# by MODULE::method(or constant)

	
end

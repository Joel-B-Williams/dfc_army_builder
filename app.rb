class Ship
	def initialize(name, scan, signature, thrust, hull, armor, point_defense, group_size, tonnage, special)
		@name = name
		@scan = scan
		@signature = signature
		@thrust = thrust
		@hull = hull
		@armor = armor
		@point_defense = point_defense
		@group_size = group_size
		@tonnage = tonnage
		@special = special
	end

end

beijing = ["Beijing", 8, 12, 6, 18, "3+", 10, 1, "S", nil]
new_york = ["New York", 8, 12, 6, 18, "3+", 10, 1, "S", "Launch"]
tokyo = ["Tokyo", 8, 12, 6, 18, "3+", 10, 1, "S", nil]
atlantis = ["Atlantis", 6, 6, 8, 14, "3+", 7, 1, "H", "Launch"]
avalon = ["Avalon", 6, 6, 8, 14, "3+", 7, 1, "H", "Rare"]
moscow = ["Moscow", 6, 6, 7, 12, "3+", 5, 1, "H", nil]
st_petersburg = ["St Petersburg", 6, 6, 7, 12, "3+", 5, 1, "H", "Rare"]
rio = ["Rio", 6, 6, 8, 10, "3+", 5, (1..2), "M", nil]
berlin = ["Berlin", 6, 6, 8, 10, "3+", 5, (1..2), "M", nil]
madrid = ["Madrid", 6, 6, 8, 10, "3+", 5, (1..2), "M", nil]
seattle = ["Seattle", 6, 6, 8, 10, "3+", 5, 1, "M", "Launch"]
osaka = ["Osaka", 6, 6, 10, 8, "4+", 5, (2..3), "M", nil]
new_cairo = ["New Cairo", 6, 6, 10, 8, "4+", 5, (2..3), "M", nil]
san_francisco = ["San Fransisco", 6, 6, 8, 10, "3+", 5, 1, "M", "Launch"]
toulon = ["Toulon", 6, 3, 10, 4, "4+", 3, (2..4), "L", nil]
taipei = ["Taipei", 6, 3, 10, 4, "4+", 3, (2..6), "L", nil]
jakarta = ["Jakarta", 6, 3, 10, 4, "4+", 3, (1..4), "L", "Aegis"]
lima = ["Lima", 6, 3, 10, 4, "4+", 3, (1..2), "L", "Detector, Outlier, Rare"]
new_orleans = ["New Orleans", 6, 3, 10, 4, "4+", 3, (1..2), "L", "Atmospheric, Launch, Open"]
santiago = ["Santiago", 6, 2, 14, 2, "5+", 2, (1..3), "L", "Atmospheric, Outlier"]

ucm_roster = [beijing, new_york, tokyo, atlantis, avalon, moscow, st_petersburg, rio, berlin, madrid, seattle, osaka, new_cairo, san_francisco, toulon, taipei, jakarta, lima, new_orleans, santiago]

def create_ships(ship_roster)
	created_ships = []
	ship_roster.each do |ship|
		ship = Ship.new(ship[0], ship[1], ship[2], ship[3], ship[4], ship[5], ship[6], ship[7], ship[8], ship[9])
		created_ships << ship
	end
	created_ships
end

ucm_ships = create_ships(ucm_roster)





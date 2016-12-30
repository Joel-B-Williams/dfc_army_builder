module Roster

		# --- DEFAULT NONE VALUE ---
	default_ship = ["none", 0, 0, 0, 0, "0", 0, 1, "none", nil, 0, "none"]
	
		# --- CURRENT UCM SHIPS ---

#[name, scan, signature, thrust, hull, armor, point_defense, group_size_id, tonnage, special, points]
	beijing = ["Beijing", 8, "12", 6, 18, "3+", 10, 1, "S", nil, 252, "ucm"]
	new_york = ["New York", 8, "12", 6, 18, "3+", 10, 1, "S", "Launch", 260, "ucm"]
	tokyo = ["Tokyo", 8, "12", 6, 18, "3+", 10, 1, "S", nil, 220, "ucm"]
	atlantis = ["Atlantis", 6, "6", 8, 14, "3+", 7, 1, "H", "Launch", 205, "ucm"]
	avalon = ["Avalon", 6, "6", 8, 14, "3+", 7, 1, "H", "Rare", 195, "ucm"]
	moscow = ["Moscow", 6, "6", 7, 12, "3+", 5, 1, "H", nil, 163, "ucm"]
	st_petersburg = ["St Petersburg", 6, "6", 7, 12, "3+", 5, 1, "H", "Rare", 155, "ucm"]
	rio = ["Rio", 6, "6", 8, 10, "3+", 5, 2, "M", nil, 105, "ucm"]
	berlin = ["Berlin", 6, "6", 8, 10, "3+", 5, 2, "M", nil, 105, "ucm"]
	madrid = ["Madrid", 6, "6", 8, 10, "3+", 5, 2, "M", nil, 79, "ucm"]
	seattle = ["Seattle", 6, "6", 8, 10, "3+", 5, 1, "M", "Launch", 132, "ucm"]
	osaka = ["Osaka", 6, "6", 10, 8, "4+", 5, 5, "M", nil, 86, "ucm"]
	new_cairo = ["New Cairo", 6, "6", 10, 8, "4+", 5, 5, "M", nil, 88, "ucm"]
	san_francisco = ["San Fransisco", 6, "6", 8, 10, "3+", 5, 1, "M", "Launch", 111, "ucm"]
	toulon = ["Toulon", 6, "3", 10, 4, "4+", 3, 6, "L", nil, 35, "ucm"]
	taipei = ["Taipei", 6, "3", 10, 4, "4+", 3, 7, "L", nil, 39, "ucm"]
	jakarta = ["Jakarta", 6, "3", 10, 4, "4+", 3, 4, "L", "Aegis", 32, "ucm"]
	lima = ["Lima", 6, "3", 10, 4, "4+", 3, 2, "L", "Detector, Outlier, Rare", 37, "ucm"]
	new_orleans = ["New Orleans", 6, "3", 10, 4, "4+", 3, 2, "L", "Atmospheric, Launch, Open", 32, "ucm"]
	santiago = ["Santiago", 6, "2", 14, 2, "5+", 2, 3, "L", "Atmospheric, Outlier", 22, "ucm"]

		# ---- Current Scourge Ships ----	
#[name, scan, signature, thrust, hull, armor, point_defense, group_size_id, tonnage, special, points]
	daemon = ["Daemon", 8, "14", 8, 18, "3+", 12, 1, "S", nil, 260, "scourge"]
	dragon = ["Dragon", 8, "14", 8, 18, "3+", 12, 1, "S", "Launch", 265, "scourge"]
	basilisk = ["Basilisk", 6, "8", 10, 14, "4+", 8, 1, "H", "Stealth, Full Cloak", 205, "scourge"]
	manticore = ["Manticore", 6, "8", 10, 14, "4+", 8, 1, "H", "Stealth, Full Cloak, Launch", 190, "scourge"]
	shenlong = ["Shenlong", 6, "8", 8, 12, "4+", 6, 1, "H", "Stealth, Partial Cloak", 170, "scourge"]
	raiju = ["Raiju", 6, "8", 8, 12, "4+", 6, 1, "H", "Stealth, Partial Cloak", 160, "scourge"]
	sphinx = ["Sphinx", 6, "8", 10, 10, "4+", 6, 2, "M", nil, 115, "scourge"]
	wyvern = ["Wyvern", 6, "8", 10, 10, "4+", 6, 2, "M", nil, 105, "scourge"]
	ifrit = ["Ifrit", 6, "8", 10, 10, "4+", 6, 2, "M", nil, 110, "scourge"]
	hydra = ["Hydra", 6, "8", 10, 10, "4+", 6, 1, "M", "Launch", 140, "scourge"]
	chimera = ["Chimera", 6, "8", 10, 10, "4+", 6, 1, "M", "Launch", 105, "scourge"]
	strix = ["Strix", 6, "8", 12, 8, "5+", 2, 5, "M", nil, 90, "scourge"]
	yokai = ["Yokai", 6, "8", 12, 8, "5+", 2, 5, "M", nil, 95, "scourge"]
	harpy = ["Harpy", 6, "3", 12, 4, "5+", 4, 6, "L", "Atmospheric", 42, "scourge"]
	djinn = ["Djinn", 6, "3", 12, 4, "5+", 4, 7, "L", "Atmospheric", 43, "scourge"]
	charybdis = ["Charybdis", 6, "3", 12, 4, "5+", 4, 6, "L", "Atmospheric", 35, "scourge"]
	scylla = ["Scylla", 6, "3", 12, 4, "5+", 4, 6, "L", "Atmospheric", 42, "scourge"]
	gargoyle = ["Gargoyle", 6, "3", 12, 4, "5+", 4, 2, "L", "Atmospheric, Launch, Open", 32, "scourge"]
	nickar = ["Nickar", 6, "2", 16, 2, "6+", 2, 3, "L", "Atmospheric", 22, "scourge"]

		# ---- Current PHR Ships ----
#[name, scan, signature, thrust, hull, armor, point_defense, group_size_id, tonnage, special, points]
	heracles = ["Heracles", 10, "12", 6, 22, "3+", 10, 1, "S", nil, 285, "phr"]
	minos = ["Minos", 10, "12", 6, 22, "3+", 10, 1, "S", "Launch", 285, "phr"]
	leonidas = ["Leonidas", 8, "6", 10, 15, "3+", 7, 1, "H", nil, 195, "phr"]
	scipio = ["Scipio", 8, "6", 10, 15, "3+", 7, 1, "H", "Launch", 210, "phr"]
	hector = ["Hector", 8, "6", 7, 13, "3+", 5, 1, "H", nil, 170, "phr"]
	achilles = ["Achilles", 8, "6", 7, 13, "3+", 5, 1, "H", "Launch", 165, "phr"]
	bellerophon = ["Bellerophon", 8, "6", 7, 13, "3+", 5, 1, "H", "Launch", 180, "phr"]
	orpheus = ["Orpheus", 8, "6", 7, 13, "3+", 5, 1, "M", "Launch", 130, "phr"]
	ganymede = ["Ganymede", 8, "6", 7, 13, "3+", 5, 1, "M", "Launch", 135, "phr"]
	orion = ["Orion", 8, "6", 8, 11, "3+", 5, 2, "M", nil, 107, "phr"]
	ajax = ["Ajax", 8, "6", 8, 11, "3+", 5, 2, "M", nil, 100, "phr"]
	perseus = ["Perseus", 8, "6", 8, 11, "3+", 5, 1, "M", nil, 105, "phr"]
	ikarus = ["Ikarus", 8, "6", 8, 11, "3+", 5, 2, "M", "Launch", 115, "phr"]
	theseus = ["Theseus", 8, "6", 10, 9, "3+", 2, 3, "M", nil, 89, "phr"]
	europa = ["Europa", 8, "3", 10, 5, "3+", 3, 6, "L", nil, 40, "phr"]
	pandora = ["Pandora", 8, "3", 10, 5, "3+", 3, 6, "L", nil, 50, "phr"]
	calypso = ["Calypso", 8, "3", 10, 5, "3+", 3, 2, "L", "Advanced ECM Suite, Rare", 37, "phr"]
	andromeda = ["Andromeda", 8, "3", 10, 5, "3+", 3, 6, "L", "Launch", 42, "phr"]
	medea = ["Medea", 8, "3", 10, 5, "3+", 3, 2, "L", "Launch, Open, Atmospheric", 39, "phr"]
	echo = ["Echo", 8, "2", 12, 2, "4+", 2, 3, "L", "Atmospheric, Stealth, Outlier", 30, "phr"]

		# ---- CURRENT SHALTARI SHIPS ----
#[name, scan, signature, thrust, hull, armor, point_defense, group_size_id, tonnage, special, points]
	diamond = ["Diamond", 12, "4/20", 8, 18, "4+/4+", 12, 1, "S", "Launch", 270, "shaltari"]
	platinum = ["Platinum", 12, "4/20", 8, 18, "4+/4+", 12, 1, "S", "Launch", 270, "shaltari"]
	adamant = ["Adamant", 12, "3/16", 10, 13, "5+/4+", 9, 1, "H", nil, 200, "shaltari"]
	palladium = ["Palladium", 12, "3/16", 10, 13, "5+/4+", 9, 1, "H", nil, 185, "shaltari"]
	onyx = ["Onyx", 12, "3/16", 8, 11, "5+/4+", 9, 1, "H", nil, 165, "shaltari"]
	obsidian = ["Obsidian", 12, "3/16", 8, 11, "5+/4+", 9, 1, "H", nil, 155, "shaltari"]
	jet = ["Jet", 12, "3/16", 8, 11, "5+/4+", 9, 1, "H", nil, 165, "shaltari"]
	amber = ["Amber", 12, "3/16", 10, 9, "5+/4+", 9, 2, "M", nil, 110, "shaltari"]
	granite = ["Granite", 12, "3/16", 10, 9, "5+/4+", 9, 2, "M", nil, 100, "shaltari"]
	turquoise = ["Turquoise", 12, "3/16", 10, 9, "5+/4+", 9, 2, "M", nil, 115, "shaltari"]
	basalt = ["Basalt", 12, "3/16", 10, 9, "5+/4+", 9, 1, "M", "Launch", 145, "shaltari"]
	emerald = ["Emerald", 12, "3/16", 10, 9, "5+/4+", 9, 1, "M", "Launch", 100, "shaltari"]
	azurite = ["Azurite", 12, "3/16", 12, 7, "5+/4+", 6, 5, "M", "Vectored", 85, "shaltari"]
	aquamarine = ["Aquamarine", 12, "3/16", 12, 7, "5+/4+", 6, 5, "M", "Vectored", 85, "shaltari"]
	topaz = ["Topaz", 12, "2/12", 12, 4, "5+/4+", 6, 6, "L", nil, 45, "shaltari"]
	jade = ["Jade", 12, "2/12", 12, 4, "5+/4+", 6, 6, "L", nil, 45, "shaltari"]
	opal = ["Opal", 12, "2/12", 12, 4, "5+/4+", 6, 2, "L", "Shield Booster, Rare", 40, "shaltari"]
	amethyste = ["Amethyste", 12, "2/12", 12, 4, "5+/4+", 6, 2, "L", nil, 48, "shaltari"]
	voidgate = ["Voidgate", 12, "1/8", 12, 3, "5+/5+", 6, 3, "L", "Voidgate-1, Atmospheric, Open", 15, "shaltari"]
	glass = ["Glass", 8, "1/8", 16, 1, "5+/5+", 3, 7, "L", "Atmospheric, Outlier", 36, "shaltari"]

	FULL_ROSTER = [default_ship, beijing, new_york, tokyo, atlantis, avalon, moscow, st_petersburg, rio, berlin, madrid, seattle, osaka, new_cairo, san_francisco, toulon, taipei, jakarta, lima, new_orleans, santiago, daemon, dragon, basilisk, manticore, shenlong, raiju, sphinx, wyvern, ifrit, hydra, chimera, strix, yokai, harpy, djinn, charybdis, scylla, gargoyle, nickar, heracles, minos, leonidas, scipio, hector, achilles, bellerophon, orpheus, ganymede, orion, ajax, perseus, ikarus, theseus, europa, pandora, calypso, andromeda, medea, echo, diamond, platinum, adamant, palladium, onyx, obsidian, jet, amber, granite, turquoise, basalt, emerald, azurite, aquamarine, topaz, jade, opal, amethyste, voidgate, glass]

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

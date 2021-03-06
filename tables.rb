require 'sqlite3'

module Tables

	DB = SQLite3::Database.new("dfc_ships.db")
	
	def self.tables(db)
		create_tables = '
		CREATE TABLE IF NOT EXISTS group_sizes(
		id INTEGER PRIMARY KEY,
		group_size TEXT
		);

		CREATE TABLE IF NOT EXISTS ships(
		id INTEGER PRIMARY KEY,
		name TEXT,
		scan INTEGER,
		signature TEXT,
		thrust INTEGER,
		hull INTEGER,
		armor TEXT,
		point_defense INTEGER,
		group_sizes_id INTEGER REFERENCES group_sizes(id),
		tonnage TEXT,
		special TEXT,
		points INTEGER,
		faction TEXT
		);

		CREATE TABLE IF NOT EXISTS groups(
		id INTEGER PRIMARY KEY,
		name TEXT,
		faction TEXT,
		ship_id INTEGER REFERENCES ships(id),
		number INTEGER,
		points INTEGER
		);

		CREATE TABLE IF NOT EXISTS battlegroup_types(
		id INTEGER PRIMARY KEY,
		name TEXT,
		light TEXT,
		medium TEXT,
		heavy TEXT,
		super_heavy TEXT
		);

		CREATE TABLE IF NOT EXISTS battlegroups(
		id INTEGER PRIMARY KEY,
		name TEXT,
		faction TEXT,
		type INTEGER REFERENCES battlegroup_types(id),
		group1_id INTEGER REFERENCES groups(id),
		group2_id INTEGER REFERENCES groups(id),
		group3_id INTEGER REFERENCES groups(id),
		points INTEGER
		);

		CREATE TABLE IF NOT EXISTS fleets(
		id INTEGER PRIMARY KEY,
		name TEXT,
		faction TEXT,
		points_limit INTEGER,
		battlegroups TEXT,
		current_points INTEGER
		);'

		db.execute_batch(create_tables)

	end

	def self.populate_group_sizes(db)
		sizes = ["1", "1-2", "1-3", "1-4", "2-3", "2-4", "2-6"]
		add_group_size = 'INSERT INTO group_sizes (group_size) VALUES (?)'
		if db.execute('SELECT COUNT (*) FROM group_sizes')[0][0] == 0
			sizes.each {|size| db.execute(add_group_size, [size])}
		end
	end

	def self.default_group(db)
		set_default = 'INSERT INTO groups (name, faction, ship_id, number, points) VALUES ("none", "none", 1, 1, 0)'
		db.execute(set_default)
	end

	def self.default_battlegroup(db)
		set_default = 'INSERT INTO battlegroups (name, faction, group1_id, group2_id, group3_id, points) VALUES ("none", "none", 1, 1, 1, 0)'
		db.execute(set_default)
	end

	def self.populate_battlegroup_types(db)
		flag = ["Flag", "0-1", nil, nil, "1-2"]
		vanguard = ["Vanguard", "0-1", "0-1", "1-2", nil]
		line = ["Line", "0-2", "1-3", nil, nil]
		pathfinder = ["Pathfinder", "1-3", "0-1", nil, nil]
		battlegroups = [flag, vanguard, line, pathfinder]
		add_battlegroup = 'INSERT INTO battlegroup_types (name, light, medium, heavy, super_heavy) VALUES (?,?,?,?,?)'
		if db.execute('SELECT COUNT (*) FROM battlegroup_types')[0][0] == 0
			battlegroups.each {|battlegroup| db.execute(add_battlegroup, [battlegroup[0], battlegroup[1], battlegroup[2], battlegroup[3], battlegroup[4]])}
		end
	end
end

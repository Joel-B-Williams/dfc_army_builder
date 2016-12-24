require 'sqlite3'

module Tables

	DB = SQLite3::Database.new("dfc_ships.db")
	
	def Tables.tables(db)
		create_tables = '
		CREATE TABLE IF NOT EXISTS group_sizes(
		id INTEGER PRIMARY KEY,
		group_size TEXT
		);

		CREATE TABLE IF NOT EXISTS ships (
		id INTEGER PRIMARY KEY,
		name TEXT,
		scan INTEGER,
		signature INTEGER,
		thrust INTEGER,
		hull INTEGER,
		armor TEXT,
		point_defense INTEGER,
		group_sizes_id INTEGER REFERENCES group_sizes(id),
		tonnage TEXT,
		special TEXT,
		points INTEGER
		);'
		db.execute_batch(create_tables)
	end

	def Tables.populate_group_sizes(db)
	sizes = ["1", "1-2", "1-3", "1-4", "2-3", "2-4", "2-6"]
	add_group_size = 'INSERT INTO group_sizes (group_size) VALUES (?)'
	sizes.each {|size| db.execute(add_group_size, [size])}
	end

end

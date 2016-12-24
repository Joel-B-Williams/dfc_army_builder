require 'sqlite3'

module Tables

	DB = SQLite3::Database.new("dfc_ships.db")
	
	def Tables.tables(db)
		create_tables = '
		CREATE TABLE IF NOT EXISTS ships (
		id INTEGER PRIMARY KEY,
		name TEXT,
		scan INTEGER,
		signature INTEGER,
		thrust INTEGER,
		hull INTEGER,
		armor TEXT,
		point_defense INTEGER,
		group_size INTEGER,
		tonnage TEXT,
		special TEXT,
		points INTEGER
		);'
		db.execute(create_tables)
	end

end
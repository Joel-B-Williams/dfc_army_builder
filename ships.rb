require_relative 'roster'
require 'sqlite3'
db = SQLite3::Database.new("dfc_ships.db")

#clean up into module or class?
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

class Ship

	def initialize(faction_roster, roster_index)
		@name = faction_roster[roster_index][0]
		@scan = faction_roster[roster_index][1]
		@signature = faction_roster[roster_index][2]
		@thrust = faction_roster[roster_index][3]
		@hull = faction_roster[roster_index][4]
		@armor = faction_roster[roster_index][5]
		@point_defense = faction_roster[roster_index][6]
		@group_size = faction_roster[roster_index][7]
		@tonnage = faction_roster[roster_index][8]
		@special = faction_roster[roster_index][9]
		@points = faction_roster[roster_index][10]
		@db = SQLite3::Database.new("dfc_ships.db")
		save
	end

# Method to inject into database

	def save
		populate_ships = '
		INSERT INTO ships (name, scan, signature, thrust, hull, armor, point_defense, group_size, tonnage, special, points) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);'
			@db.execute(populate_ships, [@name, @scan, @signature, @thrust, @hull, @armor, @point_defense, @group_size, @tonnage, @special, @points])
	end


end

	def create_ships(faction_roster)
		created_ships = []
		faction_roster.each_with_index do |ship, index|
			created_ship = []
			created_ship << ship = Ship.new(faction_roster, index)
			created_ships << created_ship
		end
		created_ships
	end

ucm_ships = create_ships(Roster::UCM_ROSTER)

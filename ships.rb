require_relative 'roster'
require_relative 'tables'
require_relative 'groups'
require_relative 'battlegroups'
require 'sqlite3'

db = Tables::DB
Tables.tables(db) #move to driver code I think

class Ship

	def initialize(faction_roster, roster_index, db)
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
		@db = db
		save
	end

# Method to inject into database

	def save
		populate_ships = '
		INSERT INTO ships (name, scan, signature, thrust, hull, armor, point_defense, group_sizes_id, tonnage, special, points) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);'
			@db.execute(populate_ships, [@name, @scan, @signature, @thrust, @hull, @armor, @point_defense, @group_size, @tonnage, @special, @points])
	end
end

# Move to driver code
	def create_ships(faction_roster, db)
		created_ships = []
		faction_roster.each_with_index do |ship, index|
			created_ship = []
			created_ship << ship = Ship.new(faction_roster, index, db)
			created_ships << created_ship
		end
		created_ships
	end

Tables.populate_group_sizes(db)
Tables.populate_battlegroup_types(db)

# Conditional on choosing UCM as faction
ucm_ships = create_ships(Roster::UCM_ROSTER, db)

# Conditional on creating/saving groups
group = Group.new("Beazlebub", "Tokyo", 1, db)
group.save_group(db)
group = Group.new("Red Squadron", "Toulon", 4, db)
group.save_group(db)
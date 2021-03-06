require_relative 'tables'

require 'sqlite3'

class Ship

	@@db = Tables::DB

	def initialize(roster, roster_index, db)
		@name = roster[roster_index][0]
		@scan = roster[roster_index][1]
		@signature = roster[roster_index][2]
		@thrust = roster[roster_index][3]
		@hull = roster[roster_index][4]
		@armor = roster[roster_index][5]
		@point_defense = roster[roster_index][6]
		@group_size = roster[roster_index][7]
		@tonnage = roster[roster_index][8]
		@special = roster[roster_index][9]
		@points = roster[roster_index][10]
		@faction = roster[roster_index][11]
		@db = db
		save
	end

# ==  CLASS METHODS ==

	def self.display_faction_ships(faction)
		display_ships ='
		SELECT name, scan, signature, thrust, hull, armor, point_defense, group_size, tonnage, special, points FROM ships
		JOIN group_sizes ON 
		ships.group_sizes_id = group_sizes.id
		WHERE faction = ?'
		@@db.execute(display_ships, [faction])
	end

	def self.display_by_tonnage(faction, tonnage)
		display_ships ='
		SELECT name, group_size FROM ships
		JOIN group_sizes ON 
		ships.group_sizes_id = group_sizes.id
		WHERE faction = ? AND tonnage = ?'
		@@db.execute(display_ships, [faction, tonnage])
	end

	def self.display_ship_stats(ship_name)
		display_ship = 'SELECT name, scan, signature, thrust, hull, armor, point_defense, group_size, tonnage, special, points FROM ships
		JOIN group_sizes ON 
		ships.group_sizes_id = group_sizes.id
		WHERE name = ?'
		ship = @@db.execute(display_ship, [ship_name])[0]
	end

# == INSTANCE METHODS ==

# Method to inject into database
	def save
		populate_ships = '
		INSERT INTO ships (name, scan, signature, thrust, hull, armor, point_defense, group_sizes_id, tonnage, special, points, faction) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);' 
			@db.execute(populate_ships, [@name, @scan, @signature, @thrust, @hull, @armor, @point_defense, @group_size, @tonnage, @special, @points, @faction])
	end
end
#if @db.execute('SELECT COUNT (*) FROM ships')[0][0] == 0	<- REMOVED FROM save FUNCTION
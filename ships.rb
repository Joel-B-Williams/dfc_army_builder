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


# == DISPLAY METHODS ==

	def self.display_faction_ships(faction)
		display_ships ='
		SELECT ships.name, ships.scan, ships.signature, ships.thrust, ships.hull, ships.armor, ships.point_defense, group_sizes.group_size, ships.tonnage, ships.special, ships.points FROM ships
		JOIN group_sizes ON 
		ships.group_sizes_id = group_sizes.id
		WHERE faction = ?'
		@@db.execute(display_ships, [faction])
	end

# Method to inject into database

	def save
		populate_ships = '
		INSERT INTO ships (name, scan, signature, thrust, hull, armor, point_defense, group_sizes_id, tonnage, special, points, faction) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);' 
			@db.execute(populate_ships, [@name, @scan, @signature, @thrust, @hull, @armor, @point_defense, @group_size, @tonnage, @special, @points, @faction])
	end
end
#if @db.execute('SELECT COUNT (*) FROM ships')[0][0] == 0	<- REMOVED FROM save FUNCTION
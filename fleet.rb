require_relative 'tables'
require 'sqlite3'

class Fleet

	@@db = Tables::DB
	
	def initialize(name, faction, points_limit, db)
		@name = name
		@faction = faction
		@points_limit = points_limit
		@db = db
		#push bg id into string, store in db, push to array later?
		@battlegroups = ""
	end


# === DISPLAY METHODS ===

# Overview of all saved battlegroups
	def self.overview_display
		overview = 'SELECT name, faction, points_limit FROM fleets ORDER BY faction'
		@@db.execute(overview)
	end

# === ADD BATTLEGROUP TO FLEET ===

# Select battlegroup by ID 
	def find_battlegroup_id(battlegroup_name)
		find_battlegroup_id = 'SELECT id FROM battlegroups WHERE name = ?'
		id = @db.execute(find_battlegroup_id, [battlegroup_name])
	end	

# Add ID to @battlegroups (plus character break)
	def add_battlegroup(id)
		@battlegroups += "#{id}."
	end

# === SAVE FLEET TO FLEET TABLE ===

	def save_fleet
		save = 'INSERT INTO fleets (name, faction, points_limit, battlegroups) VALUES (?,?,?,?)'
		@db.execute(save_fleet, [@name, @faction, @points_limit, @battlegroups])
	end

end
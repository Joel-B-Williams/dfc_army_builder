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


# === CLASS METHODS ===

# Overview of all saved battlegroups by faction
	def self.overview_display(faction)
		overview = 'SELECT name, points_limit FROM fleets WHERE faction = ?'
		@@db.execute(overview, [faction])
	end

#Convert @battlegroups string into array of battlegroup id's
#-------- change to instance-method and call on initialize?????
	def self.convert_bg_ids(battlegroups)
		bg_arr = []
		bg_nums = battlegroups.split(".")
		bg_nums.each {|bg_id| bg_arr.push(bg_id.to_i)}
		bg_nums
	end

#Delete fleet from fleets table 
def self.delete_fleet(fleet_name)
	delete_fleet = 'DELETE FROM fleets WHERE name = ?'
	@@db.execute(delete_fleet, [fleet_name])
end

# === INSTANCE METHODS === 

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
		save_fleet = 'INSERT INTO fleets (name, faction, points_limit) VALUES (?,?,?)'
		@db.execute(save_fleet, [@name, @faction, @points_limit])
	end

end
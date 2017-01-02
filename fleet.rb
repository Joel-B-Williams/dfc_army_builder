require_relative 'tables'
require 'sqlite3'

class Fleet
	
	attr_accessor :battlegroups

	@@db = Tables::DB
	
	def initialize(name, faction, points_limit, db)
		@name = name
		@faction = faction
		@points_limit = points_limit
		@db = db
		@current_points = 0
		#push bg id into string, store in db, push to array later?
		@battlegroups = ""
	end


# === CLASS METHODS ===

# Overview of all saved battlegroups by faction
	def self.overview_display(faction)
		overview = 'SELECT name, points_limit, current_points FROM fleets WHERE faction = ?'
		@@db.execute(overview, [faction])
	end

# Find points limit value of fleet by name
	def self.find_fleet_points(fleet_name)
		find_points = 'SELECT points_limit FROM fleets WHERE name = ?'
		points = @@db.execute(find_points, [fleet_name])[0][0]	
	end

# Find current points value of fleet by name
	def self.find_current_points(fleet_name)
		find_points = 'SELECT current_points FROM fleets WHERE name = ?'
		points = @@db.execute(find_points, [fleet_name])
	end

# === ADD/DELETE BATTLEGROUP TO FLEET ===

#Pull battlegroups from fleet table
	def self.retreive_battlegroups(fleet_name)
		retreive_battlegroups = 'SELECT battlegroups FROM fleets WHERE name = ?'
		#initially nil, can't be pulled.  Start "none" bg?
		bg_string = @@db.execute(retreive_battlegroups, [fleet_name])[0][0]
	end

#Convert @battlegroups string into array of battlegroup id's
	def self.convert_bg_ids(battlegroup_string)
		bg_arr = []
		bg_nums = battlegroup_string.split(".")
		bg_nums.each {|bg_id| bg_arr.push(bg_id.to_i)}
		bg_arr
	end

#Add battlegroup id to array 
	def self.add_bg_id(battlegroup_string, new_id)
		current_bg = self.convert_bg_ids(battlegroup_string)
		current_bg << new_id
	end

#Delete id from array
	def self.remove_bg_id(battlegroup_array, id)
		battlegroup_array.each_with_index do |bg_id, index|
			if bg_id == id
				battlegroup_array.delete_at(index)
				break
			end
		end
		battlegroup_array
	end

#Convert array to string 
	def self.bg_to_s(battlegroup_array)
		bg_string = ""
		battlegroup_array.each {|bg| bg_string += "#{bg}."}
		bg_string
	end

#Insert battlegroup string into fleets table
	def self.update_battlegroups(fleet_name, battlegroup_string)
		new_bgs = 'UPDATE fleets SET battlegroups = ? WHERE name = ?'
		@@db.execute(new_bgs, [battlegroup_string, fleet_name])
	end

# === ADD/SUBTRACT CURRENT POINTS TOTAL OF FLEET ===

#Find current points by fleet name
	def self.find_current_points(fleet_name)
		find_points = 'SELECT current_points FROM fleets WHERE name = ?'
		current_points = @@db.execute(find_points, [fleet_name])[0][0]
	end

#Add bg_points to current points
	def self.add_bg_points(fleet_name, bg_name)
		cp = self.find_current_points(fleet_name)
		cp += Battlegroup.find_bg_points(bg_name)
	end

#Subtract bg_points from current points
	def self.subtract_bg_points(fleet_name, bg_name)
		cp = self.find_current_points(fleet_name)
		cp -= Battlegroup.find_bg_points(bg_name)
	end

#Insert new current points value into fleets table by fleet name
	def self.update_current_points(fleet_name, points)
		update_points = 'UPDATE fleets SET current_points = ? WHERE name = ?'
		@@db.execute(update_points, [points, fleet_name])
	end

# === DISPLAY BATTLEGROUPS IN FLEET ===

#Convert bg_id string into an array
	def self.find_fleet_bgs(fleet)
	bg_names = Fleet.convert_bg_ids(retreive_battlegroups(fleet)).map {|bg_id|
			Battlegroup.find_bg_name(bg_id)}
	end

#Find bg_name from id and display by name
	def self.display_fleet_bgs(bg_names)
		display = bg_names.map {|bg_name| Battlegroup.display_by_name(bg_name)}
	end


#Delete fleet from fleets table 
def self.delete_fleet(fleet_name)
	delete_fleet = 'DELETE FROM fleets WHERE name = ?'
	@@db.execute(delete_fleet, [fleet_name])
end

# === INSTANCE METHODS === 


# === SAVE FLEET TO FLEET TABLE ===

	def save_fleet
		save_fleet = 'INSERT INTO fleets (name, faction, points_limit, battlegroups, current_points) VALUES (?,?,?,"1.", 0)'
		@db.execute(save_fleet, [@name, @faction, @points_limit])
	end

end
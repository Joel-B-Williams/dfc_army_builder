require_relative 'tables'
require 'sqlite3'

class Group

	def initialize(name, ship_type, number, db)
		@name = name
		@ship_type = ship_type #needs to correlate to ship id in table
		@number = number
		@points = 0
		@db = db
	end
 

 # == NOTE - change requiring group name to searching for ID instead?  
# == FIND AND ADD ID OF SHIP TO GROUPS TABLE ==

  	#Find id of ship from ships table
 	def find_ship_id
		find_ship_id = 'SELECT id FROM ships WHERE name = ?'
		id = @db.execute(find_ship_id, [@ship_type])[0][0]
 	end

 	#Update groups table to include id of ship
 	def set_id
		set_id = 'UPDATE groups SET ship_id = ? WHERE name = ?'
		@db.execute(set_id, [find_ship_id(db), @name])
 	end

# == CALCULATE AND ADD POINTS TO GROUPS TABLE ==

 	#Find points value of single ship from ships table
 	def find_points
 		find_points = 'SELECT points FROM ships WHERE id = ?'
 		points = @db.execute(find_points, [find_ship_id(db)])[0][0]
 	end

 	#Find number of ships in group from groups table
 	def find_number
 		find_number = 'SELECT number FROM groups WHERE name = ?'
 		number = @db.execute(find_number, [@name])[0][0]
 	end

 	#Calculate points cost of group using ship cost * number of ships
 	def calc_points
 		points = ( find_points * find_number )
 	end

 	#Update groups table to include total points cost
 	def set_points
 		set_points = 'UPDATE groups SET points = ? WHERE name = ?'
 		@db.execute(set_points, [calc_points, @name]) 
 	end

# == SAVE GROUP TO GROUPS TABLE ==

 	#Initially save name/number to groups table, then call other necessary functions
	def save_group
		save = 'INSERT INTO groups (name, number) VALUES (?,?)'
		@db.execute(save, [@name, @number])
		set_id
		set_points
	end
end


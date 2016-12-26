require_relative 'tables'
require 'sqlite3'

#class methods -> self.method_name, called by Class.method_name, deal with all instances of class
class Battlegroup

	def initialize(name, type, group1_name, group2_name, group3_name, db)
		@name = name
		@type = type
		@group1_name = group1_name
		@group2_name = group2_name
		@group3_name = group3_name
		@points = 0
		@db = db
	end

# == FIND AND ADD ID OF GROUP TO BATTLEGROUPS TABLE ==
	
	#Find id of group from groups table
	def find_group_id(group_name)
		find_group_id = 'SELECT id FROM groups WHERE name = ?'
		id = @db.execute(find_group_id, [group_name])[0][0]
	end

	#Update battlegroups table to include id of group1
	def set_id_group1
		set_id = 'UPDATE battlegroups SET group1_id = ? WHERE name = ?'
		@db.execute(set_id, [find_group_id(@group1_name, db), @name]) if @group1_name != nil
	end

	#Update battlegroups table to include id of group2
	def set_id_group2
		set_id = 'UPDATE battlegroups SET group2_id = ? WHERE name = ?'
		@db.execute(set_id, [find_group_id(@group2_name, db), @name]) if @group2_name != nil
	end	

	#Update battlegroups table to include id of group3
	def set_id_group3
		set_id = 'UPDATE battlegroups SET group3_id = ? WHERE name = ?'
		@db.execute(set_id, [find_group_id(@group3_name, db), @name]) if @group3_name != nil
	end

# == CALCULATE AND ADD POINTS TO BATTLEGROUPS TABLE ==
	
	#Find points value of each group
	#Group1
	def find_points_group1
		find_points = 'SELECT points FROM groups WHERE id = ?'
		points = @db.execute(find_points, [find_group_id(@group1_name, db)])[0][0] if @group1_name != nil
	end 

	#Group2
	def find_points_group2
		find_points = 'SELECT points FROM groups WHERE id = ?'
		points = @db.execute(find_points, [find_group_id(@group2_name, db)])[0][0] if @group2_name != nil
	end 

	#Group3
	def find_points_group3
		find_points = 'SELECT points FROM groups WHERE id = ?'
		points = @db.execute(find_points, [find_group_id(@group3_name, db)])[0][0] if @group3_name != nil
	end 

	#Calculate points cost of battlegroup using sum of all group costs
	def calc_points
		points = ( find_points_group1 + find_points_group2 + find_points_group3 )
	end

	#Update battlegroups table to include total points cost
	def set_points
		set_points = 'UPDATE battlegroups SET points = ? WHERE name = ?'
		@db.execute(set_points, [calc_points(db), @name])
	end

# == SAVE BATTLEGROUP TO BATTLEGROUPS TABLE ==

	#Initially save name to battlegroups table, then call other necessary functions
	def save_battlegroup
		save = 'INSERT INTO battlegroups (name, type) VALUES (?, ?)'
		@db.execute(save, [@name, @type])
		set_id_group1
		set_id_group2
		set_id_group3
		set_points
	end
end
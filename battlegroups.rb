require_relative 'tables'
require 'sqlite3'

#class methods -> self.method_name, called by Class.method_name, deal with all instances of class
class Battlegroup

	@@db = Tables::DB

	def initialize(name, faction, type, group1_name, group2_name, group3_name, db)
		@name = name
		@faction = faction
		@type = type
		@group1_name = group1_name
		@group2_name = group2_name
		@group3_name = group3_name
		@points = 0
		@db = db
	end

# === CLASS METHODS ===

	def self.display_battlegroups(faction)
		display_battlegroups = 'SELECT battlegroups.name, battlegroup_types.name, g1.name, g2.name, g3.name,   battlegroups.points FROM battlegroups JOIN groups AS g1 ON battlegroups.group1_id = g1.id JOIN groups AS g2 ON battlegroups.group2_id = g2.id JOIN groups AS g3 ON battlegroups.group3_id = g3.id JOIN battlegroup_types ON battlegroups.type = battlegroup_types.id WHERE battlegroups.faction = ?'
		@@db.execute(display_battlegroups, [faction])
	end

#Delete battlegroup from table
	def self.delete_battlegroup(battlegroup_name)
		delete_battlegroup = 'DELETE FROM battlegroups WHERE name = ?'
		@@db.execute(delete_battlegroup, [battlegroup_name])
	end

# == UPDATE BATTLEGROUP ==

#Update battlegroup name
	def self.update_battlegroup(new_name, old_name)
		update_battlegroup = 'UPDATE battlegroups SET name = ? WHERE name = ?'
		@@db.execute(update_battlegroup, [new_name, old_name])
	end	

#Find group id from groups table
	def self.update_group_id(group_name)
		find_group_id = 'SELECT id FROM groups WHERE name = ?'
		id = @@db.execute(find_group_id, [group_name])[0][0] 
	end

#Update battlegroups table to include id of group1
	def self.update_id_group1(group_name, bg_name)
		update_id = 'UPDATE battlegroups SET group1_id = ? WHERE name = ?'
		@@db.execute(update_id, [self.update_group_id(group_name), bg_name])
	end

#Update battlegroups table to include id of group2
	def self.update_id_group2(group_name, bg_name)
		update_id = 'UPDATE battlegroups SET group2_id = ? WHERE name = ?'
		@@db.execute(update_id, [self.update_group_id(group_name), bg_name])
	end

#Update battlegroups table to include id of group3
def self.update_id_group3(group_name, bg_name)
	update_id = 'UPDATE battlegroups SET group3_id = ? WHERE name = ?'
	@@db.execute(update_id, [self.update_group_id(group_name), bg_name])
end

# == FIND AND CALCULATE NEW POINTS COST ==

	#Find new points cost of group 1 by name
	def self.find_points_group1(group_name)
		find_points = 'SELECT points FROM groups WHERE name = ?'
		points = @@db.execute(find_points, [group_name])[0][0]
	end

	#Find new points cost of group 2 by name
	def self.find_points_group2(group_name)
		find_points = 'SELECT points FROM groups WHERE name = ?'
		points = @@db.execute(find_points, [group_name])[0][0]
	end

	#Find new points cost of group 3 by name
	def self.find_points_group3(group_name)
		find_points = 'SELECT points FROM groups WHERE name = ?'
		points = @@db.execute(find_points, [group_name])[0][0]
	end

	#Calculate new points cost (by name)
	def self.calc_new_points(group1, group2, group3)
		points = ( self.find_points_group1(group1)+self.find_points_group2(group2)+self.find_points_group3(group3) )
	end

	#Update battlegroups table with new points cost (by name)
	def self.update_points(bg_name, group1, group2, group3)
		update_points = 'UPDATE battlegroups SET points = ? WHERE name = ?'
		@@db.execute(update_points, [self.calc_new_points(group1, group2, group3), bg_name])
	end
# === INSTANCE METHODS ===

	#Find id of group from groups table
	def find_group_id(group_name)
		find_group_id = 'SELECT id FROM groups WHERE name = ?'
		id = @db.execute(find_group_id, [group_name])[0][0]
	end

	#Update battlegroups table to include id of group1
	def set_id_group1
		set_id = 'UPDATE battlegroups SET group1_id = ? WHERE name = ?'
		@db.execute(set_id, [find_group_id(@group1_name), @name])
	end

	#Update battlegroups table to include id of group2
	def set_id_group2
		set_id = 'UPDATE battlegroups SET group2_id = ? WHERE name = ?'
		@db.execute(set_id, [find_group_id(@group2_name), @name])
	end	

	#Update battlegroups table to include id of group3
	def set_id_group3
		set_id = 'UPDATE battlegroups SET group3_id = ? WHERE name = ?'
		@db.execute(set_id, [find_group_id(@group3_name), @name])
	end

# == CALCULATE AND ADD POINTS TO BATTLEGROUPS TABLE ==
	
	#Find points value of each group
	#Group1
	def find_points_group1
		find_points = 'SELECT points FROM groups WHERE id = ?'
		points = @db.execute(find_points, [find_group_id(@group1_name)])[0][0] 
	end 

	#Group2
	def find_points_group2
		find_points = 'SELECT points FROM groups WHERE id = ?'
		points = @db.execute(find_points, [find_group_id(@group2_name)])[0][0]
	end

	#Group3
	def find_points_group3
		find_points = 'SELECT points FROM groups WHERE id = ?'
		points = @db.execute(find_points, [find_group_id(@group3_name)])[0][0]
	end 

	#Calculate points cost of battlegroup using sum of all group costs
	def calc_points
		points = ( find_points_group1 + find_points_group2 + find_points_group3 )
	end

	#Update battlegroups table to include total points cost
	def set_points
		set_points = 'UPDATE battlegroups SET points = ? WHERE name = ?'
		@db.execute(set_points, [calc_points, @name])
	end

# == SAVE BATTLEGROUP TO BATTLEGROUPS TABLE ==

	#Initially save name to battlegroups table, then call other necessary functions
	def save_battlegroup
		save = 'INSERT INTO battlegroups (name, faction, type) VALUES (?, ?, ?)'
		@db.execute(save, [@name, @faction, @type])
		set_id_group1
		set_id_group2
		set_id_group3
		set_points
	end
end
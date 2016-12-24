require_relative 'tables'
require 'sqlite3'

db = Tables::DB

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
	def find_group_id(group_name, db)
		find_group_id = 'SELECT id FROM groups WHERE name = ?'
		id = db.execute(find_group_id, [group_name])[0][0]
	end

	#Update battlegroups table to include id of group1
	def set_id_group1(db)
		set_id = 'UPDATE battlegroups SET group1_id = ? WHERE name = ?'
		db.execute(set_id, [find_group_id(@group1_name, db), @name]) if @group1_name != nil
	end

	#Update battlegroups table to include id of group2
	def set_id_group2(db)
		set_id = 'UPDATE battlegroups SET group2_id = ? WHERE name = ?'
		db.execute(set_id, [find_group_id(@group2_name, db), @name]) if @group2_name != nil
	end	

	#Update battlegroups table to include id of group3
	def set_id_group3(db)
		set_id = 'UPDATE battlegroups SET group3_id = ? WHERE name = ?'
		db.execute(set_id, [find_group_id(@group3_name, db), @name]) if @group3_name != nil
	end

# == SAVE BATTLEGROUP TO BATTLEGROUPS TABLE ==

	#Initially save name to battlegroups table, then call other necessary functions
	def save_battlegroup(db)
		save = 'INSERT INTO battlegroups (name, type) VALUES (?, ?)'
		db.execute(save, [@name, @type])
		set_id_group1(db)
		set_id_group2(db)
		set_id_group3(db)
	end
end
require_relative 'tables'
require 'sqlite3'

db = Tables::DB

class Battlegroup

	def initialize(name, type, group1, group2, group3, points, db)
		@name = name
		@type = type
		@group1 = group1
		@group2 = group2
		@group3 = group3
		@points = points
		@db = db
	end

end
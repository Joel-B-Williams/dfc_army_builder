require_relative 'tables'
require 'sqlite3'

db = Tables::DB

class Group

	def initialize(name, ship_type, number, points, db)
		@name = name
		@ship_type = ship_type #needs to correlate to ship id in table
		@number = number
		@points = points
		@db = db
	end

end
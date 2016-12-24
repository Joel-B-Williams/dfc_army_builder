require_relative 'tables'
require_relative 'roster'
require_relative 'ships'
require_relative 'groups'
require_relative 'battlegroups'

require 'sqlite3'
#require 'sinatra'

db = Tables::DB

Tables.tables(db)
Tables.populate_group_sizes(db)
Tables.populate_battlegroup_types(db)


# Move to driver code
	def create_ships(faction_roster, db)
		created_ships = []
		faction_roster.each_with_index do |ship, index|
			created_ship = []
			created_ship << ship = Ship.new(faction_roster, index, db)
			created_ships << created_ship
		end
		created_ships
	end


# Conditional on choosing UCM as faction
ucm_ships = create_ships(Roster::UCM_ROSTER, db)

# Conditional on creating/saving groups
group = Group.new("Beazlebub", "Tokyo", 1, db)
group.save_group(db)
group = Group.new("Red Squadron", "Toulon", 4, db)
group.save_group(db)

battlegroup = Battlegroup.new("Omega", "Vanguard", "Beazlebub", "Red Squadron", "Red Squadron", db)
battlegroup.save_battlegroup(db)
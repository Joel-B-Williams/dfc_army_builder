require_relative 'tables'
require_relative 'roster'
require_relative 'ships'
require_relative 'groups'
require_relative 'battlegroups'

require 'sqlite3'
require 'sinatra'

db = Tables::DB

Tables.tables(db)
Tables.populate_group_sizes(db)
Tables.populate_battlegroup_types(db)
Roster.create_ships(Roster::FULL_ROSTER, db) if db.execute('SELECT COUNT (*) FROM ships')[0][0] == 0
# CURRENTLY WILL ADD TO TABLE EVERY TIME PROGRAM RUNS

# # Conditional on choosing UCM as faction
# ucm_ships = create_ships(Roster::UCM_ROSTER, db) if 

# # Conditional on creating/saving groups
# group = Group.new("Beazlebub", "Tokyo", 1, db)
# group.save_group(db)
# group = Group.new("Red Squadron", "Toulon", 4, db)
# group.save_group(db)

# battlegroup = Battlegroup.new("Omega", "Vanguard", "Beazlebub", "Red Squadron", "Red Squadron", db)
# battlegroup.save_battlegroup(db)

get '/' do
	erb :home
end

get '/ships' do
	@faction = params[:faction]
	@db = Tables::DB #way to declare for all views?
	@fleet = db.execute('
		SELECT ships.name, ships.scan, ships.signature, ships.thrust, ships.hull, ships.armor, ships.point_defense, group_sizes.group_size, ships.tonnage, ships.special, ships.points FROM ships
		JOIN group_sizes ON 
		ships.group_sizes_id = group_sizes.id
		WHERE faction = ?', [@faction])
	erb :ships
end

# get '/ships' do
# end
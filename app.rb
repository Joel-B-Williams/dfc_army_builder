require_relative 'tables'
require_relative 'roster'
require_relative 'ships'
require_relative 'groups'
require_relative 'battlegroups'
require_relative 'fleet'

require 'sqlite3'
require 'sinatra'

db = Tables::DB

Tables.tables(db)
Tables.populate_group_sizes(db)
Tables.populate_battlegroup_types(db)
Roster.create_ships(Roster::FULL_ROSTER, db) if db.execute('SELECT COUNT (*) FROM ships')[0][0] == 0
Tables.default_group(db) if db.execute('SELECT COUNT (*) FROM groups')[0][0] == 0
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
enable :sessions

# Home View
get '/' do
	@fleets = Fleet.overview_display
	@faction = session[:faction]
	erb :home
end

# Faction Management Views
get '/faction/choose' do
	erb :choose_faction
end

post '/faction/store' do
	session[:faction] = params[:faction]
	redirect '/'
end

# Full Ship Roster - by faction
get '/ships' do
	faction = session[:faction]
	@fleet = Ship.display_faction_ships(faction)
	erb :ships
end

# Group Management Views
get '/groups/manage' do
	faction = session[:faction]
	@groups = Group.display_groups(faction)
	erb :manage_groups
end

post '/groups/create' do
	faction = session[:faction]
	tonnage = params[:tonnage]
	@category = Ship.display_by_tonnage(faction, tonnage)
	erb :create_group
end

post '/groups/add' do
	group_name = params[:group_name]
	faction = session[:faction]
	ship_name = params[:ship_name]
	group_size = params[:group_size]
	group = Group.new(group_name, faction, ship_name, group_size, db)
	group.save_group
	redirect '/groups/manage'
end

post '/groups/update' do
	session[:group_name] = params[:group_name]
	@current_name = session[:group_name]
	@ship_name = params[:ship_name]
	erb :update_groups
end

post '/groups/update/table' do
	old_name = session[:group_name]
	new_name = params[:new_group_name]
	ship_name	= params[:ship_name]
	group_size = params[:group_size]
	Group.update_group(new_name, group_size, old_name)
	Group.update_id(new_name, ship_name)
	Group.update_points(ship_name, new_name)
	redirect '/groups/manage'
end

post '/groups/delete' do
	group_name = params[:group_name]
	Group.delete_group(group_name)
	redirect '/groups/manage'
end

# Battlegroup Management Views
get '/battlegroups/manage' do
	faction = session[:faction]
	@battlegroups = Battlegroup.display_battlegroups(faction)
	erb :manage_battlegroups
end

post '/battlegroups/create' do
	faction = session[:faction]
	session[:bg_type] = params[:bg_type]
	@groups = Group.display_by_name(faction)
	erb :create_battlegroup
end


post '/battlegroups/add' do
	bg_name = params[:bg_name]
	bg_type = session[:bg_type].to_i
	faction = session[:faction]
	group1 = params[:group1]
	group2 = params[:group2]
	group3 = params[:group3]
	battlegroup = Battlegroup.new(bg_name, faction, bg_type, group1, group2, group3, db)
	battlegroup.save_battlegroup
	redirect '/battlegroups/manage'
end

post '/battlegroups/update' do

end

post 'battlegroups/delete' do
	bg_name = params[:bg_name]
	Battlegroup.delete_battlegroup(bg_name)
	redirect '/battlegroups/manage'
end

# Fleet Management Views
get '/fleets/manage' do
	erb :manage_fleets
end


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
Tables.default_battlegroup(db) if db.execute('SELECT COUNT (*) FROM battlegroups')[0][0] == 0

enable :sessions

# Home View
get '/' do
	faction = session[:faction]
	@fleets = Fleet.overview_display(faction)
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
	@old_name = session[:group_name]
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
	bg_type = session[:bg_type]
	faction = session[:faction]
	group1 = params[:group1]
	group2 = params[:group2]
	group3 = params[:group3]
	battlegroup = Battlegroup.new(bg_name, faction, bg_type, group1, group2, group3, db)
	battlegroup.save_battlegroup
	redirect '/battlegroups/manage'
end

post '/battlegroups/update' do
	faction = session[:faction]
	session[:bg_name] = params[:bg_name]
	@old_name = session[:bg_name]
	@bg_type = params[:bg_type]
	@group1 = params[:group1]
	@group2 = params[:group2]
	@group3 = params[:group3]
	@groups = Group.display_by_name(faction)
	erb :update_battlegroups
end

post '/battlegroups/update/table' do
	old_name = session[:bg_name]
	new_name = params[:bg_name]
	group1 = params[:group1]
	group2 = params[:group2]
	group3 = params[:group3]
	Battlegroup.update_battlegroup(new_name, old_name)
	Battlegroup.update_id_group1(group1, new_name)
	Battlegroup.update_id_group2(group2, new_name)
	Battlegroup.update_id_group3(group3, new_name)
	Battlegroup.update_points(new_name, group1, group2, group3)
	redirect '/battlegroups/manage'
end

post '/battlegroups/sync' do
	faction = session[:faction]
	battlegroups = Battlegroup.display_battlegroups(faction)
	Battlegroup.sync_battlegroups(battlegroups)
	redirect 'battlegroups/manage'
end

post '/battlegroups/delete' do
	bg_name = params[:bg_name]
	Battlegroup.delete_battlegroup(bg_name)
	redirect '/battlegroups/manage'
end

# Fleet Management Views

post '/fleets/add' do
	fleet_name = params[:fleet_name]
	faction = session[:faction]
	points_limit = params[:points_limit]
	fleet = Fleet.new(fleet_name, faction, points_limit, db)
	fleet.save_fleet
	redirect '/'
end

post '/fleets/add/battlegroup' do
	fleet_name = params[:fleet_name]
	bg_name = params[:bg_name]
	#bg_points = params[:]??? add to calc points as you go??
	#Gross... break down & use variables for readability?
	new_bg_id_arr = Fleet.add_bg_id(Fleet.retreive_battlegroups(fleet_name), Battlegroup.find_bg_id(bg_name))
	new_bg_str = Fleet.bg_to_s(new_bg_id_arr)
	Fleet.update_battlegroups(fleet_name, new_bg_str)
	redirect '/fleets/overview'
end

get '/fleets/overview' do
	faction = session[:faction]
	@fleet_name = session[:fleet_name]
	@fleet_points = Fleet.find_fleet_points(@fleet_name)
	@fleets = Fleet.overview_display(faction)
	@battlegroups = Battlegroup.display_battlegroups(faction)
	@fleet_bgs = Fleet.display_fleet_bgs(Fleet.find_fleet_bgs(@fleet_name))
	erb :view_fleets
end

post '/fleets/overview' do
	faction = session[:faction]
	session[:fleet_name] = params[:fleet_name]
	@fleet_name = session[:fleet_name]
	@fleet_points = Fleet.find_fleet_points(@fleet_name)
	@fleets = Fleet.overview_display(faction)
	@battlegroups = Battlegroup.display_battlegroups(faction)
	@fleet_bgs = Fleet.display_fleet_bgs(Fleet.find_fleet_bgs(@fleet_name))
	erb :view_fleets
end

post '/fleets/delete/battlegroup' do
	fleet_name = session[:fleet_name]
	bg_name = params[:bg_name]
	#refactor with variables
	new_arr = Fleet.remove_bg_id(Fleet.convert_bg_ids(Fleet.retreive_battlegroups(fleet_name)), Battlegroup.find_bg_id(bg_name))
	new_str = Fleet.bg_to_s(new_arr)
	Fleet.update_battlegroups(fleet_name, new_str)
	redirect '/fleets/overview'
end

post '/fleets/delete' do
	fleet_name = params[:fleet_name]
	Fleet.delete_fleet(fleet_name)
	redirect '/'
end

#------------------------------------#

# post '/test' do
# 	fleet_name = session[:fleet_name]
# 	bg_name = params[:bg_name]
# 	@new_arr = Fleet.remove_bg_id(Fleet.convert_bg_ids(Fleet.retreive_battlegroups(fleet_name)), Battlegroup.find_bg_id(bg_name))
# 	@new_str = Fleet.bg_to_s(@new_arr)
# 	erb :test
# end
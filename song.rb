
require "erb"

configure do
	enable :sessions
	set :username, 'frank'
	set :password, 'sinatra'	
end






get '/login' do
	erb :login
end

post '/login' do
	if params[:username] == settings.username && params[:password] == settings.password
		session[:admin] = true
		redirect to('/songs')
	else
		erb :login
	end
end

get '/logout' do
	session.clear
	redirect to('/login')
end

get '/songs' do
	@songs = Song.all
	erb :songs
end

get '/songs/new' do
	halt(401, 'Not Authorized') unless session[:admin]
	@song = Song.new
	erb :new_song
end

get '/songs/:id' do
	@song = Song.get(params[:id])
	erb :show_song
end

post '/songs' do
	halt(401, 'Not Authorized') unless session[:admin]
	song = Song.create(params[:song])
	redirect to('/songs/<%= song.id %>')
end

get '/songs/:id/edit' do
	@song = Song.get(params[:id])
	erb :edit_song
end

put '/songs/:id' do
	halt(401, 'Not Authorized') unless session[:admin]
	song = Song.get(params[:id])
	song.update(params[:song])
	redirect to("/songs/<%= song.id %>")
end

delete '/songs/:id' do
	halt(401, 'Not Authorized') unless session[:admin]
	Song.get(params[:id]).destroy
	redirect to('/songs')
end
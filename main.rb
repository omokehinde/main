require 'sinatra'
require "./song"

configure :development do
	DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

configure :production do
	DataMapper.setup(:default, ENV['DATABASE_URL'])
end

get '/'do
	erb :home
end

get '/about'  do
	@title = "All About This Website"
	erb :about
end

get '/contact' do
	@title = "Omokehinde"
	erb :contact
end

not_found do
	erb :not_found
end
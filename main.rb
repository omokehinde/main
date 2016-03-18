require 'sinatra'
require "./song"
require "dm-core"


configure :development do
	DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

configure :production do
	DataMapper::setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
end

class Song
	include DataMapper::Resource
	property :id, Serial
	property :title, String
	property :lyrics, Text
	property :length, Integer
	property :released_on, Date

# 	date = released_on
# 	def released_on
# 		super Date.strptime(date, '%m/%d/%Y')
# 	end

end

DataMapper.finalize



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
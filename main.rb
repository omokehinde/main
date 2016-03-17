require 'sinatra'
require "./song"



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
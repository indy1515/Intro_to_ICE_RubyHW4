# app.rb
require 'sinatra'
require 'timezone'
require 'open-uri'
require 'json'




get '/' do
	erb :form
end


post '/' do

	url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{params[:message]}&key=AIzaSyBQlFAz5Rvi7vpLTYlc1IF_RIzv_OHuJd0";
	content = open(url).read
	obj = JSON.parse(content)
	location = obj["results"][0]["geometry"]["location"]
	lat = location["lat"]
	lng = location["lng"]
	"Lat: #{lat} Lng: #{lng}"
	Timezone::Configure.begin do |c|
  		c.username = 'indyza'
	end
	timezone = Timezone::Zone.new :latlon => [lat, lng]
	time = timezone.time Time.new 
	time = time.strftime("%I:%M %p")

	erb :current_time, :locals => {:time => time,:message => params[:message]}
	# "The current time in #{params[:message]} is : #{timeS}"
end






# https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=API_KEY


# timezone.zone
# => "America/Los_Angeles"
# timezone.time Time.now
# => 2011-12-01 14:02:13 UTC


# class HelloWorldApp < Sinatra::Base
#   get '/' do
#     "Hello, world!"
#   end
# end
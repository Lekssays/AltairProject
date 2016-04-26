#!usr/bin/ruby
# Made With <3

require 'open-uri'
require 'uri'
require 'json'
require 'pp'
include Math

# Get Input
inLAT = gets.chomp
inLNG = gets.chomp

# Flights in a raduis of 5 Miles
LATFinalM = (inLAT.to_f - 0.0727)
LATFinalP = (inLAT.to_f + 0.0727)
LNGFinalM = (inLNG.to_f - 0.0727)
LNGFinalP = (inLNG.to_f + 0.0727)

#Feed
FeedURL = "http://bma.data.fr24.com/zones/fcgi/feed.json?array=1&bounds=" + LATFinalP.round(4).to_s + "," + LATFinalM.round(4).to_s + ","  + LNGFinalM.round(4).to_s + ","  + LNGFinalP.round(4).to_s 
feedSrc = open(FeedURL).read

#Weather URL
WeatherURL = "http://api.apixu.com/v1/current.json?key=8fdb3e76a592483a86d164951162304&q=" + inLAT + "," + inLNG
WeatherSrc = open(WeatherURL).read

# Wind Speed
SWindSpeed = "\"wind_kph\":"
EWindSpeed = ","
WindSpeed = WeatherSrc[/#{SWindSpeed}(.*?)#{EWindSpeed}/m, 1]

# Wind Degree
SWindDeg = "\"wind_degree\":"
EWindDeg = ","
WindDeg = WeatherSrc[/#{SWindDeg}(.*?)#{EWindDeg}/m, 1]

# Wind Direction
SWindDir = "\"wind_dir\":"
EWindDir = ","
WindDir = WeatherSrc[/#{SWindDir}(.*?)#{EWindDir}/m, 1]

# Temperature
STemp = "\"temp_c\":"
ETemp = ","
Temp = WeatherSrc[/#{STemp}(.*?)#{ETemp}/m, 1]

# Pressure
SPressure = "\"pressure_mb\":"
EPressure = ","
Pressure = WeatherSrc[/#{SPressure}(.*?)#{EPressure}/m, 1]

# Humidity
SHumidity = "\"humidity\":"
EHumidity = ","
Humidity = WeatherSrc[/#{SHumidity}(.*?)#{EHumidity}/m, 1]

# Clouds
SCloud = "\"cloud\":"
ECloud = ","
Cloud = WeatherSrc[/#{SCloud}(.*?)#{ECloud}/m, 1]

# Create json File
fJson = File.open("Altair.json","w")
all = feedSrc.split('[[')[1]
record = all.split('[')

record.each do |value|
	lat = value.split(',')[2]
	lng = value.split(',')[3]
	theta = value.split(',')[4]
	height = value.split(',')[5]
	height_f = height.to_f * 0.3048
	speed = value.split(',')[6]
	speed_f = speed.to_f * 1.852
	
	tempHash = {
		"lat" => lat,
		"lng" => lng,
		"x" => ((lat.to_f - inLAT.to_f) * 111.045).round(4), 
		"y" => ((lng.to_f - inLNG.to_f) * 111.045).round(4),
		"theta" => theta,
		"height" => height_f.round(2).to_s, 
		"speed" => speed_f.round(2).to_s, 
		"temperature" => Temp,  
		"pressure" => Pressure, 
		"WindDir" => WindDir,
		"WindDeg" => WindDeg,
		"WindSpeed" => WindSpeed,
		"humidity" => Humidity,
		"cloud" => Cloud
	}
	fJson.write(tempHash)
	fJson.write("\n")
end

fJson.close    

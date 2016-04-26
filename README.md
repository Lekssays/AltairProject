# Altair Project
An Open-Source API for Intelligent Drone Driving.

# What is Altair Project?
It is an API for drone owners. You can set a limitations file ( e.g. limit weather conditions to stop flying) and based on the data that it gets from the API, it can make real-time decision (e.g. stop flying, return back...). It gets the data from flightradar24 for the flight traffic and from apixu for the weather conditions in the flying zone of the drone, and restricted areas (no-fly zones) from the public US governement database.

# Requirements :
1. Raspberry Pi or any device that can execute a ruby script
2. GPS sensor linked to the drone
3. Internet access for the drone

# How it works?
It gets Latitude/Longitude from a GPS sensor of the drone. It is prefferable to make a file named Inline `position.in` to store real-time position of the drone. Overrite it in every unit of time (to be set by the drone owner)
You will configure your drone to execute the script in every unit of time (to be set by the drone owner), and it will get real-time data about its flying zone ( a radius of 5 miles from the drone).
+ Execution: `ruby Altair.rb < position.in`
+ It generates a JSON file containing a list flights in a raduis of 5 miles. For each flight the API the following:
+ Latitude
+ Longitude
+ Angle Theta (Track in Degrees)
+ Current speed in km/h
+ Height in meters
+ X / Y Coordinates for rendering the terrain in 3D (To be done)
+ Wind speed in mph
+ Wind direction (e.g. 10° North)
+ Temperature in °C
+ Air pressure in mp
+ e.g. : 
+ `{"lat"=>"48.7108", "lng"=>"2.2887", "x"=>-2.1765, "y"=>-7.2512, "theta"=>"242", "height"=>"800.1", "speed"=>"0.0", "temperature"=>"7.0", "pressure"=>"1007.0", "WindDir"=>"\"WNW\"", "WindDeg"=>"303", "WindSpeed"=>"0.0", "humidity"=>"70", "cloud"=>"0"}`

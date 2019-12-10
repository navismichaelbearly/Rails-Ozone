class HomeController < ApplicationController
  def index
  	require 'net/http'
  	require 'json'
  	@url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=89129&distance=0&API_KEY=191290CA-9661-48F1-8A0C-17B9FBEFB4B8'
  	#@url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=12345&distance=0&API_KEY=191290CA-9661-48F1-8A0C-17B9FBEFB4B8'
  	@uri = URI(@url)
  	@response = Net::HTTP.get(@uri)
  	@output = JSON.parse(@response)

  	if @output.empty?
  		@final_output = "Error"
  	elsif !@output
  		@final_output = "Error"
  	else
  		@final_output = @output[0]['AQI']
  	end

  	if @final_output == "Error"
  		@api_color = "gray"
  		@api_description = "Unable to find the air quality"
  	elsif @final_output <= 50
  		@api_color = "green"
  		@api_description = "Air quality is very good"
  	elsif @final_ouptut >= 51 && @final_output <= 100
  		@api_color ="yellow"
  		@api_description = "Air quality is OK"
	else
  		@api_color ="yellow"
  		@api_description = "Air quality is not bad"
  	end
  end

  def zipcode
  	@zip_query = params[:zipcode]
  	if params[:zipcode] == ""
  		@zip_query = "Hey you forget to put something"
  	elsif params[:zipcode]
  		require 'net/http'
	  	require 'json'
	  	@url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode='+ @zip_query.to_s + '&distance=0&API_KEY=191290CA-9661-48F1-8A0C-17B9FBEFB4B8'
	  	#@url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=12345&distance=0&API_KEY=191290CA-9661-48F1-8A0C-17B9FBEFB4B8'
	  	@uri = URI(@url)
	  	@response = Net::HTTP.get(@uri)
	  	@output = JSON.parse(@response)

	  	if @output.empty?
	  		@final_output = "Error"
	  	elsif !@output
	  		@final_output = "Error"
	  	else
	  		@final_output = @output[0]['AQI']
	  	end

	  	if @final_output == "Error"
	  		@api_color = "gray"
	  		@api_description = "Unable to find the air quality"
	  	elsif @final_output <= 50
	  		@api_color = "green"
	  		@api_description = "Air quality is very good"
	  	elsif @final_output >= 51 && @final_output <= 100
	  		@api_color ="yellow"
	  		@api_description = "Air quality is OK"
		else
	  		@api_color ="yellow"
	  		@api_description = "Air quality is not bad"
	  	end
  	end

  end
end

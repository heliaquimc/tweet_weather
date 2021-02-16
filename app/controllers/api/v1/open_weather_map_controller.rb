require 'openweathermap'

class Api::V1::OpenWeatherMapController < ApplicationController
    def initialize(token, city, country)
        @client = OpenWeatherMap::API.new(token, 'pt', 'metric')
        @location = city + ',' + country
    end
    
    def get_weather
        current = current_weather_api
        forecast = forecast_weather_api

        conditions = current.weather_conditions
        text = "#{conditions.temperature}°C e #{conditions.description} em #{current.city.name} em #{conditions.time.strftime("%d/%m")}. "
        
        date_weather = forecast.forecast.group_by { |x| x.time.strftime("%d/%m")}
            .map { |date, weather_info|
                {
                    :date => date, 
                    :weather => weather_info.map(&:temperature).map(&:to_f).reduce(:+)/weather_info.size
                }
            }

        text += "Média para os próximos dias: "
        
        date_weather.each_with_index do |dw, index|
            next if dw[:date] == Time.now.strftime("%d/%m")

            average = format('%<num>0.2f', num: dw[:weather])

            text += case index
                when date_weather.size - 2
                    "#{average}°C em #{dw[:date]} e "
                when date_weather.size - 1
                    "#{average}°C em #{dw[:date]}"
                else 
                    "#{average}°C em #{dw[:date]}, "
            end
        end

        text
    end

    private

        def current_weather_api
            @client.current(@location)
        end

        def forecast_weather_api
            @client.forecast(@location)
        end
end

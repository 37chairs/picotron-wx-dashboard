require 'json'
require 'httparty'
require 'bigdecimal'
require 'pp'

# source .env && bundle exec ruby host_wx_service.rb
module RubyPicoBridge
  class WX
    def initialize
      @wx_data = {}
    end

    def fetch_wx_data
      api_key = ENV['API_KEY']
      latitude = BigDecimal('40.8195141')
      longitude = BigDecimal('-96.7243515')

      url = "https://api.pirateweather.net/forecast/#{api_key}/#{latitude},#{longitude}?exclude=minutely,hourly&units=us"
      response = HTTParty.get(url)

      @wx_data = {
        latitude: response['latitude'],
        longitude: response['longitude'],
        timezone: response['timezone'],
        elevation: response['elevation'],
        time_hour: Time.at(response['currently']['time']).hour,
        time_minute: Time.at(response['currently']['time']).min,
        time_second: Time.at(response['currently']['time']).sec,
        currently: {
          summary: response['currently']['summary'],
          icon: response['currently']['icon'],
          precip_probability: response['currently']['precipProbability'],
          temperature: response['currently']['temperature'],
          feels_like: response['currently']['apparentTemperature'],
          dew_point: response['currently']['dewPoint'],
          humidity: response['currently']['humidity'],
          pressure: response['currently']['pressure'],
          wind_speed: response['currently']['windSpeed'],
          wind_gust: response['currently']['windGust'],
          wind_bearing: response['currently']['windBearing'],
          cloud_cover: response['currently']['cloudCover'],
          uv_index: response['currently']['uvIndex'],
          visibility: response['currently']['visibility']
        },
        daily: []
      }

      days_of_week = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]

      response['daily']['data'].each do |day|
        @wx_data[:daily] << {
          day_of_week: days_of_week[Time.at(day['time']).wday],
          icon: day['icon'],
          summary: day['summary'],
          sunrise_hour: Time.at(day['sunriseTime']).hour,
          sunrise_minute: Time.at(day['sunriseTime']).min,
          precip_probability: day['precipProbability'],
          precip_accumulation: day['precipAccumulation'],
          precip_type: day['precipType'],
          temperature_high: day['temperatureHigh'],
          temperature_low: day['temperatureLow'],
          wind_speed: day['windSpeed'],
          wind_gust: day['windGust'],
          wind_bearing: day['windBearing'],
          cloud_cover: day['cloudCover']
        }
      end
    end

    def store_pod_data
      # for now, we'll also write to json to sanity check our data format & for debugging.
      json_file = File.expand_path('~/Library/Application Support/Picotron/drive/appdata/wx.json')
      File.open(json_file, 'w') do |data_file|
        data_file.write(@wx_data.to_json)
        data_file.close
      end

      pod_file_path = File.expand_path('~/Library/Application Support/Picotron/drive/appdata/wx.pod')
      File.open(pod_file_path, 'w') do |data_file|
        data_file.write("--[[pod,created=\"#{Time.now}\",modified=\"#{Time.now}\",revision=0]]")
        data_file.write("\n")
        data_file.write(ruby_hash_to_lua_table(@wx_data))
        data_file.close
      end
    end

    def run
      while true
        fetch_wx_data
        store_pod_data
        sleep 900
      end
    end

    private

    def ruby_hash_to_lua_table(hash)
      def format_value(value)
        case value
        when Hash
          ruby_hash_to_lua_table(value)
        when Array
          '{' + value.map { |v| format_value(v) }.join(',') + '}'
        when String
          "\"#{value}\""
        else
          value
        end
      end

      lua_table = '{'
      hash.each do |key, value|
        formatted_key = key
        formatted_value = format_value(value)
        lua_table += "#{formatted_key}=#{formatted_value},"
      end
      lua_table.chomp!(',')
      lua_table += '}'

      lua_table
    end
  end
end

wx = RubyPicoBridge::WX.new
# wx.fetch_wx_data
wx.run

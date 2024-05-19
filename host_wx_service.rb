require 'json'
module RubyPicoBridge
  class WX
    def initialize
      @wx_data = {}
    end

    def get_wx_data
      # TODO: fetch from a weather API or from local home assistant
      @wx_data = {
        time_hour: Time.now.strftime('%H').to_i,
        time_minute: Time.now.strftime('%M').to_i,
        time_second: Time.now.strftime('%S').to_i,
        temperature: 55,
        humidity: 77,
        pressure: 1017,
        wind_speed: 8,
        wind_direction: 12,
        rain: 0.02,
        uv: 1
      }
    end

    def format_wx_data
      payload = []
      payload << format('%02x', @wx_data[:time_hour] & 0xFF)
      payload << format('%02x', @wx_data[:time_minute] & 0xFF)
      payload << format('%02x', @wx_data[:time_second] & 0xFF)
      payload << format('%02x', @wx_data[:temperature] & 0xFF)
      payload << format('%02x', @wx_data[:humidity] & 0xFF)
      payload << format('%04x', @wx_data[:pressure] & 0xFFFF)
      payload << format('%02x', @wx_data[:wind_speed] & 0xFF)
      '0x' + payload.join('')
    end

    def store_wx_data
      file_path = File.expand_path('~/Library/Application Support/Picotron/drive/appdata/wx.dat')

      # for now, we'll also write to json to sanity check our data format & for debugging.
      txt_file_path = File.expand_path('~/Library/Application Support/Picotron/drive/appdata/wx.txt')
      File.open(file_path, 'w') do |data_file|
        data_file.write(format_wx_data)
        data_file.close
      end
      File.open(txt_file_path, 'w') do |data_file|
        data_file.write(@wx_data.to_json)
        data_file.close
      end
    end

    def run
      while true
        get_wx_data
        store_wx_data
        sleep 15
      end
    end
  end
end

wx = RubyPicoBridge::WX.new
wx.run

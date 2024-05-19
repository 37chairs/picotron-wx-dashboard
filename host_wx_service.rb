require 'json'

module RubyPicoBridge
  class WX
    def initialize
      @wx_data = {}
    end

    def get_wx_data
      @wx_data = {
        temperature: rand(10..30),
        humidity: rand(0..100),
        pressure: rand(1000..1100),
        wind_speed: rand(0..30),
        wind_direction: rand(0..360),
        rain: rand(0..10),
        uv: rand(0..10),
        solar_radiation: rand(0..1000)
      }
    end

    def format_wx_data
      payload = []
      payload << format('%02x', @wx_data[:temperature] & 0xFF)  # Ensure it's two characters
      payload << format('%02x', @wx_data[:humidity] & 0xFF)     # Ensure it's two characters
      payload << format('%04x', @wx_data[:pressure] & 0xFFFF)   # Ensure it's four characters for pressure
      payload << format('%02x', @wx_data[:wind_speed] & 0xFF)   # Ensure it's two characters
      '0x' + payload.join('')
    end

    def store_wx_data
      file_path = File.expand_path('~/Library/Application Support/Picotron/drive/appdata/wx.dat')
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
        sleep 900
      end
    end
  end
end

wx = RubyPicoBridge::WX.new
wx.run

--[[pod_format="raw",created="2024-05-24 22:12:08",modified="2024-05-24 22:12:08",revision=0]]
text_view = {}

function text_view.init()
end

function text_view.update()
end

function text_view.draw()
    local shade_color = 1
    local highlight_color = 0
    local shadow_color = 0
    local text_color = 7

    print("Currently: ", 5, 10, text_color, highlight_color, shadow_color)

    rect(2, 27, 287, 111, 5)

    print(wx.data.currently.summary, 5, 30, text_color, highlight_color, shadow_color)
    print("Temp: " .. wx.data.currently.temperature .. "F (Feels like " .. wx.data.currently.apparentTemperature ..
                          "F)", 5, 40, text_color, highlight_color, shadow_color)
    print("Humidity: " .. wx.data.currently.humidity * 100 .. "%", 5, 50, text_color, highlight_color,
        shadow_color)
    print("Wind: " .. wx.data.currently.windSpeed .. " mph bearing " .. wx.data.currently.windBearing ..
                          " (Gusting to " .. wx.data.currently.windGust .. " mph)", 5, 60, text_color, highlight_color,
        shadow_color)
    print("Cloud cover: " .. wx.data.currently.cloudCover * 100 .. "%", 5, 70, text_color, highlight_color,
        shadow_color)
    print("Pressure: " .. wx.data.currently.pressure .. " mb", 5, 80, text_color, highlight_color,
        shadow_color)
    print("Precip probability: " .. wx.data.currently.precipProbability * 100 .. "%", 5, 90, text_color,
        highlight_color, shadow_color)
    print("UV Index: " .. wx.data.currently.uvIndex, 5, 100, text_color, highlight_color, shadow_color)

    -- line(0, 117, 480, 117, 6)

    rect(2, 123, 477, 227, 5)

    for i = 1, 5 do
        local x = 5 + ((i - 1) * 90)

        local day_date = convert_timestamp(wx.data.daily.data[i].time, wx.data.offset)

        print(day_date.month .. "/" .. day_date.day .. ": ", x, 130, text_color, highlight_color, shadow_color)
        print(wx.data.daily.data[i].summary, x, 150, text_color, highlight_color, shadow_color)
        print("High: " .. wx.data.daily.data[i].temperatureHigh .. "F", x, 160, text_color, highlight_color,
            shadow_color)
        print("Low: " .. wx.data.daily.data[i].temperatureLow .. "F", x, 170, text_color, highlight_color,
            shadow_color)
        print("Precip: " .. wx.data.daily.data[i].precipProbability * 100 .. "%", x, 180, text_color,
            highlight_color, shadow_color)
        print("Wind: " .. wx.data.daily.data[i].windSpeed .. " mph", x, 190, text_color, highlight_color,
            shadow_color)
        print("Clouds: " .. wx.data.daily.data[i].cloudCover * 100 .. "%", x, 200, text_color, highlight_color,
            shadow_color)

        local sunrise_time = convert_timestamp(wx.data.daily.data[i].sunriseTime, wx.data.offset)
        print("Sunrise: " .. string.format("%02d", sunrise_time.hour) .. ":" .. string.format("%02d",sunrise_time.min), x, 210, text_color,
            highlight_color, shadow_color)
    end

    -- line(0, 240, 480, 240, 6)

    local updated_timestamp = convert_timestamp(wx.data.currently.time, wx.data.offset)
    print("Updated: " .. string.format("%02d",updated_timestamp.hour) .. ":" ..  string.format("%02d",updated_timestamp.min), 5, 250, 7)
    print("Elevation: " .. wx.data.elevation, 135, 250)
    print("Lat / Lon: " .. wx.data.latitude .. "," .. wx.data.longitude, 5, 260)

    spr(1, 468, 254)
    print("37chairs.com", 405, 260)
end

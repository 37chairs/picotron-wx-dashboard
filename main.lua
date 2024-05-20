--[[pod_format="raw",created="2024-05-19 03:47:03",modified="2024-05-19 11:51:50",revision=31]] update_timer = 0

wx_data = {}

function _init()
end

function _update()
    update_timer = update_timer - 1

    if update_timer < 1 then
        update_timer = 15
        wx_data = fetch("/appdata/wx.pod")
    end
end

function _draw()
    cls()

    print("Currently: ", 5, 10)

    print(wx_data.currently.summary, 5, 30)
    print("Temp: " .. wx_data.currently.temperature .. "F (Feels like " .. wx_data.currently.feels_like .. "F)", 5, 40)
    print("Humidity: " .. wx_data.currently.humidity * 100 .. "%", 5, 50)
    print("Wind: " .. wx_data.currently.wind_speed .. " mph bearing " .. wx_data.currently.wind_bearing ..
              " (Gusting to " .. wx_data.currently.wind_gust .. " mph)", 5, 60)
    print("Cloud cover: " .. wx_data.currently.cloud_cover * 100 .. "%", 5, 70)
    print("Pressure: " .. wx_data.currently.pressure .. " mb", 5, 80)
    print("Precip probability: " .. wx_data.currently.precip_probability * 100 .. "%", 5, 90)

    line(0, 107, 480, 107, 3)

    for i = 1, 5 do
        local x = 5 + ((i-1) * 90)
        print(wx_data.daily[i].day_of_week .. ": " , x, 120, 7)
        print(wx_data.daily[i].summary, x, 140)
        print("High: " .. wx_data.daily[i].temperature_high .. "F", x, 150)
        print("Low: " .. wx_data.daily[i].temperature_low .. "F", x, 160)
        print("Precip: " .. wx_data.daily[i].precip_probability * 100 .. "%", x, 170)
        print("Wind: " .. wx_data.daily[i].wind_speed .. " mph", x, 180)
        print("Clouds: " .. wx_data.daily[i].cloud_cover * 100 .. "%", x, 190)
        print("Sunrise: " .. string.format("%02d", wx_data.daily[i].sunrise_hour) .. ":" .. string.format("%02d", wx_data.daily[i].sunrise_minute), x, 200)
    end

    line(0, 240, 480, 240, 3)

    print("Updated: " .. string.format("%02d", wx_data.time_hour) .. ":" .. string.format("%02d", wx_data.time_minute) .. ":" .. string.format("%02d", wx_data.time_second), 5, 250, 7)
    print("Elevation: " .. wx_data.elevation, 95, 250)
    print("Lat / Lon: " .. wx_data.latitude .. "," .. wx_data.longitude, 5, 260)

    spr(1, 468, 254)
    print("37chairs.com", 405, 260)
end


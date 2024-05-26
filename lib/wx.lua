wx = {}

function wx.init()
    wx.data = {}
    wx.last_update = 999
    wx.fetch()
end

function wx.update()
    if (t() - wx.last_update) > 300 then
        wx.last_update = t()
        wx.fetch()
    end
end

function wx.fetch()
    api_key = "PIRATEWEATHER_API_KEY"   -- replace with your own key
    latitude = "40.8195141"                        -- replace with your own latitude
    longitude = "-96.7243515"                      -- replace with your own longitude
    url = "https://api.pirateweather.net/forecast/" .. api_key .. "/" .. latitude .. "," .. longitude .. "?exclude=minutely,hourly&units=us"
    printh(url)
    wx.data = json.decode(fetch(url))
    wx.last_update = t()
end

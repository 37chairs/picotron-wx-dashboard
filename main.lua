--[[pod_format="raw",created="2024-05-19 03:47:03",modified="2024-05-19 11:51:50",revision=31]] include(
    "/appdata/system/lib/json.lua")
include("lib/time_formatting.lua")
include("lib/draw_patterns.lua")
include("lib/wx.lua")
include("scenes/text_view.lua")
include("scenes/sky_view.lua")

function _init()
    wx.init()
end

function _update()
    wx.update()
end

function _draw()
    cls()
    -- text_view.draw()
    sky_view.draw()
end

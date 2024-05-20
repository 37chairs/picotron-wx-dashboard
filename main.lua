--[[pod_format="raw",created="2024-05-19 03:47:03",modified="2024-05-19 11:51:50",revision=31]] update_timer = 0


include("scenes/text_view.lua")

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
    text_view.draw()
end


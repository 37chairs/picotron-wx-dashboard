# Picotron wx dashboard

This is a simple wx dashboard for the Picotron.  It reads wx data from a shared location on the host computer and displays it on the Picotron screen.  The wx data is fetched from an API and written to the shared location by a separate script running on the host computer.

![Picotron wx dashboard](https://github.com/37chairs/picotron-wx-dashboard/blob/master/doc/dashboard_preview.png?raw=true)

## host_wx_service.rb

Runs on host computer and fetches wx data from an API, then writes to a shared location where Picotron can read it 
as a lua table.

## main.lua

Runs on Picotron, reads wx data from shared location and displays it on the screen.

## Todo

- [ ] Fetch wx data from an API
- [ ] Add more wx data to display
- [ ] Add forecast
- [ ] Add pixel art for picotron display of wx dashboard

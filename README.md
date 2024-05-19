# Picotron wx dashboard

## host_wx_service.rb

Runs on host computer and fetches wx data from an API, then writes to a shared location where Picotron can read it. 

## main.lua

Runs on Picotron, reads wx data from shared location and displays it on the screen.

## Todo

- [ ] Fetch wx data from an API
- [ ] Add more wx data to display
- [ ] Add forecast
- [ ] Add pixel art for picotron display of wx dashboard

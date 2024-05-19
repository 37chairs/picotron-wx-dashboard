# Picotron wx dashboard

This is a simple wx dashboard for the Picotron.  It reads wx data from a shared location on the host computer and displays it on the Picotron screen.  The wx data is fetched from an API and written to the shared location by a separate script running on the host computer.

![Picotron wx dashboard](https://github.com/37chairs/picotron-wx-dashboard/blob/master/doc/wx_data_output.png?raw=true)

## host_wx_service.rb

Runs on host computer and fetches wx data from an API, then writes to a shared location where Picotron can read it.  
We could do this as POD (Picotron Object Data) compressed as lz4, but I prefer simple hex strings.  Maybe if other people
touch this someday, we'll switch to POD or maybe even our own TLV format, though I don't really want to write a TLV 
parser in lua. 

Format: (Quickly changing)
- byte 1: hour
- byte 2: minute
- byte 3: seconds
- byte 4: temperature
- byte 5: humidity
- byte 6 - 7: pressure
- byte 8: wind speed

## main.lua

Runs on Picotron, reads wx data from shared location and displays it on the screen.

## Todo

- [ ] Fetch wx data from an API
- [ ] Add more wx data to display
- [ ] Add forecast
- [ ] Add pixel art for picotron display of wx dashboard

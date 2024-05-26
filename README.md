# Picotron wx dashboard

This is a simple wx dashboard for the Picotron.  It reads wx data from a shared location on the host computer and displays it on the Picotron screen.  The wx data is fetched from an API and written to the shared location by a separate script running on the host computer.  My plan is to host the system on a wall-mounted dashboard powered by raspberry pi running picotron and make it all pixel-arty. 

![Picotron wx dashboard](https://github.com/37chairs/picotron-wx-dashboard/blob/master/doc/dashboard_preview.png?raw=true)

## main.lua

Runs on Picotron, reads wx data from shared location and displays it on the screen.

## Todo

- [X] Fetch wx data from an API
- [X] Add more wx data to display
- [X] Add forecast
- [ ] Add pixel art for picotron display of wx dashboard

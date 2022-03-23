--load credentials
dofile("secrets.lua")

function startup()
  if file.open("init.lua") == nil then
    print("init.lua deleted")
  else
    print("Running")
    file.close("init.lua")
    dofile("sensor.lua")
  end
end

--init.lua
print("Setting up wifi")
wifi.setmode(wifi.STATION)
wifi.sta.config(WIFI_CONFIG)
wifi.sta.connect()
wifi.sta.autoconnect(1)

--- create a timer object
local tObj = tmr.create()
-- register an alarm

tObj:alarm(2000, tmr.ALARM_AUTO, function ()
    if wifi.sta.getip() then
      tObj:unregister()
      print("Wifi Config done, IP is " .. wifi.sta.getip())
      startup()
    end
  end)
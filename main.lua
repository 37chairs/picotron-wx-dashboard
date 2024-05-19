--[[pod_format="raw",created="2024-05-19 03:47:03",modified="2024-05-19 11:51:50",revision=31]]
wx_data = fetch("/appdata/wx.dat")
print("Raw wx data: " .. wx_data)

function get_bytes(hex_string, start_byte, end_byte)
  -- Remove the '0x' prefix
  hex_string = hex_string:sub(3)

  -- Calculate the start and end positions in the string
  local start_pos = (start_byte - 1) * 2 + 1
  local end_pos = end_byte * 2

  -- Extract the substring
  local byte_string = hex_string:sub(start_pos, end_pos)

  print("Byte string: " .. byte_string)

  -- Convert the hex substring to an integer
  local integer_value = tonumber(byte_string, 16)
  return integer_value
end

function hex_to_integer(bytes)
  -- bytes is a string of hex bytes
  -- returns an integer

  return tonumber(bytes, 16)
end

print(" ")
print("Temperature: " .. get_bytes(wx_data, 1, 1))
print("Humidity: " .. get_bytes(wx_data, 2, 2))
print("Pressure: " .. get_bytes(wx_data, 3, 4))
print("UV: " .. get_bytes(wx_data, 5, 5))
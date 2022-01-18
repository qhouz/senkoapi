local api = {
  math = http.get('https://raw.githubusercontent.com', '/qhouz/senkoapi/main/legendware/math.lua'),
  vector = http.get('https://raw.githubusercontent.com', '/qhouz/senkoapi/main/legendware/vector.lua'),
  player = http.get('https://raw.githubusercontent.com', '/qhouz/senkoapi/main/legendware/player.lua'),
  entity = http.get('https://raw.githubusercontent.com', '/qhouz/senkoapi/main/legendware/entity.lua'),
}

for api_name, async_info in pairs(api) do
  if async_info ~= '' then
    loadstring(async_info)()
  end
end

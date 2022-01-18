-- ! [Player] Simplification
function player:is_alive()
  if not self or not self:is_player() then
    return false end

  return self:get_health() > 0.0
end

function player:in_air()
  if not self then
    return false end

  return self:get_prop_bool('CBasePlayer', 'm_hGroundEntity')
end

function player:get_eye_position()
  if not self or not self:is_player() then
    return end
  
  local origin = self:get_origin()
  local eye_offset = vector.new(
    self:get_prop_float('CBasePlayer', 'm_vecViewOffset[0]'),
    self:get_prop_float('CBasePlayer', 'm_vecViewOffset[1]'),
    self:get_prop_float('CBasePlayer', 'm_vecViewOffset[2]')
  )
  return origin + eye_offset
end

function player:get_weapon()
  if not self or not self:is_player() then
    return end
  
  local weapon = entitylist.get_weapon_by_player(self)
  if not weapon or not weapon:is_weapon() then
    return end

  return weapon
end

function player:get_player_info()
  if not self or not self:is_player() then
    return end
  
  local info = engine.get_player_info(self:get_index())
  if not info then
    return end
    
  return info
end

function player:get_name()
  if not self or not self:is_player() then
    return '' end
  
  local info = self:get_player_info()
  if not info then
    return '' end
    
  return info.name
end

function player:is_teammate()
  local player = entitylist.get_local_player()
  if not player then
    return false end
  
  if not self or not self:is_player() then
    return false end
    
  return (self:get_team() == player:get_team())
end

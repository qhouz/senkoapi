-- ! [Entity] Simplification
function entity:get_player()
  if not self then
    return end

  if self:is_player() then
    return self end

  local player = entitylist.entity_to_player(self)
  if not player then
    return end

  return player
end

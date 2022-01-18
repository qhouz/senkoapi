-- ! [Math] Additions
function math.round(value, decimals)
  local multiplier = 10.0 ^ (decimals or 0.0);
  return math.floor(value * multiplier + 0.5) /multiplier
end

function math.clamp(value, minimum, maximum)
  if minimum > maximum then
    return math.min(math.max(value, maximum), minimum)
  else
    return math.min(math.max(value, minimum), maximum)
  end
end

function math.lerp(start, _end, time)
  return (_end - start) * time + start
end

function math.normalize_yaw(yaw)
  while yaw < -180.0 do
    yaw = yaw + 360.0 end
  
  while yaw > 180.0 do
    yaw = yaw - 360.0 end
  
  return yaw
end

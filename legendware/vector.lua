-- ! [Vector] Operators
function vector:__add(_vector)
  if not self or not self:is_valid() then
    return self end
  return vector.new(self.x + _vector.x, self.y + _vector.y, self.z + _vector.z)
end

function vector:__sub(_vector)
  if not self or not self:is_valid() then
    return self end
  return vector.new(self.x - _vector.x, self.y - _vector.y, self.z - _vector.z)
end

function vector:__mul(_vector)
  if not self or not self:is_valid() then
    return self end

  if type(_vector) == 'number' then
    return vector.new(self.x * _vector, self.y * _vector, self.z * _vector)
  end

  return vector.new(self.x * _vector.x, self.y * _vector.y, self.z * _vector.z)
end

function vector:__div(_vector)
  if not self or not self:is_valid() then
    return self end

  if type(_vector) == 'number' then
    return vector.new(self.x / _vector, self.y / _vector, self.z / _vector)
  end

  return vector.new(self.x / _vector.x, self.y / _vector.y, self.z / _vector.z)
end

function vector:__pow(_vector)
  if not self or not self:is_valid() then
    return self end

  if type(_vector) == 'number' then
    return vector.new(self.x ^ _vector, self.y ^ _vector, self.z ^ _vector)
  end

  return vector.new(self.x ^ _vector.x, self.y ^ _vector.y, self.z ^ _vector.z)
end

function vector:__len()
  if not self or not self:is_valid() then
    return self end

  return self:length()
end

-- ! [Vector] Simplifications
function vector:dot(_vector)
  if not self or not self:is_valid() then
    return self end

  return self * _vector
end

function vector:w2s()
  local w2s = render.world_to_screen(self)

  if not w2s:is_valid() then
    return end

  if w2s:is_zero() then
    return end
  
  return w2s
end

-- ! [Vector] Interactions
function vector:circle_3d(radius, start_deg, end_deg, func, segments)
  if self and self:is_valid() then
    segments = segments or 60.0

    local _prev

    local start = math.rad(start_deg)
    local total = math.rad(start_deg + end_deg)
    local piece = total /segments
    if piece == 0.0 then
      return end

    for _rad = start, total, piece do
      local _next = vector.new(
        self.x + math.cos(_rad) * radius,
        self.y + math.sin(_rad) * radius,
        self.z
      )
      
      if not _prev or not _prev:is_valid() then goto continue end

      if func and type(func) == 'function' then
        func(self, _prev, _next)
      end

      ::continue::
      _prev = _next
    end
  end
end

-- ! [Vector] Angles
function vector:angle_to_forward()
  if self and self:is_valid() then
    self.x = math.rad(self.x);
    self.y = math.rad(self.y);

    local forward = math.cos(self.x)
    return vector.new(
      forward * math.cos(self.y),
      forward * math.sin(self.y),
      -math.sin(self.x)
    );
  end
  return vector.new(0.0, 0.0, 0.0)
end

function vector:to_angle()
  if self and self:is_valid() then
    return vector.new(
      math.deg(math.atan2(
        -self.z,
        self:length_2d()
      )),
      math.deg(math.atan2(
        self.y,
        self.x
      )),
      0.0
    )
  end
  return vector.new(0.0, 0.0, 0.0)
end

function vector:normalize_angle()
  if self and self:is_valid() then
    -- * Pitch
    while self.x < -90.0 do
      self.x = self.x + 180.0 end

    while self.x > 90.0 do
      self.x = self.x - 180.0 end

    -- * Yaw
    while self.y < -180.0 do
      self.y = self.y + 360.0 end

    while self.y > 180.0 do
      self.y = self.y - 360.0 end
    
    return self
  end

end

function vector:to_fov(view)
  if self then
    local angle = self:to_angle()
    local delta = vector.new(
      math.abs(view.x - angle.x),
      math.abs(view.y % 360.0 - angle.y % 360.0) % 360.0,
      0.0
    )
  
    delta = delta:normalize_angle()
    delta = delta:length_2d()
  
    return math.min(delta, 180.0)
  end
  return 0.0
end

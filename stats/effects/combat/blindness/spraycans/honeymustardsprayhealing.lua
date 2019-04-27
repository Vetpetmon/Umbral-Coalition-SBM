
function init()
  effect.setParentDirectives("fade=fffd0f=0.25")
  script.setUpdateDelta(5)

  self.healingRate = config.getParameter("healAmount", 5) / effect.duration()
end

function update(dt)
  status.modifyResource("health", self.healingRate * dt)
end

function uninit()

end

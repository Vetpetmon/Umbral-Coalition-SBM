function init()
  world.sendEntityMessage(entity.id(), "queueRadioMessage", "uchostileplanetmsg",1)
  effect.addStatModifierGroup({
    {stat = "protection", effectiveMultiplier  = 0.5},
    {stat = "maxHealth", effectiveMultiplier  = 0.5},
    {stat = "powerMultiplier", baseMultiplier = 2.0}
  })
end

function uninit()

end

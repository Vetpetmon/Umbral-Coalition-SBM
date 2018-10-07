function init()
    self.species=world.entitySpecies(entity.id())

  if self.species ~= "uc" then
    self.effectHandler=effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = 20.0}})
    world.sendEntityMessage(entity.id(), "queueRadioMessage", "ucmeatillness",1)
    status.removeEphemeralEffect("wellfed",math.huge)
  else
    status.removeEphemeralEffect("ucmeat",math.huge)
  end
end

function update(dt)
end

function uninit()

end

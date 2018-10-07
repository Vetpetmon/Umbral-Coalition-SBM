function init()
    self.species=world.entitySpecies(entity.id()) --check player's species

  if self.species ~= "uc" then --if not a uc
    self.effectHandler=effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = 40.0}}) --40x the hunger drain.
    world.sendEntityMessage(entity.id(), "queueRadioMessage", "uclorumsickness",1) --SAIL screams at you. good job.
    status.removeEphemeralEffect("wellfed",math.huge)
  else --if a uc
    self.effectHandler=effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = 20.0}}) --20x because there's smth worse
    world.sendEntityMessage(entity.id(), "queueRadioMessage", "uclorumsicknessucs",1) --SAIL screams at you differently
    status.removeEphemeralEffect("wellfed",math.huge) --math is huge af dude

    script.setUpdateDelta(5)

    self.tickDamagePercentage = 0.050 --05%???? right???
    self.tickTime = 1.0
    self.tickTimer = self.tickTime
  end
end
-- Stinky banana
function update(dt)
  if self.species == "uc" then --only update if player is a uc otherwise, the update function does not take effect
    self.tickTimer = self.tickTimer - dt
    if self.tickTimer <= 0 then
      self.tickTimer = self.tickTime
      status.applySelfDamageRequest({ --damage the guy who ate smelly bread
          damageType = "IgnoresDef",
          damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) + 10, -- I multiplied c:<
          damageSourceKind = "poison",
          sourceEntityId = entity.id()
        })
      end
  end
  effect.setParentDirectives(string.format("fade=00AA00=%.1f", self.tickTimer * 0.4)) --visual effect
end

function uninit()
end
-- *Morty voice* "Im trying."

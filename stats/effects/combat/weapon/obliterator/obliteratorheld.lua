
function init()
  script.setUpdateDelta(5)

  self.tickDamagePercentage = 0.025
  self.tickTime = 0.4
  self.tickTimer = self.tickTime
  self.effectHandler=effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = 150.0}}) --120x the hunger drain.
  status.removeEphemeralEffect("wellfed",math.huge)
end

function update(dt)
  self.tickTimer = self.tickTimer - dt
    if self.tickTimer <= 0 then
      self.tickTimer = self.tickTime
      status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) * 3,
        damageSourceKind = "fire",
        sourceEntityId = entity.id()
      })
  end
  mcontroller.controlModifiers({
      speedModifier = 0.9,
    })
end

function uninit()

end

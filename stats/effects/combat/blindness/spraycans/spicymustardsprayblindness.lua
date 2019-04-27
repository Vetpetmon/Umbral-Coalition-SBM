
function init()
  effect.setParentDirectives("fade=fe8037=0.25")
  effect.addStatModifierGroup({
    {stat = "maxEnergy", amount = config.getParameter("energyAmount", -15.0)}
  })

  script.setUpdateDelta(5)

  self.tickDamagePercentage = 0.025
  self.tickTime = 1.0
  self.tickTimer = self.tickTime
end

function update(dt)
  mcontroller.controlModifiers({
    groundMovementModifier = 0.7,
    speedModifier = 0.7,
  })

  self.tickTimer = self.tickTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = self.tickTime
    status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) + 2,
        damageSourceKind = "fire",
        sourceEntityId = entity.id()
      })
  end
end

function uninit()

end


function init()
  effect.setParentDirectives("fade=FF0000=0.70")
  script.setUpdateDelta(3)

  self.tickDamagePercentage = 0.01
  self.tickTime = 0.3
  self.tickTimer = self.tickTime
end

function update(dt)
  self.tickTimer = self.tickTimer - dt
    if self.tickTimer <= 0 then
      self.tickTimer = self.tickTime
      status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) * 2,
        damageSourceKind = "fire",
        sourceEntityId = entity.id()
      })
  end
end

function uninit()

end

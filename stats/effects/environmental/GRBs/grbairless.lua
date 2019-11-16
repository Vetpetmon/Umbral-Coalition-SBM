function init()
  effect.setParentDirectives("fade=FF0000=0.25")
  world.sendEntityMessage(entity.id(), "queueRadioMessage", "ucgammaraywarning",1)

  script.setUpdateDelta(5)

  self.tickDamagePercentage = 0.025
  self.tickTime = 1.2
  self.killTime = 50
  self.tickTimer = self.tickTime
  self.killTimer = self.killTime
end

function update(dt)
  self.tickTimer = self.tickTimer - dt
  self.killTimer = self.killTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = self.tickTime
    status.applySelfDamageRequest({
    	damageType = "IgnoresDef",
    	damage = math.ceil(status.resourceMax("health") * self.tickDamagePercentage),
    	damageSourceKind = "electric",
    	sourceEntityId = entity.id()
    })
    animator.playSound("warning")
  end
  if self.killTimer <= 0 then
    animator.playSound("death")
    effect.addStatModifierGroup({
      {stat = "maxHealth", amount = config.getParameter("energyAmount", -10000.0)}
    })
  end
end

function uninit()

end

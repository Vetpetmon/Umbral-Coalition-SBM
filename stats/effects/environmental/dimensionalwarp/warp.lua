function init()
  effect.setParentDirectives("fade=000000=0.25")
  script.setUpdateDelta(1)

  self.killTime = config.getParameter("killTime", 1) --please do define this. please. for the love of god. this is how many times the tick timer goes before instantly killing players, even if they are in /admin.
  self.tickDamagePercentage = config.getParameter("damagePercentage", 1) --the value "1" does *100% damage*. DEFINE THIS.
  self.severity = config.getParameter("effectSeverity", 1) --This will accept values 1 through 3. 1 is lowest, 3 is max. Define this through the CORRECT range, whole numbers only.
  self.tickTime = 1
  self.tickTimer = self.tickTime
  self.killTimer = self.killTime
  self.invalid = false
  if not self.severity <= 1 and self.severity >= 3 then

    if self.severity == 1 or self.severity == 2 then
      world.sendEntityMessage(entity.id(), "queueRadioMessage", "ucdimensionalwarpwarning",1)
    end
    if self.severity == 3 then
      world.sendEntityMessage(entity.id(), "queueRadioMessage", "ucdimensionalwarpmaxwarning",1)
    end
  else
    if self.invalid == false then --while not stopping the script, it does spit a warning out ONCE in the log while performing everything else.
    sb.logInfo("ERROR: INVALID SEVERITY LEVEL GIVEN. PLEASE CONTACT THIRRAN.")
    self.invalid = true
    end
  end
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
  end
  if self.killTimer <= 0 then
    effect.addStatModifierGroup({
      {stat = "maxHealth", amount = config.getParameter("energyAmount", -10000.0)}
    })
  end
end

function uninit()

end

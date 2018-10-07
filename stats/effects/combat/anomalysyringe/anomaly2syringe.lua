function init()

  self.isimmune = world.entitySpecies(entity.id()) == "unknown"

  self.species=world.entitySpecies(entity.id())
	--sb.logInfo("race: %s",self.species)--if called while the player is logging in, will return nil
	if not self.species then
		self.postpone=5
		return
	end

  if not self.postpone then
    if not self.isimmune then
    effect.setParentDirectives(config.getParameter("directives", ""))

    self.movementModifiers = config.getParameter("movementModifiers", {})

    self.energyCost = config.getParameter("energyCost", 1)
    self.healthDamage = config.getParameter("healthDamage", 1)

    script.setUpdateDelta(config.getParameter("tickRate", 1))

    --effect.addStatModifierGroup({{stat = "energyRegenPercentageRate", effectiveMultiplier = 1.0}})

    world.sendEntityMessage(entity.id(), "queueRadioMessage", "kyroxwarningtier2anomaly", 5.0)
  end
  end

  self.init=true
end

function update(dt)
  if not self.init then
		if self.postpone then
			if self.postpone <= 0.0 then
				self.postpone=nil
				init()
			else
				self.postpone = self.postpone - dt
			end
		end
		return
	end

    if self.isimmune then
      status.removeEphemeralEffect("anomaly2syringe",math.huge) --apply immunity
    else
      mcontroller.controlModifiers(self.movementModifiers)
      if not status.overConsumeResource("energy", self.energyCost) then --will replace with creature spawns
        status.applySelfDamageRequest({
          damageType = "IgnoresDef",
          damage = self.healthDamage,
          damageSourceKind = "poison",
          sourceEntityId = entity.id()
        })
      end
    end
end

function uninit()
  if self.effectHandler then
		effect.removeStatModifierGroup(self.effectHandler)--this prevents orphaned stat modifier groups, which translates to doubled effects. only happens on reload, usually.
		self.effectHandler=nil
	end
	self.init=false
end

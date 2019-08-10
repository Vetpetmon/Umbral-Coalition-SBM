--


function init()
	if not self.postpone then
		self.item = config.getParameter("item")
		self.maxAmount = config.getParameter("maxAmount")
		self.configAmount = config.getParameter("amount")
		self.foodDelta = config.getParameter("foodDelta") --does effect change food delta from "1.3"? change this in json
	end
	self.species=world.entitySpecies(entity.id())
	--sb.logInfo("race: %s",self.species)--if called while the player is logging in, will return nil
	if not self.species then
		self.postpone=5
		return
	end

  self.isRadion = world.entitySpecies(entity.id()) == "radion"
  self.processRate = config.getParameter(self.isRadion and "refreshRadion" or "refreshWrongSpecies",2.0)

    if self.isRadion then --Player is a Radion?
      if self.foodDelta then--if food delta config parameter exists, set. if not, don't.
        self.effectHandler=effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = self.foodDelta}}) --sets hunger drain via a variable. Normal value is "1.3"
      end
    end
	script.setUpdateDelta(5)
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

  if self.isRadion then
		if not self.itemTimer then
			self.itemTimer=0.0
		elseif self.itemTimer > self.processRate then
      local count = world.entityHasCountOfItem(entity.id(), self.item)
      local maxDrop = math.min(self.configAmount, 1000)
      for _, entityID in pairs (world.itemDropQuery(entity.position(), 5)) do
        if world.entityName(entityID) == self.item then
          self.itemTimer=0.0
          return
        end
      end

      if count and count < self.maxAmount then
        world.spawnItem(self.item, entity.position(), math.min(self.configAmount, self.maxAmount - count), {price = 50})
      end

      self.itemTimer=0.0
    else
      self.itemTimer=self.itemTimer+dt
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

-- _____________________________________
-- THIS IS THE CORE FILE FOR ALL SET BONUS SCRIPTS
--
-- IT WILL BE REQUIRED IN EVERY .SETEFFECT AND .LUA FOR THE EFFECT.
--
-- IN THE .LUA OF THE SET EFFECT, ADD
-- require "/stats/effects/ucarmorbonuses/set-bonuses/ucsetbonuscore.lua"
-- AS THE FIRST LINE OF FILE. OTHERWISE, IT WILL NOT WORK AND POSSIBLY RESULT IN A CRASH IF "NOTHING HAPPENS" DOESN'T HAPPEN.
--
-- require "/scripts/util.lua"
-- IS NOT REQUIRED IN INDIVIDUAL SET EFFECTS' LUA SINCE THIS SCRIPT ALREADY LOADS util.lua
-- _____________________________________

require "/scripts/util.lua"

characterWeaponCheckResults={}
heldItemPrimary=nil
heldItemAlt=nil

-- _____________________________________
-- characterWeaponCheckResults will check the player (or NPC) for the weapon type held. It will search for weapon tags, not categories.
--
-- heldItemPrimary will check for the left mouse use item, and heldItemAlt will check for the right mouse use item.
-- _____________________________________

function armorSetBonusInit(armorSetName, armorSetStats, callbacks)
  self.statGroup = nil
  self.armourPresentOnCharacter = nil --"Is the player/NPC wearing armor?"
  self.armorSetName = armorSetName
	self.armorSetCheck = { armorSetName .. '_head', armorSetName .. '_chest', armorSetName .. '_legs' }
  self.armorSetStats = armorSetStats
  sb.logInfo("player is wearing '_head', '_chest', '_legs', armor set is 'armorSetName'")
  -- _____________________________________
  -- Am I doing this correctly?
  --
  -- The log should print out something like "player is wearing perfectarmorhead perfectarmorchest perfectarmorlegs, armor set is perfectlyGenericSet"
  --
  -- Now that I think of it, I should move that somewhere else as an if-then statement to avoid log spam later *Crystal Pudding Underworld intensifies*
  -- _____________________________________
end

function update()
  local newstate = setWornCheck(self.armorSetCheck)

  if self.armourWorn == newstate then
		for _, callback in pairs(self.callbacks) do --"pairs" returns the callbacks function
			if callback.update then callback.update() end
		end
		return
  end
end

-- _____________________________________
-- FUNCTIONS FOR WHEN THE SCRIPT IS KILLED/UNITIATED
--
-- SCRIPT IS KILLED WHEN THE PLAYER UNLOGS OR REMOVES AN ARMOR PIECE.
--
-- REMOVES ALL STATUS EFFECTS GRANTED BY THE ARMOR SET
-- _____________________________________

function armorSetBonusUninit()
	removeSetEffects()
	for _,v in pairs(effectHandlerList or {}) do
		effect.removeStatModifierGroup(v)
	end
end

function uninit()
	armorSetBonusUninit()
end

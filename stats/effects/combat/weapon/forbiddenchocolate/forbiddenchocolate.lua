require "/scripts/vec2.lua"
require "/scripts/util.lua"
require "/scripts/interp.lua"

function init()
  script.setUpdateDelta(10)

  --self.monsterUniqueId = string.format("%s-ghost", world.entityUniqueId(entity.id()) or sb.makeUuid())
  --self.findMonster = util.uniqueEntityTracker(self.monsterUniqueId, 0.2)

end

function update(dt)
  if not self.messaged then
    world.sendEntityMessage(entity.id(), "queueRadioMessage", "ucforbiddenchocolatemsg")
    self.messaged = true
  end
    local parameters = {
      level = world.threatLevel(),
      target = entity.id(),
      aggressive = true,
      --uniqueId = self.monsterUniqueId,
      keepAlive = true
    }
    world.spawnMonster("uclimboghost8", vec2.add(mcontroller.position(), config.getParameter("ghostSpawnOffset")), parameters)
end

function uninit()

end

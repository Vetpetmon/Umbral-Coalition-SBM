require "/scripts/util.lua"

function init()
  self.detectArea = config.getParameter("detectArea")
  self.detectArea[1] = object.toAbsolutePosition(self.detectArea[1])
  self.detectArea[2] = object.toAbsolutePosition(self.detectArea[2])

  storage.active = storage.active or config.getParameter("startActive", false)

  message.setHandler("activate", function()
    storage.active = true
    animator.setAnimationState("teleporter", "on")
    object.setLightColor(config.getParameter("lightColor", {50, 255, 50}))
  end)

  message.setHandler("isActive", function()
    return storage.active == true
  end)

  self.limboActiveTime = config.getParameter("limboActiveTime", 60)
  self.limboInstanceOptions = config.getParameter("limboInstance")
  self.limboAccessConfig = root.assetJson("/interface/scripted/limboteleporter/limboteleportergui.config")

  storage.limboActive = storage.limboActive or false

  message.setHandler("activateLimbo", function()
    if not storage.limboActive then
      storage.limboActive = true
      storage.limboCloseTime = world.time() + self.limboActiveTime
      math.randomseed(util.seedTime())
      local instanceOption = util.randomFromList(self.limboInstance)
      storage.limboType = instanceOption[1]
      storage.limboWorldId = string.format("InstanceWorld:%s:%s:%s", instanceOption[2], sb.makeUuid(), 8)

      animator.setGlobalTag("destination", storage.limboType)
      animator.setAnimationState("teleporter", "on")
      animator.playSound("on");
      object.setLightColor(config.getParameter("lightColor", {50, 255, 50}))
    end
  end)

  message.setHandler("closelimbo", function()
    if storage.limboActive then
      closelimbo()
    end
  end)

  if storage.active or storage.limboActive then
    animator.setAnimationState("console", "on")
    object.setLightColor(config.getParameter("lightColor", {255, 255, 255}))
  else
    animator.setAnimationState("console", "off")
    object.setLightColor({0, 0, 0, 0})
  end

  if storage.limboActive then
    animator.setGlobalTag("destination", storage.limboType)
    animator.setAnimationState("portal", "openloop")
  end
end

function onInteraction()
    if not storage.limboActive then
      return { "ScriptPane", "/interface/scripted/limboconsole/limboconsolegui.config" }
    else
      self.limboAccessConfig.closeTime = storage.limboCloseTime
      self.limboAccessConfig.activeTime = self.limboActiveTime
      self.limboAccessConfig.worldId = storage.limboWorldId
      return { "ScriptPane", self.limboAccessConfig }
    end
end

function update(dt)
  if storage.limboActive then
    if world.time() > storage.limboCloseTime then
      closelimbo()
    end
  end
end

function closelimbo()
  storage.limboActive = false
  animator.setAnimationState("console", "off")
  object.setLightColor({0, 0, 0, 0})
end

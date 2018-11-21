require "/items/active/weapons/ranged/gunfire.lua"

UCSprayCanMustardAttack = GunFire:new()

function UCSprayCanMustardAttack:init()
  GunFire.init(self)

  self.active = false
end

function UCSprayCanMustardAttack:update(dt, fireMode, shiftHeld)
  GunFire.update(self, dt, fireMode, shiftHeld)

  if self.weapon.currentAbility == self then
    if not self.active then self:activate() end
  elseif self.active then
    self:deactivate()
  end
end

function UCSprayCanMustardAttack:muzzleFlash()
  --null muzzle flash
end

function UCSprayCanMustardAttack:activate()
  self.active = true
  animator.playSound("fireStart")
  animator.playSound("fireLoop", -1)
end

function UCSprayCanMustardAttack:deactivate()
  self.active = false
  animator.stopAllSounds("fireStart") --*shk shk shk*
  animator.stopAllSounds("fireLoop") --spray
  animator.playSound("fireEnd") --end spray
end

function init()
  self.jumpSoundPlayed = false --Prevent jump sound at init. Defines that it exists
  --These lines will eliminate the need to use FR for certain racial bonuses .
  effect.addStatModifierGroup({
    {stat = "maxHealth", baseMultiplier = 0.8},
    {stat = "ucsolarflareImmunity", amount = 1},
    {stat = "baseDiseaseImmunity", amount = 1},
    {stat = "radiationburnImmunity", amount = 1},
    {stat = "foodDelta", baseMultiplier = 1.3},
    {stat = "physicalResistance", amount = 0.5},
    {stat = "radioactiveResistance", amount = 0.35},
    {stat = "shadowResistance", amount = -0.6},
    {stat = "iceResistance", amount = -0.4},
    {stat = "fireResistance", amount = -0.15}
  })
end

function update(dt)
  mcontroller.controlParameters({
        airForce = 70.0,
        groundForce = 45.0,
        runSpeed = 20.0
    })
  mcontroller.controlModifiers({
      speedModifier = 1.15
    })
    if not status.statPositive("activeMovementAbilities") then
     if mcontroller.jumping() and self.jumpSoundPlayed == false then
        animator.playSound("jump")
        self.jumpSoundPlayed = true

     elseif mcontroller.onGround() then
        self.jumpSoundPlayed = false
     end
    end
end

function uninit()

end

function init()
  self.jumpSoundPlayed = false --Prevent jump sound at init. Defines that it exists
  self.idleActive = false --reset to off
  if self.idleActive == false then --Check if false. If false, reverse the boolean.
    self.idleActive = true
  end
  --These lines will eliminate the need to use FR for certain racial bonuses .
  effect.addStatModifierGroup({
    {stat = "maxHealth", effectiveMultiplier = 0.8},
    {stat = "ucsolarflareImmunity", amount = 1},
    {stat = "baseDiseaseImmunity", amount = 1},
    {stat = "radiationburnImmunity", amount = 1},
    {stat = "biomeradiationImmunity", amount = 1},
    {stat = "foodDelta", baseMultiplier = 1.3},
    {stat = "physicalResistance", amount = 0.5},
    {stat = "radioactiveResistance", amount = 0.4},
    {stat = "shadowResistance", amount = -0.6},
    {stat = "iceResistance", amount = -0.6},
    {stat = "fireResistance", amount = -0.1}
  })
end

function update(dt)
  --animator.playSound("idle")
  mcontroller.controlParameters({
        airForce = 50.0,
        groundForce = 45.0,
        runSpeed = 20.0
    })
  mcontroller.controlModifiers({
      speedModifier = 1.15,
      airJumpModifier = 1.1
    })
    if self.idleActive == true then -- If true, initiate animation state "live"
      animator.setAnimationState("live", "on") --Initiate animation state
      animator.setParticleEmitterActive("radionParticles", true)
    else
      animator.setAnimationState("live", "off") --Keep off
    end
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
  self.idleActive = false
  animator.setAnimationState("live", "off") --stop animation state
end

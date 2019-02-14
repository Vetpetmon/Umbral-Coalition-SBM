function init()
  self.jumpSoundPlayed = false --Boolean variables
  self.crouchSoundPlayed = false
  effect.addStatModifierGroup({
    {stat = "fallDamageMultiplier", amount = 0.75}
  })
end

function update(dt)
  mcontroller.controlParameters({
        airForce = 35.0,
        groundForce = 23.5,
        runSpeed = 18.0
    })
  mcontroller.controlModifiers({
      speedModifier = 1.45
    })
end

function uninit()

end


function init()
  effect.setParentDirectives("fade=7733AA=0.25")
  effect.addStatModifierGroup({
    {stat = "jumpModifier", amount = -0.3},
    {stat = "maxEnergy", amount = config.getParameter("energyAmount", -1000.0)} --player may be unable to use ranged, but can still use basic melee.
  })
end

function update(dt)
  mcontroller.controlModifiers({
      groundMovementModifier = 0.1,
      speedModifier = 0.3,
      airJumpModifier = 0.1 --hecc you, you're unable to move. period.
    })
end

function uninit()

end

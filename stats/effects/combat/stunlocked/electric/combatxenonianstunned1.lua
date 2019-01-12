
function init()
  effect.setParentDirectives("fade=7733AA=0.25")
  effect.addStatModifierGroup({
    {stat = "jumpModifier", amount = -0.3},
    {stat = "maxEnergy", amount = config.getParameter("energyAmount", -10000.0)}
  })
end

function update(dt)
  mcontroller.controlModifiers({
      groundMovementModifier = 0.2,
      speedModifier = 0.4,
      airJumpModifier = 0.2
    })
end

function uninit()

end

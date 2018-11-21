
function init()
  effect.setParentDirectives("fade=ECA949=0.25")
  effect.addStatModifierGroup({
    {stat = "maxEnergy", amount = config.getParameter("energyAmount", -10.0)}
  })
end

function update(dt)
  mcontroller.controlModifiers({
      groundMovementModifier = 0.8,
      speedModifier = 0.8,
    })
end

function uninit()

end

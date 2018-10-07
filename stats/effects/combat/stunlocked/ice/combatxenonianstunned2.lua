
function init()
  effect.setParentDirectives("fade=96CBE7=0.15")
  effect.addStatModifierGroup({
    {stat = "jumpModifier", amount = 0.1}
  })
end

function update(dt)
  mcontroller.controlModifiers({
      groundMovementModifier = 0.8,
      speedModifier = 0.8,
      airJumpModifier = 0.3
    })
end

function uninit()

end

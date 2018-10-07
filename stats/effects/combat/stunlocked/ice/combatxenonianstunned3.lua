
function init()
  effect.setParentDirectives("fade=96CBE7=0.85")
  effect.addStatModifierGroup({
    {stat = "jumpModifier", amount = 0.1}
  })
end

function update(dt)
  mcontroller.controlModifiers({
      groundMovementModifier = 0.01,
      speedModifier = 0.01,
      airJumpModifier = 0.01
    })
end

function uninit()

end

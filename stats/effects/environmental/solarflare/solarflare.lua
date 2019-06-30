function init()
  effect.setParentDirectives("fade=7733AA=0.25")
  effect.addStatModifierGroup({
    {stat = "maxEnergy", amount = config.getParameter("energyAmount", -10000.0)}
  })
end

function uninit()

end

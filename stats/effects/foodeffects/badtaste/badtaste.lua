
function init()
  effect.addStatModifierGroup({
    {stat = "maxEnergy", amount = config.getParameter("energyAmount", -5.0)},
    {stat = "protection", amount = config.getParameter("protection", -2)}
  })
end

function init()
  --These lines will eliminate the need to use FR for certain racial bonuses, allowing for in-mod bonuses, but with optional FR goodies.
  effect.addStatModifierGroup({
    {stat = "slimeImmunity", amount = 1},
    {stat = "slimestickImmunity", amount = 1},
    {stat = "poisonStatusImmunity", amount = 1},
    {stat = "xenonian", amount = 1},
    {stat = "baseDiseaseImmunity", amount = 1},
    {stat = "poisonResistance", amount = 0.4},
    {stat = "maxEnergy", baseMultiplier = 0.9},
    {stat = "electricResistance", amount = -0.3},
    {stat = "fireResistance", amount = -0.3},
    {stat = "cosmicResistance", amount = -0.3}
  })
end
function update(dt)
end

function uninit()
end

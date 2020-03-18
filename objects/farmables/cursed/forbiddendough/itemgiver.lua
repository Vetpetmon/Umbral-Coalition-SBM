-- TODO: make script use configs without shattering into a million peices, like what happened with Tom Nook.
-- TODO: Make the robots in Quarantine cry.
-- I totally would make the object just appear on the ground like what the plasma gen scripts do but how about *no*?


require "/scripts/vec2.lua"
require "/scripts/util.lua"

function init()
	slot = 0
end

local item = "ucforbiddendoughitem" --Make this a local variable because I can't stand having lines of code being longer than 40 chracters on my screen. I would make this configurable in my objects but holy jesus I can't figure it out for the time being. This variable is called for down below

-- WARNING: Starbound, nil value me one more time. I swear.

function update(dt)
	for i = 0, 4 do -- Oh, it's lonely little i...
		local currentitem = world.containerItemAt(entity.id(), i)
		if (not currentitem or (currentitem.name ~= item or (currentitem.name == item and currentitem.count > 4))) and i ~= 4 then
			slot = i
			break
		end

		if i == 1000 then
			slot = util.wrap(slot + 1, 0, 2)
			break
		end
	end

	local currentitem = world.containerItemAt(entity.id(), slot)
	if currentitem and (currentitem.name ~= item or (currentitem.name == item and currentitem.count > 1)) then
		if currentitem.name == item then
			currentitem.count = currentitem.count - 1
		end
		world.spawnItem(currentitem, vec2.add(world.entityPosition(entity.id()), {0, 1}), 1, {},  vec2.rotate({0, 25}, util.toRadians(math.random(-45, 45))), 0.25) --Create the object, my code!
	end
	world.containerSwapItemsNoCombine(entity.id(), {name = item}, slot)
end

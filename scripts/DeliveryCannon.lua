local DeliveryCannon = {}
DeliveryCannon.name = "delivery-cannon"

script.on_init(function()
	DeliveryCannon.OnInit()
end)

function DeliveryCannon.OnInit()
	game.print("OnInit")
	global.s_DeliveryCannons = {}
	global.s_DeliveryCannonQueues = {}
	global.s_DeliveryCannonPayloads = {}
end

function DeliveryCannon.OnEntityCreated(event)
	local entity = Util.GetEntityFromEvent(event)
	if not entity then 
		return end

	game.print("OnEntityCreated: "..entity.name)

    ---@type DeliveryCannonInfo
	local deliveryCannon =
	{
		m_Entity = entity,
		m_UnitNumber = entity.unit_number,
	}

	global.s_DeliveryCannons[entity.unit_number] = deliveryCannon
end
script.on_event(defines.events.on_entity_cloned, DeliveryCannon.OnEntityCreated)
script.on_event(defines.events.on_built_entity, DeliveryCannon.OnEntityCreated)
script.on_event(defines.events.on_robot_built_entity, DeliveryCannon.OnEntityCreated)
script.on_event(defines.events.script_raised_built, DeliveryCannon.OnEntityCreated)
script.on_event(defines.events.script_raised_revive, DeliveryCannon.OnEntityCreated)

function DeliveryCannon.OnTick(event)
	--game.print("OnTick")
	DeliveryCannon.AttemptToFire(event)
end
script.on_event(defines.events.on_tick, DeliveryCannon.OnTick)

function DeliveryCannon.AttemptToFire(event)
	--game.print("AttemptToFire")
end

return DeliveryCannon

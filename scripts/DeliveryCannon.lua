local DeliveryCannon = {}
DeliveryCannon.name = "delivery-cannon"
DeliveryCannon.beam_name = "delivery-cannon-beam"
DeliveryCannon.beam_offset = { x = -0.5, y = -6 },

script.on_init(function()
	DeliveryCannon.OnInit()
end)

function DeliveryCannon.OnInit()
	game.print("OnInit")
	global.s_DeliveryCannons = {}
	global.s_DeliveryCannonQueues = {}
	global.s_DeliveryCannonPayloads = {}
end

---@param event EntityCreationEvent|EventData.on_entity_cloned|{entity:LuaEntity} Event data
function DeliveryCannon.OnEntityCreated(event)
	local entity = Util.GetEntityFromEvent(event)
	if not entity then 
		return end
	if entity.name ~= DeliveryCannon.name then 
		return end
	game.print("OnEntityCreated: "..entity.name)

    ---@type DeliveryCannonInfo
	local deliveryCannon = {
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

---@param event EntityRemovalEvent
function DeliveryCannon.OnEntityRemoved(event)
	local entity = event.entity
	if not entity then 
		return end
	if entity.name ~= DeliveryCannon.name then 
		return end
	game.print("OnEntityRemoved: " .. entity.name)

	global.s_DeliveryCannons[entity.unit_number] = nil
end
script.on_event(defines.events.on_entity_died, DeliveryCannon.OnEntityRemoved)
script.on_event(defines.events.on_robot_mined_entity, DeliveryCannon.OnEntityRemoved)
script.on_event(defines.events.on_player_mined_entity, DeliveryCannon.OnEntityRemoved)
script.on_event(defines.events.script_raised_destroy, DeliveryCannon.OnEntityRemoved)

function DeliveryCannon.OnTick(event)
	for _, deliveryCannon in pairs(global.s_DeliveryCannons) do
		if (event.tick + deliveryCannon.m_UnitNumber) % 60 == 0 then
			DeliveryCannon.AttemptToFire(deliveryCannon)
		end
	end

end
script.on_event(defines.events.on_tick, DeliveryCannon.OnTick)

---@param deliveryCannon DeliveryCannonInfo
function DeliveryCannon.AttemptToFire(deliveryCannon)
	--game.print("AttemptToFire")

	deliveryCannon.m_Entity.create_build_effect_smoke()
	deliveryCannon.m_Entity.surface.create_entity {
		name = DeliveryCannon.beam_name,
		position = Util.Vector2Add(deliveryCannon.m_Entity.position, DeliveryCannon.beam_offset ),
		target = Util.Vector2Add(deliveryCannon.m_Entity.position, {x = 0, y = -100})
	}
end

return DeliveryCannon

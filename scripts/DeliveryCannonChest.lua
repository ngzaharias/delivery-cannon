local DeliveryCannonChest = {}
DeliveryCannonChest.m_Name = "delivery-cannon-chest"

function DeliveryCannonChest.OnEntityCreated(event)
	local entity = Util.GetEntityFromEvent(event)
	if not entity then 
		return end
	if entity.name ~= DeliveryCannonChest.m_Name then 
		return end
	game.print("<unknown> created " .. entity.name .. "-" .. entity.unit_number)

	local chest = {
		m_Entity = entity,
		m_Handle = entity.unit_number,
	}

	global.s_DeliveryCannonChests[entity.unit_number] = chest
end

function DeliveryCannonChest.OnEntityRemoved(event)
	local entity = event.entity
	if not entity then 
		return end
	if entity.name ~= DeliveryCannonChest.m_Name then 
		return end
	game.print("<unknown> removed " .. entity.name .. "-" .. entity.unit_number)

	global.s_DeliveryCannonChests[entity.unit_number] = nil
end

return DeliveryCannonChest

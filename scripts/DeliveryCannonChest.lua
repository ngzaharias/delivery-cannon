local DeliveryCannonChest = {}
DeliveryCannonChest.m_Name = "delivery-cannon-chest"
DeliveryCannonChest.m_Prefix = string.len("delivery-cannon-package-")

function DeliveryCannonChest.OnEntityCreated(event)
	local entity = Util.GetEntityFromEvent(event)
	if not entity then 
		return end
	if entity.name ~= DeliveryCannonChest.m_Name then 
		return end
	-- game.print("<unknown> created " .. entity.name .. "-" .. entity.unit_number)

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
	-- game.print("<unknown> removed " .. entity.name .. "-" .. entity.unit_number)

	global.s_DeliveryCannonChests[entity.unit_number] = nil
end

function DeliveryCannonChest.OnTick(event)
	for i = #global.s_DeliveryCannonPayloads, 1, -1 do
		local payload = global.s_DeliveryCannonPayloads[i]
		if payload then
			if event.tick >= payload.arrival then
				DeliveryCannonChest.DropPayload(payload)
				table.remove(global.s_DeliveryCannonPayloads, i)
			end
		end
	end
end

function DeliveryCannonChest.DropPayload(payload)
	local chest = payload.target.m_Entity
	if not chest then
		return end

	local package = payload.package
	local spill = package.count - chest.insert(package)
end

return DeliveryCannonChest

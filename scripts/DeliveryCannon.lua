local DeliveryCannon = {}
DeliveryCannon.m_Name = "delivery-cannon"
DeliveryCannon.m_BeamName = "delivery-cannon-beam"
DeliveryCannon.m_BeamOffset = { x = -0.5, y = -6 }
DeliveryCannon.m_CapsuleName = "delivery-cannon-capsule"
DeliveryCannon.m_ProjectileName = "delivery-cannon-projectile"
DeliveryCannon.m_ProjectileShadowName = "delivery-cannon-projectile-shadow"
DeliveryCannon.m_CapsuleTimer = 2 * 60
DeliveryCannon.m_CapsuleAltitude = 100

function DeliveryCannon.IsValidTarget(target)
	return target 
		and target.m_Entity 
		and target.m_Entity.valid
		and target.m_Entity.position
		and target.m_Entity.surface
end

function DeliveryCannon.OnEntityCreated(event)
	local entity = Util.GetEntityFromEvent(event)
	if not entity then 
		return end
	if entity.name ~= DeliveryCannon.m_Name then 
		return end
	game.print("<unknown> created " .. entity.name .. "-" .. entity.unit_number)

    ---@type DeliveryCannonInfo
	local deliveryCannon = {
		m_Entity = entity,
		m_Handle = entity.unit_number,
		m_Target = nil,
	}

	global.s_DeliveryCannons[entity.unit_number] = deliveryCannon
end

function DeliveryCannon.OnEntityRemoved(event)
	local entity = event.entity
	if not entity then 
		return end
	if entity.name ~= DeliveryCannon.m_Name then 
		return end
	game.print("<unknown> removed " .. entity.name .. "-" .. entity.unit_number)

	global.s_DeliveryCannons[entity.unit_number] = nil
end

function DeliveryCannon.OnTick(event)
	for _, cannon in pairs(global.s_DeliveryCannons) do
		if (event.tick + cannon.m_Handle) % 60 == 0 then
			DeliveryCannon.AttemptToFire(cannon)
		end
	end
end

function DeliveryCannon.AttemptToFire(cannon)
	local stack = DeliveryCannon.GetStack(cannon)
	local target = cannon.m_Target
	if not DeliveryCannon.IsValidTarget(target) then
		return end
	if not stack then 
		return end

	local payload = {
		prototype = stack.prototype,
		target = target,
		arrival = game.tick + DeliveryCannon.m_CapsuleTimer,
		health = 1,
	}
	table.insert(global.s_DeliveryCannonPayloads, payload)

	cannon.m_Entity.create_build_effect_smoke()
	cannon.m_Entity.surface.create_entity {
		name = DeliveryCannon.m_BeamName,
		position = Util.Vector2Add(cannon.m_Entity.position, DeliveryCannon.m_BeamOffset ),
		target = Util.Vector2Add(cannon.m_Entity.position, {x = 0, y = -200})
	}

	local speed = DeliveryCannon.m_CapsuleAltitude / DeliveryCannon.m_CapsuleTimer
	local targetPosition = target.m_Entity.position
	local targetSurface = target.m_Entity.surface
	local capsuleStartPosition = Util.Vector2Add(targetPosition, { x = 0, y = -DeliveryCannon.m_CapsuleAltitude })
	local shadowStartPosition = Util.Vector2Add(targetPosition, { x = DeliveryCannon.m_CapsuleAltitude, y = 0 })
	targetSurface.create_entity {
		name = DeliveryCannon.m_ProjectileName,
		position = capsuleStartPosition,
		target = targetPosition,
		speed = speed
	}
	targetSurface.create_entity {
		name = DeliveryCannon.m_ProjectileShadowName,
		position = shadowStartPosition,
		target = targetPosition,
		speed = speed
	}
	targetSurface.request_to_generate_chunks(capsuleStartPosition)
	targetSurface.request_to_generate_chunks(shadowStartPosition)
	targetSurface.request_to_generate_chunks(targetPosition)

	-- do last as setting value to 0 will destroy the stack
	stack.count = stack.count - 1
end

function DeliveryCannon.GetStack(cannon)
	if not cannon then 
		return end
	local inventory = cannon.m_Entity.get_output_inventory()
	if not inventory then 
		return end
	if inventory.is_empty() then 
		return end

	return inventory[1]
end

return DeliveryCannon

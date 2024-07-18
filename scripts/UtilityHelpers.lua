local Util = {}

function Util.GetEntityFromEvent(event)
	local entity
	if event.entity and event.entity.valid then
		entity = event.entity
	end
	if event.created_entity and event.created_entity.valid then
		entity = event.created_entity
	end
	if event.destination and event.destination.valid then
		entity = event.destination
	end
	return entity
end

return Util
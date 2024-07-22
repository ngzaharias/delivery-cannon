local DeliveryCannonGUI = {}
DeliveryCannonGUI.m_RootName = "delivery-cannon-gui"
DeliveryCannonGUI.m_DropdownName = "delivery-cannon-gui-dropdown"

function GetSelectedIndex(cannon, chests)
	if not chests then
		return 0 end
	if not cannon or not DeliveryCannon.IsValidTarget(cannon.m_Target) then
		return 0 end

	local selectedIndex = 0
	local target = cannon.m_Target
	for index, chest in pairs(chests) do
		if chest and chest.m_Entity.unit_number == target.m_Entity.unit_number then
			selectedIndex = index
			break
		end
	end

	return selectedIndex
end

function DeliveryCannonGUI.OnGuiOpened(event)
	local entity = event.entity
	local player = game.get_player(event.player_index)

	if not entity or not player then 
		return end
	if entity.name ~= DeliveryCannon.m_Name then 
		return end
	game.print(player.name .. " opened " .. entity.name .. "-" .. entity.unit_number)

	local gui = player.gui.relative

  	local anchor = { gui = defines.relative_gui_type.assembling_machine_gui, position = defines.relative_gui_position.right}
	local container = gui.add {
		type = "frame",
		name = DeliveryCannonGUI.m_RootName,
		style = "delivery-cannon",
		direction = "vertical",
		anchor = anchor,
		tags = { unit_number = entity.unit_number }
	}
  	container.style.vertically_stretchable = "stretch_and_expand"

	-- titlebar
	local titlebar = container.add {
		type = "flow",
		direction = "horizontal",
		style = "delivery-cannon-titlebar"
	}

	titlebar.add {
		type = "label",
		caption = { "delivery-cannon.gui-settings" },
		style = "frame_title"
	}

	-- chest drop-down
	local chests = {}
	local items = {}
	for _, chest in pairs(global.s_DeliveryCannonChests) do
		table.insert(chests, chest)
		table.insert(items, chest.m_Entity.name .. "-" .. chest.m_Handle)
	end

	local cannon = global.s_DeliveryCannons[entity.unit_number]
	local dropdown = container.add {
		type = "drop-down",
		name = DeliveryCannonGUI.m_DropdownName,
		tooltip = "Todo.",
		items = items,
		selected_index = GetSelectedIndex(cannon, chests),
	}

	global.s_DeliveryCannonGUIs[dropdown.index] = {
		m_Cannon = cannon,
		m_Chests = chests,
	}
end

function DeliveryCannonGUI.OnGuiClosed(event)
	local entity = event.entity
	local player = game.get_player(event.player_index)

	if not entity or not player then 
		return end
	if entity.name ~= DeliveryCannon.m_Name then 
		return end
	local gui = player.gui.relative[DeliveryCannonGUI.m_RootName]
	if not gui then 
		return end
	game.print(player.name .. " closed " .. entity.name .. "-" .. entity.unit_number)

	gui.destroy() 
end

function DeliveryCannonGUI.OnGuiSelectionChanged(event)
	local element = event.element
	local player = game.get_player(event.player_index)
	if not element or not player then 
		return end
	if element.name ~= DeliveryCannonGUI.m_DropdownName then 
		return end
	if element.selected_index <= 0 then
		return end

	local info = global.s_DeliveryCannonGUIs[element.index]
	info.m_Cannon.m_Target = info.m_Chests[element.selected_index]
end

return DeliveryCannonGUI
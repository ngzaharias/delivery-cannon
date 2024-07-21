local DeliveryCannonGUI = {}
DeliveryCannonGUI.m_RootName = "delivery-cannon-gui"

function DeliveryCannonGUI.Destroy(player, rootName)

end

function DeliveryCannonGUI.OnGuiOpened(event)
	local entity = event.entity
	local player = game.get_player(event.player_index)

	if not entity or not player then 
		return end
	if entity.name ~= DeliveryCannon.m_Name then 
		return end

	game.print("OnGuiOpened: " .. entity.name)

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

	game.print("OnGuiClosed: " .. entity.name)

	gui.destroy() 
end

script.on_event(defines.events.on_gui_opened, DeliveryCannonGUI.OnGuiOpened)
script.on_event(defines.events.on_gui_closed, DeliveryCannonGUI.OnGuiClosed)

return DeliveryCannonGUI
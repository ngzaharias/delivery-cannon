local mod_display_name = "Delivery Cannon"

Util = require("scripts/UtilityHelpers")

DeliveryCannon = require('scripts/DeliveryCannon')
DeliveryCannonChest = require('scripts/DeliveryCannonChest')
DeliveryCannonGUI = require('scripts/DeliveryCannonGUI')

script.on_init(function()
	game.print("OnInit")
	global.s_DeliveryCannons = {}
	global.s_DeliveryCannonChests = {}
	global.s_DeliveryCannonQueues = {}
	global.s_DeliveryCannonPayloads = {}
	global.s_DeliveryCannonGUIs = {}
end)

function OnEntityCreated(event)
	DeliveryCannon.OnEntityCreated(event)
	DeliveryCannonChest.OnEntityCreated(event)
end

function OnEntityRemoved(event)
	DeliveryCannon.OnEntityRemoved(event)
	DeliveryCannonChest.OnEntityRemoved(event)
end

function OnTick(event)
	DeliveryCannon.OnTick(event)
end

function OnGuiOpened(event)
	DeliveryCannonGUI.OnGuiOpened(event)
end

function OnGuiClosed(event)
	DeliveryCannonGUI.OnGuiClosed(event)
end

function OnGuiSelectionChanged(event)
	DeliveryCannonGUI.OnGuiSelectionChanged(event)
end

script.on_event(defines.events.on_entity_cloned, OnEntityCreated)
script.on_event(defines.events.on_built_entity, OnEntityCreated)
script.on_event(defines.events.on_robot_built_entity, OnEntityCreated)
script.on_event(defines.events.script_raised_built, OnEntityCreated)
script.on_event(defines.events.script_raised_revive, OnEntityCreated)

script.on_event(defines.events.on_entity_died, OnEntityRemoved)
script.on_event(defines.events.on_robot_mined_entity, OnEntityRemoved)
script.on_event(defines.events.on_player_mined_entity, OnEntityRemoved)
script.on_event(defines.events.script_raised_destroy, OnEntityRemoved)

script.on_event(defines.events.on_tick, OnTick)

script.on_event(defines.events.on_gui_opened, OnGuiOpened)
script.on_event(defines.events.on_gui_closed, OnGuiClosed)
script.on_event(defines.events.on_gui_selection_state_changed, OnGuiSelectionChanged)
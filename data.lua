local technology = 
{
	type = "technology",
	name = "delivery-cannon",
	effects = {
		{ type = "unlock-recipe", recipe = "delivery-cannon", },
	},
	icon = "__delivery-cannon__/graphics/technology/delivery-cannon.png",
	icon_size = 128,
	order = "e-g",
	prerequisites = {
		"explosives",
	},
	unit = {
		count = 200,
		time = 30,
		ingredients = {
			{ "automation-science-pack", 1 },
			{ "logistic-science-pack", 1 },
			{ "chemical-science-pack", 1 },
		}
	},
}

local recipe = 
{
	type = "recipe",
	name = "delivery-cannon",
	result = "delivery-cannon",
	enabled = false,
	energy_required = 10,
	ingredients = {
		{ "pipe", 10 },
		{ "concrete", 20 },
	},
	requester_paste_multiplier = 1,
	always_show_made_in = false,
}

local prototype = 
{
	type = "assembling-machine",
	name = "delivery-cannon",
	minable = {
		mining_time = 0.5,
		result = "delivery-cannon",
	},
	icon = "__delivery-cannon__/graphics/icons/delivery-cannon.png",
	icon_size = 64,
	icon_mipmaps = 1,
	order = "a-a",
	max_health = 1500,
	flags = { "placeable-neutral", "placeable-player", "player-creation"},
	corpse = "big-remnants",
	dying_explosion = "medium-explosion",
	alert_icon_shift = util.by_pixel(0, -12),
	collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
	selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
	drawing_box = {{-2.5, -2.5-5}, {2.5, 2.5}},
	resistances =
	{
		{ type = "explosion", percent = 99 },
		{ type = "impact", percent = 99 },
		{ type = "fire", percent = 99 },
	},
	open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.5 },
	close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.5 },
	vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
	working_sound = {
		apparent_volume = 1.5,
		idle_sound = {
			filename = "__base__/sound/idle1.ogg",
			volume = 0.6
		},
		sound = {
			{
				filename = "__base__/sound/assembling-machine-t1-1.ogg",
				volume = 0.8
			},
			{
				filename = "__base__/sound/assembling-machine-t1-2.ogg",
				volume = 0.8
			}
		}
	},
	collision_mask = {
		"water-tile",
		"item-layer",
		"object-layer",
		"player-layer",
	},
	animation =
	{
	  layers =
	  {
		{
			filename = "__delivery-cannon__/graphics/entity/delivery-cannon/delivery-cannon.png",
			frame_count = 1,
			line_length = 1,
			width = 320/2,
			height = 640/2,
			shift = {0,-2.5},
			hr_version = {
				filename = "__delivery-cannon__/graphics/entity/delivery-cannon/hr-delivery-cannon.png",
				frame_count = 1,
				line_length = 1,
				width = 320,
				height = 640,
				shift = {0,-2.5},
				scale = 0.5,
			},
		},
		{
			draw_as_shadow = true,
			filename = "__delivery-cannon__/graphics/entity/delivery-cannon/delivery-cannon-shadow.png",
			shift = { 1.25, 1/32 },
			width = 470/2,
			height = 306/2,
			hr_version = {
				draw_as_shadow = true,
				filename = "__delivery-cannon__/graphics/entity/delivery-cannon/hr-delivery-cannon-shadow.png",
				shift = { 1.25, 1/32 },
				width = 470,
				height = 306,
				scale = 0.5,
			}
		}
	  }
	},
	crafting_categories = { "basic-crafting" },
	crafting_speed = 1,
	energy_source =
	{
		type = "void",
	},
	energy_usage = "100kW",
	module_specification =
	{
		module_slots = 0
	},
	allowed_effects = {},
}

local item = 
{
	type = "item",
	name = "delivery-cannon",
	icon = "__delivery-cannon__/graphics/icons/delivery-cannon.png",
	icon_size = 64,
	order = "j-a",
	subgroup = "logistic-network",
	stack_size = 20,
	place_result = "delivery-cannon",
}

data:extend { technology, recipe, prototype, item }
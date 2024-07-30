data:extend({
	{
		type = "recipe",
		name = "delivery-cannon-capsule",
		result = "delivery-cannon-capsule",
		enabled = false,
		energy_required = 10,
		ingredients = {
			{ "low-density-structure", 1 },
			{ "explosives", 5 },
			{ "copper-cable", 10 },
		},
		requester_paste_multiplier = 1,
		always_show_made_in = false,
	},
	{
		type = "item",
		name = "delivery-cannon-capsule",
		icon = "__delivery-cannon__/graphics/icons/delivery-cannon-capsule.png",
		icon_size = 64,
		order = "s",
		subgroup = "logistic-network",
		stack_size = 50,
	},
	{
		-- making these artillery-projectile(s) instead of projectile(s) makes it possible for them to show up on the map
		type = "artillery-projectile",
		name = "delivery-cannon-projectile",
		icon = "__delivery-cannon__/graphics/icons/delivery-cannon-capsule.png",
		icon_size = 64,
		acceleration = 0,
		rotatable = false,
		picture = {
			filename = "__delivery-cannon__/graphics/entity/delivery-cannon/delivery-cannon-capsule.png",
			width = 58/2,
			height = 94/2,
			priority = "high",
			shift = { 0, 0 },
			{
				filename = "__delivery-cannon__/graphics/entity/delivery-cannon/hr-delivery-cannon-capsule.png",
				width = 58,
				height = 94,
				priority = "high",
				shift = { 0, 0 },
				scale = 0.5,
			},
		},
		-- reveal_map, map_color, and chart_picture are specific to artillery-projectile and dictate how it will behave with the map
		-- because charting is handled by the delivery cannon script, reveal_map should be left false
		reveal_map = false,
		map_color = {r=0.3, g=0.6, b=0.1},
		chart_picture =	{
			filename = "__base__/graphics/entity/artillery-projectile/artillery-shoot-map-visualization.png",
			flags = { "icon" },
			frame_count = 1,
			width = 64,
			height = 64,
			priority = "high",
			scale = 0.20,
			tint = {r=0.3, g=0.6, b=0.1},
		},
		flags = { "not-on-map", "placeable-off-grid"},
		light = { intensity = 0.2, size = 10},
		smoke = {
			{
				deviation = { 0.15, 0.15 },
				frequency = 1,
				name = "smoke-fast",
				--name = "smoke-explosion-particle",
				--name = "soft-fire-smoke", -- lasts longer
				position = { 0, 0},
				slow_down_factor = 1,
				starting_frame = 3,
				starting_frame_deviation = 5,
				starting_frame_speed = 0,
				starting_frame_speed_deviation = 5
			}
		},
	},
	{
		type = "projectile",
		name = "delivery-cannon-projectile-shadow",
		acceleration = 0,
		rotatable = false,
		animation = {
			draw_as_shadow = true,
			filename = "__delivery-cannon__/graphics/entity/delivery-cannon/delivery-cannon-capsule-shadow.png",
			frame_count = 1,
			width = 98/2,
			height = 50/2,
			line_length = 1,
			priority = "high",
			shift = { 0, 0 },
			hr_version = {
				draw_as_shadow = true,
				filename = "__delivery-cannon__/graphics/entity/delivery-cannon/hr-delivery-cannon-capsule-shadow.png",
				frame_count = 1,
				width = 98,
				height = 50,
				line_length = 1,
				priority = "high",
				shift = { 0, 0 },
				scale = 0.5,
			},
		},
		flags = { "not-on-map", "placeable-off-grid"},
	  },
})

for _, recipe in pairs(delivery_cannon_recipes) do
	if data.raw[recipe.type][recipe.name] then
		local base = data.raw[recipe.type][recipe.name]
		local amount = base.stack_size

		local order = ""
		local subgroup = base.subgroup and data.raw["item-subgroup"][base.subgroup] or nil
		local group = subgroup and data.raw["item-group"][subgroup.group] or nil
		if group then
			order = (group.order or group.name) .. "-|-" .. (subgroup.order or subgroup.name) .. "-|-"
		end
		order = order .. (base.order or base.name)

		data:extend({
			{
				type = "item",
				name = "delivery-cannon-package-" .. recipe.name,
				icon = "__delivery-cannon__/graphics/icons/delivery-cannon-capsule.png",
				icon_size = 64,
				order = order,
				subgroup = base.subgroup or "delivery-cannon-capsules",
				stack_size = 1,
			},
			{
				type = "recipe",
				name = "delivery-cannon-pack-" .. recipe.name,
				result = "delivery-cannon-package-" .. recipe.name,
				enabled = true,
				energy_required = 5,
				ingredients = {
					{ "delivery-cannon-capsule", 1 },
					{ recipe.name, base.stack_size },
				},
          		category = "delivery-cannon",
				requester_paste_multiplier = 1,
				always_show_made_in = false,
				hide_from_player_crafting = true,
				allow_decomposition = false,
				icon = base.icon,
				icon_size = base.icon_size,
				icon_mipmaps = base.icon_mipmaps,
				icons = base.icons,
			},
		})
	end
end
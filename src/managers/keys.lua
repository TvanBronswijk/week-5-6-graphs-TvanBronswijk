local keys = {}

function base_handle(key)
	if key == "r" then
		generate_graph()
	elseif key == "up" then
		player.y = player.y - 1
	elseif key == "down" then
		player.y = player.y + 1
	elseif key == "left" then
		player.x = player.x - 1
	elseif key == "right" then
		player.x = player.x + 1
	elseif key == "g" then
		log = "up, down, left, right?"
		keys.handle = grenade_handle
	elseif key == "s" then
		if graph.draw_mode == 2 then
			graph.draw_mode = 0
		else
			graph.draw_mode = graph.draw_mode + 1
		end
	else return false 
	end
	return true
end

function grenade_handle(key)
	if key == "up" then
		graph:grenade(player.x, player.y, {x=0, y=-1})
	elseif key == "down" then
		graph:grenade(player.x, player.y, {x=0, y=1})
	elseif key == "left" then
		graph:grenade(player.x, player.y, {x=-1, y=0})
	elseif key == "right" then
		graph:grenade(player.x, player.y, {x=1, y=0})
	else return false 
	end
	distance = graph:distance_to(graph.start.x, graph.start.y, graph.exit)
	log = "Acties: Talisman, Handgranaat, Kompas"
	keys.handle = base_handle
	return true
end

keys.handle = base_handle
return keys
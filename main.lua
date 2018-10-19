--Rock libraries
console = require 'loveconsole.console'
console:initialize({
	name = "main",
	extend = true,
	buffer_width = 80,
	buffer_height = 50,
	font = "res/fonts/press-start-2p.ttf",
	font_size = 16,
})
colors = require 'loveconsole.colors'
class = require 'middleclass'
--utility functions
util = require 'lib.util'
--utility classes
Queue = require 'lib.queue'

--managers
local keys = require 'src.managers.keys'

--classes
Graph = require 'src.graph.graph'
require 'src.graph.algorithms.bfs'
require 'src.graph.algorithms.mst-prims'
require 'src.graph.algorithms.dijkstra'

Vertice = require 'src.graph.vertice'
Edge = require 'src.graph.edge'

function love.run()
    if love.math then
		love.math.setRandomSeed(os.time())
    end
	if love.load then love.load(arg) end
	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end
	local dt = 0
    if love.graphics and love.graphics.isActive() then
		love.graphics.clear(love.graphics.getBackgroundColor())
		love.graphics.origin()
		if love.draw then love.draw() end
		love.graphics.present()
	end
	-- Main loop time.
	while true do
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
			if name == "quit" then
				if not love.quit or not love.quit() then
					return a
				end
			end
			love.handlers[name](a,b,c,d,e,f)		
            end
		end
		-- Update dt, as we'll be passing it to update
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end
		-- Call update and draw
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
		if love.timer then love.timer.sleep(0.001) end
	end
end

function love.load()
	love.keyboard.setKeyRepeat(true)
	generate_graph()
	player = {x = graph.start.x, y = graph.start.y}
	distance = graph:distance_to(graph.start.x, graph.start.y, graph.exit)
	dijkstra_distance = graph:pathfinding(player.x, player.y, graph.exit)
	log = "Acties: Tali(s)man, Hand(g)ranaat, Kompa(s)"

end

function love.draw()
	console:print("S = Room: Startpunt", 2, 2, colors.white, colors.black)
	console:print("E = Room: Eindpunt", 2, 3, colors.white, colors.black)
	console:print("X = Room: Niet Bezocht", 2, 4, colors.white, colors.black)
	console:print("* = Room: Bezocht", 2, 5, colors.white, colors.black)
	console:print("~ = Hallway: Ingestort", 2, 6, colors.white, colors.black)
	console:print("# = Hallway: Level Tegenstander", 2, 7, colors.white, colors.black)

	graph:draw(4, 8)
	console:print(" ", 4+player.x*4, 8+player.y*4, colors.white, {1.0, 0.0, 0.0, 0.4})

	console:print(log, 2, 45, colors.white, colors.black)
	console:print("Distance: " .. tostring(distance), 2, 46)
	console:print("Weighted distance: " .. tostring(dijkstra_distance), 2, 47)
end

function love.keypressed(key)
	if keys.handle(key) then
		graph:refresh()
		distance = graph:distance_to(player.x, player.y, graph.exit)
		dijkstra_distance = graph:pathfinding(player.x, player.y, graph.exit)
		console:flush()
	end
end

function generate_graph()
	graph = Graph:new(16, 8)
end

function console:flush()
    if love.graphics and love.graphics.isActive() then
        love.graphics.clear(love.graphics.getBackgroundColor())
        love.graphics.origin()
        if love.draw then love.draw() end
        love.graphics.present()
    end
end
local Graph = class('Graph')

function Graph:initialize(width, height)
    self.vertices = {}
    self.edges = {}
    self.width = width
    self.height = height

    for x = 1, width do 
        for y = 1, height do 
            self.vertices[x * self.height + y] = Vertice:new(x, y, 'X')
            if x > 1 then
                local left = self:coord(x-1, y)
                local right = self:coord(x, y)
                local edge = left:connect(right, 1, 0)
                table.insert(self.edges, edge)
            end
            if y > 1 then
                local top = self:coord(x, y-1)
                local bottom = self:coord(x, y)
                local edge = top:connect(bottom, 0, 1)
                table.insert(self.edges, edge)
            end
        end
    end

    local x = love.math.random(width)
    local y = love.math.random(height)
    self.start = self:coord(x, y)
    self.start.id = 'S'
    local x = love.math.random(width)
    local y = love.math.random(height)
    self.exit = self:coord(x, y)
    self.exit.id = 'E'

    self.draw_mode = 0
    self.msp = self:min_spanning_tree()
end

function Graph:coord(x, y)
    return self.vertices[x * self.height + y]
end

function Graph:refresh()
    for _, v in pairs(self.vertices) do
        v.color = colors.white
        v.dijkstra_weight = 99999
    end
end

function Graph:grenade(x, y, dir)
    local left = self:coord(x, y)
    local right = left:find_neighbour(dir.x, dir.y)
    local edge = nil
    for k, v in pairs(self.edges) do
        if (v.left == left or v.left == right) and (v.right == left or v.right == right) then
            edge = v
        end
    end

    if edge == nil then
        return
    end

    if not table.contains(self.msp, edge) then
        edge:destroy()
    else
        edge.weight = 0
    end
end

function Graph:vertice_edges(vert)
    r = {}
    for k, v in pairs(self.edges) do
        if (v.left == vert or v.right == vert) and v.accessible then
            table.insert(r, v)
        end
    end
    return r
end

function Graph:draw(x, y)
    for key, val in pairs(self.vertices) do
        val:draw(x, y)
    end
    for key, val in pairs(self.edges) do
        val:draw(x, y)
    end
end

return Graph
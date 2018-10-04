local Vertice = class('Vertice')

function Vertice:initialize(x, y, id)
    self.neighbours = {}
    self.visited = false
    self.x = x
    self.y = y
    self.id = id

    self.color = colors.white

    self.dijkstra_weight = 99999
end

function Vertice:connect(vertice, xoff, yoff)
    self.neighbours[{x = xoff, y = yoff}] = vertice
    vertice.neighbours[{x = xoff*-1, y = yoff*-1}] = self
    local edge = Edge:new(love.math.random(1, 9), true)
    edge.left = self
    edge.right = vertice
    return edge
end

function Vertice:find_neighbour(x, y)
    for k, v in pairs(self.neighbours) do
        if k.x == x and k.y == y then
            return v
        end
    end
end

function Vertice:draw(x, y)
    if self.id == 'X' then 
        console:print(self.id, x + self.x*4, y + self.y*4, self.color)
    elseif self.id == 'S' then
        console:print(self.id, x + self.x*4, y + self.y*4, colors.green)
    elseif self.id == 'E' then
        console:print(self.id, x + self.x*4, y + self.y*4, colors.green)
    end
end

return Vertice
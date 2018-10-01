local Vertice = class('Vertice')

function Vertice:initialize(x, y, id)
    self.neighbours = {}
    self.visited = false
    self.x = x
    self.y = y
    self.id = id
end

function Vertice:connect(vertice)
    table.insert(self.neighbours, vertice)
    table.insert(vertice.neighbours, self)
    local edge = Edge:new(love.math.random(0, 9), true)
    edge.left = self
    edge.right = vertice
    return edge
end

function Vertice:draw(x, y, color)
    if self.id == 'X' then 
        console:print(self.id, x + self.x*4, y + self.y*4, color)
    elseif self.id == 'S' then
        console:print(self.id, x + self.x*4, y + self.y*4, color or colors.green)
    elseif self.id == 'E' then
        console:print(self.id, x + self.x*4, y + self.y*4, color or colors.green)
    end
end

return Vertice
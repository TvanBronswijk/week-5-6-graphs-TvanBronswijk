local Graph = class('Graph')

function Graph:initialize(width, height)
    self.vertices = {}
    self.edges = {}
    self.width = width
    self.height = height

    for x = 1, width do 
        for y = 1, height do 
            self.vertices[x + self.width * y] = Vertice:new(x, y, 'X')
            if x > 1 then
                local left = self:coord(x-1, y)
                local right = self:coord(x, y)
                table.insert(self.edges, left:connect(right))
            end
            if y > 1 then
                local top = self:coord(x, y-1)
                local bottom = self:coord(x, y)
                table.insert(self.edges, top:connect(bottom))
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
end

function Graph:coord(x, y)
    return self.vertices[x + self.width * y]
end

function Graph:distance_to(x, y, vertice)
    local root = self:coord(x, y)
    
    local visited = {}
    local to_visit = Queue:new() 
    local paths = {}
    function paths:count(node)
        if self[node] == nil then
            return 0
        end
        return 1 + self:count(self[node])
    end

    paths[root] = nil
    to_visit:push(root)
    
    while to_visit:size() > 0 do
        local node = to_visit:pop()
        if node == vertice then
            return paths:count(node)
        end
        table.insert(visited, node)

        for _, value in ipairs(node.neighbours) do
            if not table.contains(visited, value) then
                paths[value] = node
                to_visit:push(value)
            end
        end
    end

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
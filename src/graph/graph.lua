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

function Graph:distance_to(x, y, vertice)
    local root = self:coord(x, y)
    
    local visited = {}
    local to_visit = Queue:new() 
    local paths = {}
    function paths:count(node)
        node.color = colors.red
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

        for _, value in pairs(node.neighbours) do
            if not table.contains(visited, value) and not table.contains(to_visit.nodes, value) then
                paths[value] = node
                to_visit:push(value)
            end
        end
    end
end

function Graph:min_spanning_tree()
    local root = self:coord(1, 1)
    local visited = {}
    local to_visit = Queue:new() 
    to_visit:push(root)

    while to_visit:size() > 0 do
        local node = to_visit:pop()
        table.insert(visited, node)
        for _, value in pairs(node.neighbours) do
            if not table.contains(visited, value) and not table.contains(to_visit.nodes, value) then
                to_visit:push(value)
            end
        end
    end

    return table.count(visited) == table.count(self.vertices)
end

function Graph:grenade(x, y, dir)
    local left = self:coord(x, y)
    local right = left:find_neighbour(dir.x, dir.y)
    local edgeKey = nil
    local edge = nil
    for k, v in pairs(self.edges) do
        if (v.left == left or v.left == right) and (v.right == left or v.right == right) then
            edgeKey = k
            edge = v
        end
    end
    if edge == nil then
        return
    end
    
    local left = edge.left
    local right = edge.right
    edge:destroy()

    if not self:min_spanning_tree() then
        edge = left:connect(right, right.x - left.x, right.y - left.y)
        edge.weight = 99999
        self.edges[edgeKey] = edge
    end
end

function Graph:vertice_edges(vert)
    r = {}
    for k, v in pairs(self.edges) do
        if v.left == vert or v.right == vert then
            table.insert(r, v)
        end
    end
    return r
end

function Graph:pathfinding(x, y, exit)
    local root = self:coord(x, y)
    root.dijkstra_weight = 0
    local path = {}
    local visited = {}
    local to_visit = Queue:new()
    path[root] = nil
    
    function path.walk(node)
        if node ~= nil then
            node.color = colors.blue
            return path.walk(path[node])
        end
    end
    
    to_visit:push(root)

    while to_visit:size() > 0 do
        local node = to_visit:pop()
        table.insert(visited, node)
        local edges = self:vertice_edges(node)
        for k, v in pairs(edges) do
            if v.left ~= node then
                local new_weight = node.dijkstra_weight + v.weight
                if new_weight < v.left.dijkstra_weight then
                    path[v.left] = node
                    v.left.dijkstra_weight = new_weight
                end
                if not table.contains(visited, v.left) and not table.contains(to_visit.nodes, v.left) then
                    to_visit:push(v.left)
                end
            else
                local new_weight = node.dijkstra_weight + v.weight
                if new_weight < v.right.dijkstra_weight then
                    path[v.right] = node
                    v.right.dijkstra_weight = new_weight
                end
                if not table.contains(visited, v.right) and not table.contains(to_visit.nodes, v.right) then
                    to_visit:push(v.right)
                end
            end
        end
    end
    path.walk(exit)
    return exit.dijkstra_weight
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
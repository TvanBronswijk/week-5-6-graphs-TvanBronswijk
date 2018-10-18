function Graph:distance_to(x, y, vertice)
    local root = self:coord(x, y)
    
    local visited = {}
    local to_visit = Queue:new() 
    local paths = {}
    paths.parent = self
    function paths:count(node)
        if self.parent.draw_mode == 1 then
            node.color = colors.dark_red
        end
        if self[node] == nil then
            return 0
        end
        return 1 + self:count(self[node])
    end

    paths[root] = nil
    to_visit:push(root)
    
    while to_visit:size() > 0 do
        local node = to_visit:pop()
        if self.draw_mode == 1 then
            node.color = colors.orange
        end
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
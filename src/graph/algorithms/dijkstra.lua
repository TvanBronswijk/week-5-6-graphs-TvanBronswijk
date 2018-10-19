function Graph:pathfinding(x, y, exit)
    local root = self:coord(x, y)
    root.dijkstra_weight = 0
    local path = {}
    local visited = {}
    local to_visit = Queue:new()
    path[root] = nil
    function path.walk(node)
        if node ~= nil then
            if self.draw_mode == 2 then
                node.color = colors.purple
            end
            return path.walk(path[node])
        end
    end
    
    to_visit:push(root)

    while to_visit:size() > 0 do
        local node = to_visit:pop()
        table.insert(visited, node)
        if self.draw_mode == 2 then
            node.color = colors.pink
        end
        local edges = self:vertice_edges(node)
        for k, v in pairs(edges) do
            local nb = v:other(node)
            local new_weight = node.dijkstra_weight + v.weight
            if new_weight < nb.dijkstra_weight then
                nb.dijkstra_weight = new_weight
                path[nb] = node
            end
            if not table.contains(visited, nb) and not table.contains(to_visit.nodes, nb) then
                to_visit:push(nb)
            end
        end
    end
    path.walk(exit)
    return exit.dijkstra_weight
end
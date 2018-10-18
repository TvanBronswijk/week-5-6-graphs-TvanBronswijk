function Graph:min_spanning_tree()
    local mst = {}
    local root = self:coord(1, 1)
    local vertices = {}
    table.insert(vertices, root)

    while table.count(vertices) ~= table.count(self.vertices) do
        local edges = {}
        for _, v in pairs(vertices) do
            for _, e in pairs(self:vertice_edges(v)) do
                table.insert(edges, e)
            end
        end

        local m_edge = { weight = 100 }
        local new_vert = nil
        for _, v in pairs(edges) do
            if v.weight < m_edge.weight and not (table.contains(vertices, v.left) and table.contains(vertices, v.right)) then
                m_edge = v
                if table.contains(vertices, v.left) then
                    new_vert = v.right
                else
                    new_vert = v.left
                end
            end
        end
        m_edge.color = colors.dark_orange
        table.insert(mst, m_edge)
        table.insert(vertices, new_vert)
    end

    return mst
end
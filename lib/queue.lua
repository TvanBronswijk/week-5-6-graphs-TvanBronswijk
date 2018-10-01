local queue = class('Queue')


function queue:initialize()
    self.nodes = {}
end

function queue:push(e)
    table.insert(self.nodes, e)
end

function queue:pop()
    local e = self.nodes[1]
    table.remove(self.nodes, 1)
    return e
end

function queue:size()
    return #self.nodes
end

return queue
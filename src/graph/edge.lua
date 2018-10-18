local Edge = class('Edge')

function Edge:initialize(weight, accessible)
    self.weight = weight
    self.accessible = accessible
    self.left = nil
    self.right = nil
    self.color = colors.black
end

function Edge:vertical()
    return self.left.x == self.right.x
end

function Edge:horizontal()
    return self.left.y == self.right.y
end

function Edge:has_node(node)
    return (node == left or node == right)
end

function Edge:other(node)
    if node == self.left then
        return self.right
    elseif node == self.right then
        return self.left
    else
        return nil
    end
end

function Edge:destroy()
    self.accessible = false
    self.left.neighbours[table.key(self.left.neighbours, self.right)] = nil
    self.right.neighbours[table.key(self.right.neighbours, self.left)] = nil
end

function Edge:draw(x, y)
    if self.accessible then 
        console:print(tostring(self.weight), 
            x + math.floor((self.left.x*4 + self.right.x*4) / 2), 
            y + math.floor((self.left.y*4 + self.right.y*4) / 2),
            colors.white,
            self.color)
    else
        console:print('~', 
            x + math.floor((self.left.x*4 + self.right.x*4) / 2), 
            y + math.floor((self.left.y*4 + self.right.y*4) / 2),
            colors.white,
            self.color)
    end
end

return Edge
local Edge = class('Edge')

function Edge:initialize(weight, accessible)
    self.weight = weight
    self.accessible = accessible
    self.left = nil
    self.right = nil
end

function Edge:vertical()
    return self.left.x == self.right.x
end

function Edge:horizontal()
    return self.left.y == self.right.y
end

function Edge:draw(x, y)
    console:print(tostring(self.weight), 
        x + math.floor((self.left.x*4 + self.right.x*4) / 2), 
        y + math.floor((self.left.y*4 + self.right.y*4) / 2))
end

return Edge
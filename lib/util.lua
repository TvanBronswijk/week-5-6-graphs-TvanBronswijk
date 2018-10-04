function table.contains(table, e)
    for _, v in pairs(table) do
        if v == e then
            return true
        end
    end

    return false
end

function table.copy(table)
    local t = {}

    for _, v in pairs(table) do
        table.insert(t, v)
    end

    return t
end

function table.key(table, value)
    for k, v in pairs(table) do
        if v == value then
            return k
        end
    end
end

function table.count(table)
    i = 0
    for _,_ in pairs(table) do
        i = i + 1
    end
    return i
end

util = {}
function util.division(a,b)
    return (a - a % b) / b
end
return util
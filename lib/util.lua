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

util = {}
function util.division(a,b)
    return (a - a % b) / b
end
return util
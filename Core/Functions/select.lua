local M = {}

M['dynamic'] = function()
    return 'dynamic'
end

M['static'] = function()
    return 'static'
end

M['forward'] = function()
    return 'forward'
end

M['bounce'] = function()
    return 'bounce'
end

M['backgroundTrue'] = function()
    return true
end

M['backgroundFalse'] = function()
    return false
end

M['ruleTrue'] = function()
    return true
end

M['ruleFalse'] = function()
    return false
end

M['alignLeft'] = function()
    return 'left'
end

M['alignRight'] = function()
    return 'right'
end

M['alignCenter'] = function()
    return 'center'
end

M['inputDefault'] = function()
    return 'default'
end

M['inputNumber'] = function()
    return 'number'
end

M['inputDecimal'] = function()
    return 'decimal'
end

M['inputPhone'] = function()
    return 'phone'
end

M['inputUrl'] = function()
    return 'url'
end

M['inputEmail'] = function()
    return 'email'
end

M['inputNoEmoji'] = function()
    return 'noemoji'
end

return M

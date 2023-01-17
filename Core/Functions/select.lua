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

M['obj'] = function()
    return 'objects'
end

M['text'] = function()
    return 'texts'
end

M['group'] = function()
    return 'groups'
end

M['widget'] = function()
    return 'widgets'
end

M['tag'] = function()
    return 'tags'
end

M['switchRadio'] = function()
    return 'radio'
end

M['switchToggle'] = function()
    return 'onOff'
end

M['switchCheckbox'] = function()
    return 'checkbox'
end

M['switchOn'] = function()
    return true
end

M['switchOff'] = function()
    return false
end

return M

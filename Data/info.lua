local M = {}

M.listType = {
    'everyone',
    'events',
    'vars',
    'objects',
    'control',
    'none',
    'none',
    'none',
    'none',
    'shapes',
    'none',
    'none',
    'none',
    'none',
    'none'
}

M.listBlock = {
    ['events'] = {
        'onStart',
        'onFun',
        'onFunParams',
        'onTouchBegan',
        'onTouchEnded',
        'onTouchMoved'
    },

    ['vars'] = {
        'setVar',
        'updVar',
        'addTable',
        'resetTable',
        'newText',
        'newText2',
        'setText',
        'setTextPos',
        'setTextPosX',
        'setTextPosY',
        'setTextRotation',
        'setTextAlpha',
        'updTextPosX',
        'updTextPosY',
        'updTextRotation',
        'updTextAlpha',
        'saveValue'
    },

    ['objects'] = {
        'newObject',
        'setPos',
        'setPosX',
        'setPosY',
        'setSize',
        'setRotation',
        'setAlpha',
        'setWidth',
        'setHeight',
        'updPosX',
        'updPosY',
        'updSize',
        'updRotation',
        'updAlpha',
        'updWidth',
        'updHeight'
    },

    ['control'] = {
        'setListener',
        'setListener2',
        'setListener3',
        'requestFun',
        'requestFunParams',
        'timerEnd',
        'timer',
        'ifEnd',
        'if',
        'foreverEnd',
        'forever',
        'forEnd',
        'for',
        'requestApi',
        'requestExit'
    },

    ['shapes'] = {
        'newCircle',
        'newRoundedRect',
        'newRect',
        'setSprite',
        'setColor'
    }
}

M.listName = {
    -- events
    ['onStart'] = {'events', 'text'},
        ['onFun'] = {'events', 'fun'},
        ['onFunParams'] = {'events', 'fun', 'local'},
        ['onTouchBegan'] = {'events', 'fun', 'local'},
        ['onTouchEnded'] = {'events', 'fun', 'local'},
        ['onTouchMoved'] = {'events', 'fun', 'local'},

    -- vars
    ['setVar'] = {'vars', 'var', 'value'},
        ['updVar'] = {'vars', 'var', 'value'},
        ['addTable'] = {'vars', 'value', 'table', 'value'},
        ['resetTable'] = {'vars', 'table', 'value'},
        ['newText'] = {'vars', 'value', 'value', 'value', 'value', 'color', 'value', 'value', 'value'},
        ['newText2'] = {'vars', 'value', 'value', 'value', 'value', 'color', 'value', 'value', 'value', 'value', 'value'},
        ['setText'] = {'vars', 'value', 'value'},
        ['setTextPos'] = {'vars', 'value', 'value', 'value'},
        ['setTextPosX'] = {'vars', 'value', 'value'},
        ['setTextPosY'] = {'vars', 'value', 'value'},
        ['setTextRotation'] = {'vars', 'value', 'value'},
        ['setTextAlpha'] = {'vars', 'value', 'value'},
        ['updTextPosX'] = {'vars', 'value', 'value'},
        ['updTextPosY'] = {'vars', 'value', 'value'},
        ['updTextRotation'] = {'vars', 'value', 'value'},
        ['updTextAlpha'] = {'vars', 'value', 'value'},
        ['saveValue'] = {'vars', 'value', 'value'},

    -- objects
    ['newObject'] = {'objects', 'value', 'value', 'value', 'value'},
        ['setPos'] = {'objects', 'value', 'value', 'value'},
        ['setPosX'] = {'objects', 'value', 'value'},
        ['setPosY'] = {'objects', 'value', 'value'},
        ['setSize'] = {'objects', 'value', 'value'},
        ['setRotation'] = {'objects', 'value', 'value'},
        ['setAlpha'] = {'objects', 'value', 'value'},
        ['setWidth'] = {'objects', 'value', 'value'},
        ['setHeight'] = {'objects', 'value', 'value'},
        ['updPosX'] = {'objects', 'value', 'value'},
        ['updPosY'] = {'objects', 'value', 'value'},
        ['updSize'] = {'objects', 'value', 'value'},
        ['updRotation'] = {'objects', 'value', 'value'},
        ['updAlpha'] = {'objects', 'value', 'value'},
        ['updWidth'] = {'objects', 'value', 'value'},
        ['updHeight'] = {'objects', 'value', 'value'},

    -- control
    ['requestApi'] = {'control', 'text'},
        ['requestFun'] = {'control', 'fun'},
        ['requestFunParams'] = {'control', 'fun', 'table'},
        ['setListener'] = {'control', 'value', 'fun'},
        ['setListener2'] = {'control', 'value', 'fun', 'fun'},
        ['setListener3'] = {'control', 'value', 'fun', 'fun', 'fun'},
        ['timer'] = {'control', 'value', 'value'},
        ['timerEnd'] = {'control'},
        ['if'] = {'control', 'value'},
        ['ifEnd'] = {'control'},
        ['forever'] = {'control'},
        ['foreverEnd'] = {'control'},
        ['for'] = {'control', 'value'},
        ['forEnd'] = {'control'},
        ['requestExit'] = {'control'},

    -- shapes
    ['newRect'] = {'shapes', 'value', 'color', 'value', 'value', 'value', 'value'},
        ['newRoundedRect'] = {'shapes', 'value', 'value', 'value', 'value', 'value', 'value'},
        ['newCircle'] = {'shapes', 'value', 'value', 'value', 'value'},
        ['setSprite'] = {'shapes', 'value', 'value'},
        ['setColor'] = {'shapes', 'value', 'color'}
}

M.listNested = {
    ['forever'] = {'foreverEnd'},
    ['timer'] = {'timerEnd'},
    ['if'] = {'ifEnd'},
    ['for'] = {'forEnd'}
}

M.listBlock.everyone = {'onStart', 'onFun', 'newObject', 'setSize', 'setVar', 'newText', 'setText', 'timer', 'requestFun', 'setListener'}
M.listBlock._everyone = 'onStart, onFun, newObject, setPos, setSize, setVar, requestFun, setListener, setText, newText, timer'

for i = 1, #M.listType do
    if M.listType[i] ~= 'none' and M.listType[i] ~= 'everyone' then
        for j = 1, #M.listBlock[M.listType[i]] do
            local k = M.listBlock[M.listType[i]][j]
            if UTF8.sub(k, UTF8.len(k) - 2, UTF8.len(k)) ~= 'End' and not UTF8.find(M.listBlock._everyone, k .. ', ') then
                table.insert(M.listBlock.everyone, k)
            end
        end
    end
end

M.getType = function(name)
    return M.listName[name][1]
end

M.getBlockColor = function(name, comment, type)
    local type = type or M.getType(name)
    if comment or type == 'none' then return 0.6 end

    if type == 'events' then
        return 0.1, 0.6, 0.65
    elseif type == 'vars' then
        return 0.75, 0.6, 0.3
    elseif type == 'objects' then
        return 0.41, 0.68, 0.3
    elseif type == 'shapes' then
        return 0.16, 0.66, 0.45
    elseif type == 'control' then
        return 0.6, 0.55, 0.4
    elseif type == 'everyone' then
        return 0.15, 0.55, 0.4
    end
end

return M

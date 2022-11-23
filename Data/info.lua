local M = {}

M.listType = {
    'everyone',
    'events',
    'vars',
    'objects',
    'objects2',
    'control',
    'physics',
    'physics2',
    'groups',
    'shapes',
    'widgets',
    'widgets2',
    'none',
    'none',
    'custom'
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
        'saveValue',
        'setRandomSeed'
    },

    ['objects'] = {
        'newObject',
        'newSprite',
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
        'requestFun',
        'requestFunParams',
        'returnValue',
        'timerEnd',
        'timer',
        'ifEnd',
        'ifElse',
        'if',
        'foreverEnd',
        'forever',
        'repeatEnd',
        'repeat',
        'forEnd',
        'for',
        'comment',
        'requestApi',
        'requestExit'
    },

    ['shapes'] = {
        'newCircle',
        'newRoundedRect',
        'newRect',
        'newBitmap',
        'updBitmap',
        'setPixel',
        'setPixelRGB',
        'setBitmapSprite',
        'getBitmapSprite',
        'setColor',
        'setGradientPaint',
        'setStrokeWidth',
        'updStrokeWidth',
        'setStrokeColor',
        'setStrokeRGB'
    },

    ['objects2'] = {
        'setSprite',
        'setScale',
        'setScaleX',
        'setScaleY',
        'newSeqAnimation',
        'newParAnimation',
        'playAnimation',
        'pauseAnimation',
        'newMask',
        'addMaskToObject',
        'setMaskPos',
        'setMaskScale',
        'setMaskScaleX',
        'setMaskScaleY',
        'setMaskHitTrue',
        'setMaskHitFalse'
    },

    ['groups'] = {
        'newGroup',
        'removeGroup',
        'showGroup',
        'hideGroup',
        'addObject',
        'setGroupPos',
        'setGroupPosX',
        'setGroupPosY',
        'setGroupAlpha',
        'updGroupPosX',
        'updGroupPosY',
        'updGroupAlpha'
    },

    ['physics'] = {
        'setBody',
        'removeBody',
        'setBodyType',
        'setHitboxBox',
        'setHitboxCircle',
        'setHitboxMesh',
        'setHitboxPolygon',
        'updHitbox',
        'setGravity',
        'setLinearVelocity',
        'setLinearVelocityX',
        'setLinearVelocityY',
        'setSensor',
        'removeSensor',
        'setFixedRotation',
        'removeFixedRotation',
        'setWorldGravity',
        'setBullet',
        'removeBullet',
        'setAwake',
        'setAngularVelocity',
        'setAngularDamping',
        'setLinearDamping',
        'setForce',
        'setTorque',
        'setLinearImpulse',
        'setAngularImpulse'
    },

    ['physics2'] = {
        'setHitboxVisible',
        'removeHitboxVisible',
        'startPhysics',
        'stopPhysics',
        'setTextBody'
    },

    ['widgets'] = {
        'newWebView',
        'updWebViewSite',
        'removeWebView',
        'setWebViewPos',
        'setWebViewSize',
        'setWebViewFront',
        'setWebViewBack',
        'setWebViewLink',
        'newHSlider',
        'newVSlider',
        'removeSlider',
        'setSliderPos',
        'setSliderValue',
        'getSliderValue'
    },

    ['widgets2'] = {
        'newField',
        'newBox',
        'setFieldText',
        'setFieldPos',
        'setFieldSize',
        'setFieldRule',
        'removeField'
    },

    ['custom'] = {}
}

M.listName = {
    -- events
    ['onStart'] = {'events', 'text'},
        ['onFun'] = {'events', 'fun'},
        ['onFunParams'] = {'events', 'fun', 'localtable'},
        ['onTouchBegan'] = {'events', 'fun', 'localtable'},
        ['onTouchEnded'] = {'events', 'fun', 'localtable'},
        ['onTouchMoved'] = {'events', 'fun', 'localtable'},

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
        ['setRandomSeed'] = {'vars', 'value'},

    -- objects
    ['newObject'] = {'objects', 'value', 'value', 'value', 'value'},
        ['newSprite'] = {'objects', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value'},
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
        ['requestFunParams'] = {'control', 'fun', 'value'},
        ['returnValue'] = {'control', 'value'},
        ['setListener'] = {'control', 'value', 'fun'},
        ['timer'] = {'control', 'value', 'value'},
        ['timerEnd'] = {'control'},
        ['if'] = {'control', 'value'},
        ['ifElse'] = {'control', 'value'},
        ['ifEnd'] = {'control'},
        ['forever'] = {'control'},
        ['foreverEnd'] = {'control'},
        ['repeat'] = {'control', 'value'},
        ['repeatEnd'] = {'control'},
        ['for'] = {'control', 'value', 'value', 'localvar', 'value'},
        ['forEnd'] = {'control'},
        ['comment'] = {'control', 'value'},
        ['requestExit'] = {'control'},

    -- shapes
    ['newRect'] = {'shapes', 'value', 'color', 'value', 'value', 'value', 'value'},
        ['newRoundedRect'] = {'shapes', 'value', 'value', 'value', 'value', 'value', 'value'},
        ['newCircle'] = {'shapes', 'value', 'value', 'value', 'value'},
        ['newBitmap'] = {'shapes', 'value', 'value', 'value'},
        ['updBitmap'] = {'shapes', 'value'},
        ['setPixel'] = {'shapes', 'value', 'value', 'value', 'color'},
        ['setPixelRGB'] = {'shapes', 'value', 'value', 'value', 'value', 'value', 'value'},
        ['setBitmapSprite'] = {'shapes', 'value', 'value'},
        ['getBitmapSprite'] = {'shapes', 'value', 'value'},
        ['setColor'] = {'shapes', 'value', 'color'},
        ['setGradientPaint'] = {'shapes', 'value', 'color', 'color', 'value', 'value'},
        ['setStrokeWidth'] = {'shapes', 'value', 'value'},
        ['updStrokeWidth'] = {'shapes', 'value', 'value'},
        ['setStrokeColor'] = {'shapes','value', 'color'},
        ['setStrokeRGB'] = {'shapes','value','value','value','value'},

    -- objects2
    ['setSprite'] = {'objects2', 'value', 'value'},
        ['setScale'] = {'objects2', 'value', 'value'},
        ['setScaleX'] = {'objects2', 'value', 'value'},
        ['setScaleY'] = {'objects2', 'value', 'value'},
        ['newSeqAnimation'] = {'objects2', 'value', 'animation', 'value', 'value', 'value', 'value'},
        ['newParAnimation'] = {'objects2', 'value', 'value', 'animation', 'value', 'value'},
        ['playAnimation'] = {'objects2', 'value', 'value'},
        ['pauseAnimation'] = {'objects2', 'value', 'value'},
        ['newMask'] = {'objects2', 'value', 'value'},
        ['addMaskToObject'] = {'objects2', 'value', 'value'},
        ['setMaskPos'] = {'objects2', 'value', 'value', 'value'},
        ['setMaskScale'] = {'objects2', 'value', 'value'},
        ['setMaskScaleX'] = {'objects2', 'value', 'value'},
        ['setMaskScaleY'] = {'objects2', 'value', 'value'},
        ['setMaskHitTrue'] = {'objects2', 'value'},
        ['setMaskHitFalse'] = {'objects2', 'value'},

    -- groups
    ['newGroup'] = {'groups', 'value'},
        ['removeGroup'] = {'groups', 'value'},
        ['showGroup'] = {'groups', 'value'},
        ['hideGroup'] = {'groups', 'value'},
        ['addObject'] = {'groups', 'value', 'value'},
        ['setGroupPos'] = {'groups', 'value', 'value', 'value'},
        ['setGroupPosX'] = {'groups', 'value', 'value'},
        ['setGroupPosY'] = {'groups', 'value', 'value'},
        ['setGroupAlpha'] = {'groups', 'value', 'value'},
        ['updGroupPosX'] = {'groups', 'value', 'value'},
        ['updGroupPosY'] = {'groups', 'value', 'value'},
        ['updGroupAlpha'] = {'groups', 'value', 'value'},

    -- physics
    ['setBody'] = {'physics', 'value', 'body', 'value', 'value', 'value', 'value'},
        ['removeBody'] = {'physics', 'value'},
        ['setBodyType'] = {'physics', 'value', 'body'},
        ['setHitboxBox'] = {'physics', 'value', 'value', 'value', 'value', 'value', 'value'},
        ['setHitboxCircle'] = {'physics', 'value', 'value'},
        ['setHitboxMesh'] = {'physics', 'value', 'value'},
        ['setHitboxPolygon'] = {'physics', 'value', 'value'},
        ['updHitbox'] = {'physics', 'value'},
        ['setGravity'] = {'physics', 'value', 'value'},
        ['setLinearVelocity'] = {'physics', 'value', 'value', 'value'},
        ['setLinearVelocityX'] = {'physics', 'value', 'value'},
        ['setLinearVelocityY'] = {'physics', 'value', 'value'},
        ['setSensor'] = {'physics', 'value'},
        ['removeSensor'] = {'physics', 'value'},
        ['setFixedRotation'] = {'physics', 'value'},
        ['removeFixedRotation'] = {'physics', 'value'},
        ['setWorldGravity'] = {'physics', 'value', 'value'},
        ['setBullet'] = {'physics', 'value'},
        ['removeBullet'] = {'physics', 'value'},
        ['setAwake'] = {'physics', 'value'},
        ['setAngularVelocity'] = {'physics', 'value', 'value'},
        ['setAngularDamping'] = {'physics', 'value', 'value'},
        ['setLinearDamping'] = {'physics', 'value', 'value'},
        ['setForce'] = {'physics', 'value', 'value', 'value', 'value', 'value'},
        ['setTorque'] = {'physics', 'value', 'value'},
        ['setLinearImpulse'] = {'physics', 'value', 'value', 'value', 'value', 'value'},
        ['setAngularImpulse'] = {'physics', 'value', 'value'},

    -- physics2
    ['setTextBody'] = {'physics2', 'value', 'body', 'value', 'value', 'value', 'value'},
        ['setHitboxVisible'] = {'physics2'},
        ['removeHitboxVisible'] = {'physics2'},
        ['startPhysics'] = {'physics2'},
        ['stopPhysics'] = {'physics2'},

    -- widgets
    ['newWebView'] = {'widgets', 'value', 'value', 'value', 'value'},
        ['updWebViewSite'] = {'widgets', 'value'},
        ['removeWebView'] = {'widgets', 'value'},
        ['setWebViewPos'] = {'widgets', 'value', 'value', 'value'},
        ['setWebViewSize'] = {'widgets', 'value', 'value', 'value'},
        ['setWebViewFront'] = {'widgets', 'value'},
        ['setWebViewBack'] = {'widgets', 'value'},
        ['setWebViewLink'] = {'widgets', 'value', 'value'},
        ['newHSlider'] = {'widgets', 'value', 'value', 'value', 'value'},
        ['newVSlider'] = {'widgets', 'value', 'value', 'value', 'value'},
        ['removeSlider'] = {'widgets', 'value'},
        ['setSliderPos'] = {'widgets', 'value', 'value', 'value'},
        ['setSliderValue'] = {'widgets', 'value', 'value'},
        ['getSliderValue'] = {'widgets', 'value', 'var'},

    -- widgets2
    ['newField'] = {'widgets2', 'value', 'value', 'inputType', 'color', 'value', 'isBackground', 'textAlign', 'value'},
        ['newBox'] = {'widgets2', 'value', 'value', 'color', 'value', 'isBackground', 'textAlign', 'value'},
        ['removeField'] = {'widgets2', 'value'},
        ['setFieldPos'] = {'widgets2', 'value', 'value', 'value'},
        ['setFieldSize'] = {'widgets2', 'value', 'value', 'value'},
        ['setFieldRule'] = {'widgets2', 'value', 'rule'},
        ['setFieldText'] = {'widgets2', 'value', 'value'},

    -- custom
    ['_custom'] = {'custom'}
}

M.listNested = {
    ['forever'] = {'foreverEnd'},
    ['timer'] = {'timerEnd'},
    ['if'] = {'ifEnd'},
    ['repeat'] = {'repeatEnd'},
    ['for'] = {'forEnd'}
}

M.listBlock.everyone = {'onStart', 'onFun', 'newObject', 'setSize', 'setVar', 'newText', 'setText', 'timer', 'requestFun', 'setListener'}
M.listBlock._everyone = 'onStart, onFun, newObject, setPos, setSize, setVar, requestFun, setListener, setText, newText, timer'

for i = 1, #M.listType do
    if M.listType[i] ~= 'none' and M.listType[i] ~= 'everyone' then
        for j = 1, #M.listBlock[M.listType[i]] do
            local k = M.listBlock[M.listType[i]][j]
            if UTF8.sub(k, UTF8.len(k) - 2, UTF8.len(k)) ~= 'End' and k ~= 'ifElse' and not UTF8.find(M.listBlock._everyone, k .. ', ') then
                table.insert(M.listBlock.everyone, k)
            end
        end
    end
end

M.getType = function(name)
    return M.listName[name] and M.listName[name][1] or 'custom'
end

-- math.randomseed(os.time())
-- local r, g, b = math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255
-- print(r .. ', ' .. g .. ', ' .. b)

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
    elseif type == 'objects2' then
        return 0.76, 0.3, 0.4
    elseif type == 'groups' then
        return 0.73, 0.4, 0.28
    elseif type == 'physics' then
        return 0.6, 0.35, 0.8
    elseif type == 'physics2' then
        return 0.65, 0.35, 0.5
    elseif type == 'control' then
        return 0.6, 0.55, 0.4
    elseif type == 'widgets' then
        return 0.4, 0.45, 0.6
    elseif type == 'widgets2' then
        return 0.7, 0.5, 0.5
    elseif type == 'everyone' then
        return 0.15, 0.55, 0.4
    elseif type == 'custom' then
        return 0.36, 0.47, 0.5
    end
end

return M

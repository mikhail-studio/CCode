local M = {}

M.listType = {
    'everyone',
    'events',
    'vars',
    'objects',
    'objects2',
    'control',
    'physics',
    'transition',
    'groups',
    'shapes',
    'widgets',
    'snapshot',
    'network',
    'media',
    'custom'
}

M.listBlock = {
    ['events'] = {
        'onStart',
        'onFun',
        'onFunParams',
        'onTouchBegan',
        'onTouchEnded',
        'onTouchMoved',
        'onSliderMoved',
        'onWebViewCallback',
        'onFieldBegan',
        'onFieldEditing',
        'onFieldEnded'
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
        'setTextColor',
        'setTextRGB',
        'setTextHEX',
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
        'timerNameEnd',
        'timerName',
        'ifEnd',
        'ifElse',
        'if',
        'foreverEnd',
        'forever',
        'repeatEnd',
        'repeat',
        'forEnd',
        'for',
        'timerPause',
        'timerResume',
        'timerCancel',
        'timerPauseAll',
        'timerResumeAll',
        'timerCancelAll',
        'setFocus',
            'setFocusMultitouch',
            'activateMultitouch',
            'deactivateMultitouch',
            'toastShort',
            'toastLong',
            'comment',
            'requestApi',
            'requestExit'
    },

    ['shapes'] = {
        'setSprite',
        'newCircle',
        'newRoundedRect',
        'newRect',
        'setColor',
        'setRGB',
        'setHEX',
        'newBitmap',
        'updBitmap',
        'setPixel',
        'setPixelRGB',
        'setBitmapSprite',
        'getBitmapSprite',
        'setGradientPaint',
        'setStrokeWidth',
        'updStrokeWidth',
        'setStrokeColor',
        'setStrokeRGB'
    },

    ['objects2'] = {
        'newSeqAnimation',
        'newParAnimation',
        'playAnimation',
        'pauseAnimation',
        'setScale',
        'setScaleX',
        'setScaleY',
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
        'addGroupObject',
        'addGroupText',
        'addGroupWidget',
        'addGroupTag',
        'addGroupGroup',
        'setGroupPos',
        'setGroupSize',
        'setGroupRotation',
        'setGroupAlpha',
        'updGroupPosX',
        'updGroupPosY',
        'updGroupWidth',
        'updGroupHeight',
        'updGroupRotation',
        'updGroupAlpha',
        'newTag',
            'removeTag',
            'showTag',
            'hideTag',
            'addTagObject',
            'addTagText',
            'addTagWidget',
            'addTagGroup',
            'addTagTag',
            'setTagPos',
            'setTagSize',
            'setTagRotation',
            'setTagAlpha',
            'updTagPosX',
            'updTagPosY',
            'updTagWidth',
            'updTagHeight',
            'updTagRotation',
            'updTagAlpha'
    },

    ['physics'] = {
        'setBody',
        'setTextBody',
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
        'setAngularImpulse',
        'setHitboxVisible',
        'removeHitboxVisible',
        'startPhysics',
        'stopPhysics'
    },

    ['widgets'] = {
        'newWebView',
        'newHSlider',
        'newVSlider',
        'newField',
        'newBox',
        'removeWidget',
        'setWidgetPos',
        'setWidgetSize',
        'setWidgetListener',
        'updWebViewSite',
        'setWebViewLink',
        'setWebViewFront',
        'setWebViewBack',
        'setSliderValue',
        'setFieldSecure',
        'removeFieldSecure',
        'setFieldText',
        'setFieldRule'
    },

    ['media'] = {
        'newVideo',
        'newRemoteVideo',
        'loadSound',
        'loadStream',
        'playSound',
        'resumeMedia',
        'pauseMedia',
        'seekMedia',
        'setVolume',
        'fadeVolume',
        'stopSound',
        'stopTimerSound',
        'disposeSound',
        'removeVideo'
    },

    ['transition'] = {
        'setTransitionTo',
        'setTransitionPos',
        'setTransitionSize',
        'setTransitionScale',
        'setTransitionRotation',
        'setTransitionAlpha',
        'setTransitionAngles',
        'setTransitionPause',
        'setTransitionResume',
        'setTransitionCancel',
        'setTransitionPauseAll',
        'setTransitionResumeAll',
        'setTransitionCancelAll'
    },

    ['network'] = {
        'openURL',
        'createServer',
        'connectToServer',
        'requestGET',
        'requestPOST',
        'requestPUT',
        'requestPATCH',
        'requestHEAD',
        'requestDELETE',
        'firebasePUT',
        'firebasePATCH',
        'firebaseGET',
        'firebaseDELETE'
    },

    ['snapshot'] = {},
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
        ['onSliderMoved'] = {'events', 'fun', 'localvar'},
        ['onFieldBegan'] = {'events', 'fun', 'localtable'},
        ['onFieldEditing'] = {'events', 'fun', 'localtable'},
        ['onFieldEnded'] = {'events', 'fun', 'localtable'},
        ['onWebViewCallback'] = {'events', 'fun', 'localtable'},

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
        ['setTextColor'] = {'vars', 'value', 'value'},
        ['setTextRGB'] = {'vars', 'value', 'value', 'value', 'value'},
        ['setTextHEX'] = {'vars', 'value', 'value'},
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
    ['requestFun'] = {'control', 'fun'},
        ['requestFunParams'] = {'control', 'fun', 'value'},
        ['returnValue'] = {'control', 'value'},
        ['setListener'] = {'control', 'value', 'fun'},
        ['timer'] = {'control', 'value', 'value'},
        ['timerEnd'] = {'control'},
        ['timerName'] = {'control', 'value', 'value', 'value'},
        ['timerNameEnd'] = {'control'},
        ['timerPause'] = {'control', 'value'},
        ['timerResume'] = {'control', 'value'},
        ['timerCancel'] = {'control', 'value'},
        ['timerPauseAll'] = {'control'},
        ['timerResumeAll'] = {'control'},
        ['timerCancelAll'] = {'control'},
        ['if'] = {'control', 'value'},
        ['ifElse'] = {'control', 'value'},
        ['ifEnd'] = {'control'},
        ['forever'] = {'control'},
        ['foreverEnd'] = {'control'},
        ['repeat'] = {'control', 'value'},
        ['repeatEnd'] = {'control'},
        ['for'] = {'control', 'value', 'value', 'localvar', 'value'},
        ['forEnd'] = {'control'},
        ['setFocus'] = {'control', 'value'},
            ['toastShort'] = {'control', 'value'},
            ['toastLong'] = {'control', 'value'},
            ['comment'] = {'control', 'value'},
            ['requestExit'] = {'control'},
            ['requestApi'] = {'control', 'text'},
            ['setFocusMultitouch'] = {'control', 'value', 'value'},
            ['activateMultitouch'] = {'control'},
            ['deactivateMultitouch'] = {'control'},

    -- shapes
    ['newRect'] = {'shapes', 'value', 'color', 'value', 'value', 'value', 'value'},
        ['newRoundedRect'] = {'shapes', 'value', 'value', 'value', 'value', 'value', 'value'},
        ['newCircle'] = {'shapes', 'value', 'value', 'value', 'value'},
        ['setSprite'] = {'shapes', 'value', 'value'},
        ['setColor'] = {'shapes', 'value', 'color'},
        ['setRGB'] = {'shapes', 'value', 'value', 'value', 'value'},
        ['setHEX'] = {'shapes', 'value', 'value'},
        ['newBitmap'] = {'shapes', 'value', 'value', 'value'},
        ['updBitmap'] = {'shapes', 'value'},
        ['setPixel'] = {'shapes', 'value', 'value', 'value', 'color'},
        ['setPixelRGB'] = {'shapes', 'value', 'value', 'value', 'value', 'value', 'value'},
        ['setBitmapSprite'] = {'shapes', 'value', 'value'},
        ['getBitmapSprite'] = {'shapes', 'value', 'value'},
        ['setGradientPaint'] = {'shapes', 'value', 'color', 'color', 'value', 'value'},
        ['setStrokeWidth'] = {'shapes', 'value', 'value'},
        ['updStrokeWidth'] = {'shapes', 'value', 'value'},
        ['setStrokeColor'] = {'shapes','value', 'color'},
        ['setStrokeRGB'] = {'shapes','value','value','value','value'},

    -- objects2
    ['newSeqAnimation'] = {'objects2', 'value', 'animation', 'value', 'value', 'value', 'value'},
        ['newParAnimation'] = {'objects2', 'value', 'value', 'animation', 'value', 'value'},
        ['setScale'] = {'objects2', 'value', 'value'},
        ['setScaleX'] = {'objects2', 'value', 'value'},
        ['setScaleY'] = {'objects2', 'value', 'value'},
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
        ['addGroupObject'] = {'groups', 'value', 'value'},
        ['addGroupText'] = {'groups', 'value', 'value'},
        ['addGroupWidget'] = {'groups', 'value', 'value'},
        ['addGroupTag'] = {'groups', 'value', 'value'},
        ['addGroupGroup'] = {'groups', 'value', 'value'},
        ['setGroupPos'] = {'groups', 'value', 'value', 'value'},
        ['setGroupSize'] = {'groups', 'value', 'value', 'value'},
        ['setGroupRotation'] = {'groups', 'value', 'value'},
        ['setGroupAlpha'] = {'groups', 'value', 'value'},
        ['updGroupPosX'] = {'groups', 'value', 'value'},
        ['updGroupPosY'] = {'groups', 'value', 'value'},
        ['updGroupWidth'] = {'groups', 'value', 'value'},
        ['updGroupHeight'] = {'groups', 'value', 'value'},
        ['updGroupRotation'] = {'groups', 'value', 'value'},
        ['updGroupAlpha'] = {'groups', 'value', 'value'},
        ['newTag'] = {'groups', 'value'},
            ['removeTag'] = {'groups', 'value'},
            ['showTag'] = {'groups', 'value'},
            ['hideTag'] = {'groups', 'value'},
            ['addTagObject'] = {'groups', 'value', 'value'},
            ['addTagText'] = {'groups', 'value', 'value'},
            ['addTagWidget'] = {'groups', 'value', 'value'},
            ['addTagGroup'] = {'groups', 'value', 'value'},
            ['addTagTag'] = {'groups', 'value', 'value'},
            ['setTagPos'] = {'groups', 'value', 'value', 'value'},
            ['setTagSize'] = {'groups', 'value', 'value', 'value'},
            ['setTagRotation'] = {'groups', 'value', 'value'},
            ['setTagAlpha'] = {'groups', 'value', 'value'},
            ['updTagPosX'] = {'groups', 'value', 'value'},
            ['updTagPosY'] = {'groups', 'value', 'value'},
            ['updTagWidth'] = {'groups', 'value', 'value'},
            ['updTagHeight'] = {'groups', 'value', 'value'},
            ['updTagRotation'] = {'groups', 'value', 'value'},
            ['updTagAlpha'] = {'groups', 'value', 'value'},

    -- physics
    ['setBody'] = {'physics', 'value', 'body', 'value', 'value', 'value', 'value'},
        ['setTextBody'] = {'physics', 'value', 'body', 'value', 'value', 'value', 'value'},
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
        ['setHitboxVisible'] = {'physics'},
        ['removeHitboxVisible'] = {'physics'},
        ['startPhysics'] = {'physics'},
        ['stopPhysics'] = {'physics'},

    -- widgets
    ['newWebView'] = {'widgets', 'value', 'value', 'value', 'value'},
        ['newHSlider'] = {'widgets', 'value', 'value', 'fun', 'value', 'value'},
        ['newVSlider'] = {'widgets', 'value', 'value', 'fun', 'value', 'value'},
        ['newField'] = {'widgets', 'value', 'value', 'inputType', 'color', 'value', 'isBackground', 'textAlign', 'value', 'value', 'value', 'value', 'value'},
        ['newBox'] = {'widgets', 'value', 'value', 'color', 'value', 'isBackground', 'textAlign', 'value', 'value', 'value', 'value', 'value'},
        ['removeWidget'] = {'widgets', 'value'},
        ['setWidgetPos'] = {'widgets', 'value', 'value', 'value'},
        ['setWidgetSize'] = {'widgets', 'value', 'value', 'value'},
        ['setWidgetListener'] = {'widgets', 'value', 'fun'},
        ['updWebViewSite'] = {'widgets', 'value'},
        ['setWebViewLink'] = {'widgets', 'value', 'value'},
        ['setWebViewFront'] = {'widgets', 'value'},
        ['setWebViewBack'] = {'widgets', 'value'},
        ['setSliderValue'] = {'widgets', 'value', 'value'},
        ['setFieldSecure'] = {'widgets', 'value'},
        ['removeFieldSecure'] = {'widgets', 'value'},
        ['setFieldText'] = {'widgets', 'value', 'value'},
        ['setFieldRule'] = {'widgets', 'value', 'rule'},

    -- media
    ['newVideo'] = {'media', 'value', 'value', 'fun', 'value', 'value', 'value', 'value'},
        ['newRemoteVideo'] = {'media', 'value', 'value', 'fun', 'value', 'value', 'value', 'value'},
        ['loadSound'] = {'media', 'value', 'value'},
        ['loadStream'] = {'media', 'value', 'value'},
        ['playSound'] = {'media', 'value', 'value', 'fun', 'value', 'value'},
        ['resumeMedia'] = {'media', 'value'},
        ['pauseMedia'] = {'media', 'value'},
        ['seekMedia'] = {'media', 'value', 'value'},
        ['setVolume'] = {'media', 'value', 'value'},
        ['fadeVolume'] = {'media', 'value', 'value', 'value'},
        ['stopSound'] = {'media', 'value'},
        ['stopTimerSound'] = {'media', 'value', 'value'},
        ['disposeSound'] = {'media', 'value'},
        ['removeVideo'] = {'media', 'value'},

    -- transition
    ['setTransitionTo'] = {'transition', 'value', 'transitName', 'animation', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'transitEasing', 'fun', 'fun', 'fun', 'fun', 'fun'},
        ['setTransitionPos'] = {'transition', 'value', 'transitName', 'animation', 'value', 'value', 'value', 'value', 'transitEasing', 'fun', 'fun', 'fun', 'fun', 'fun'},
        ['setTransitionSize'] = {'transition', 'value', 'transitName', 'animation', 'value', 'value', 'value', 'value', 'transitEasing', 'fun', 'fun', 'fun', 'fun', 'fun'},
        ['setTransitionScale'] = {'transition', 'value', 'transitName', 'animation', 'value', 'value', 'value', 'value', 'transitEasing', 'fun', 'fun', 'fun', 'fun', 'fun'},
        ['setTransitionRotation'] = {'transition', 'value', 'animation', 'transitName', 'value', 'value', 'value', 'transitEasing', 'fun', 'fun', 'fun', 'fun', 'fun'},
        ['setTransitionAlpha'] = {'transition', 'value', 'animation', 'transitName', 'value', 'value', 'value', 'transitEasing', 'fun', 'fun', 'fun', 'fun', 'fun'},
        ['setTransitionAngles'] = {'transition', 'value', 'animation', 'transitName', 'value', 'value', 'value', 'transitEasing', 'fun', 'fun', 'fun', 'fun', 'fun'},
        ['setTransitionPause'] = {'transition', 'value', 'transitName'},
        ['setTransitionResume'] = {'transition', 'value', 'transitName'},
        ['setTransitionCancel'] = {'transition', 'value', 'transitName'},
        ['setTransitionPauseAll'] = {'transition'},
        ['setTransitionResumeAll'] = {'transition'},
        ['setTransitionCancelAll'] = {'transition'},

    -- network
    ['openURL'] = {'network', 'value'},
        ['createServer'] = {'network', 'value', 'fun'},
        ['connectToServer'] = {'network', 'value', 'value', 'fun'},
        ['requestGET'] = {'network', 'value', 'value', 'value', 'fun', 'networkProgress', 'networkRedirects', 'value'},
        ['requestPOST'] = {'network', 'value', 'value', 'value', 'fun', 'networkProgress', 'networkRedirects', 'value'},
        ['requestPUT'] = {'network', 'value', 'value', 'value', 'fun', 'networkProgress', 'networkRedirects', 'value'},
        ['requestPATCH'] = {'network', 'value', 'value', 'value', 'fun', 'networkProgress', 'networkRedirects', 'value'},
        ['requestHEAD'] = {'network', 'value', 'value', 'value', 'fun', 'networkProgress', 'networkRedirects', 'value'},
        ['requestDELETE'] = {'network', 'value', 'value', 'value', 'fun', 'networkProgress', 'networkRedirects', 'value'},
        ['firebasePUT'] = {'network', 'value', 'value', 'value', 'localvar'},
        ['firebasePATCH'] = {'network', 'value', 'value', 'value', 'localvar'},
        ['firebaseGET'] = {'network', 'value', 'value', 'localvar'},
        ['firebaseDELETE'] = {'network', 'value', 'value', 'localvar'},

    -- custom
    ['_custom'] = {'custom'}
}

M.listDelimiter = {
    ['groups'] = {'newTag'},
    ['control'] = {'setFocus'},
}

M.listNested = {
    ['forever'] = {'foreverEnd'},
    ['timer'] = {'timerEnd'},
    ['timerName'] = {'timerNameEnd'},
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
-- local r, g, b = math.random(0, 200) / 255, math.random(0, 200) / 255, math.random(0, 200) / 255
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
        return 0.6, 0.35, 0.75
    elseif type == 'transition' then
        return 0.65, 0.35, 0.5
    elseif type == 'control' then
        return 0.6, 0.55, 0.4
    elseif type == 'widgets' then
        return 0.4, 0.45, 0.6
    elseif type == 'media' then
        return 0.7, 0.5, 0.5
    elseif type == 'network' then
        return 0.2, 0.4, 0.7
    elseif type == 'snapshot' then
        return 0.38, 0.52, 0.46
    elseif type == 'everyone' then
        return 0.15, 0.55, 0.4
    elseif type == 'custom' then
        return 0.36, 0.47, 0.5
    end
end

return M

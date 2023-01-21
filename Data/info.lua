local M = {}

M.listType = {
    'everyone',
    'events',
    'vars',
    'objects',
    'media',
    'control',
    'physics',
    'transition',
    'groups',
    'shapes',
    'widgets',
    'snapshot',
    'network',
    'objects2',
    'custom'
}

M.listBlock = {
    ['events'] = {
        'onStart',
        'onFun',
        'onFunParams',
        'onCondition',
        'onTouchBegan',
        'onTouchEnded',
        'onTouchMoved',
        'onTouchDisplayBegan',
        'onTouchDisplayEnded',
        'onTouchDisplayMoved',
        'onFirebase',
        'onBackPress',
        'onSuspend',
        'onResume',
        'onLocalCollisionBegan',
            'onLocalCollisionEnded',
            'onLocalPreCollision',
            'onLocalPostCollision',
            'onGlobalCollisionBegan',
            'onGlobalCollisionEnded',
            'onGlobalPreCollision',
            'onGlobalPostCollision',
            'onSliderMoved',
            'onSwitchCallback',
            'onWebViewCallback',
            'onFieldBegan',
            'onFieldEditing',
            'onFieldEnded'
    },

    ['vars'] = {
        'setVar',
        'updVar',
        'newText',
        'newText2',
        'setText',
        'setTextSize',
        'hideText',
        'showText',
        'removeText',
        'setObjVar',
        'addTable',
        'insertTable',
        'removeTable',
        'resetTable',
        'saveValue',
        'setRandomSeed',
        'setTextPos',
            'setTextPosX',
            'setTextPosY',
            'setTextRotation',
            'setTextAnchor',
            'setTextAlpha',
            'setTextColor',
            'setTextRGB',
            'setTextHEX',
            'updTextPosX',
            'updTextPosY',
            'updTextRotation',
            'updTextAlpha',
            'frontText',
            'backText'
    },

    ['objects'] = {
        'newObject',
        'newSprite',
        'setPos',
        'setPosX',
        'setPosY',
        'setSize',
        'setRotation',
        'setRotationTo',
        'setAlpha',
        'setWidth',
        'setHeight',
        'setAnchor',
        'updPosX',
        'updPosY',
        'updSize',
        'updRotation',
        'updAlpha',
        'updWidth',
        'updHeight',
        'hideObject',
        'showObject',
        'removeObject',
        'frontObject',
        'backObject'
    },

    ['control'] = {
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
        'whileEnd',
        'while',
        'foreachEnd',
        'foreach',
        'break',
        'timerPause',
        'timerResume',
        'timerCancel',
        'timerPauseAll',
        'timerResumeAll',
        'timerCancelAll',
        'setListener',
            'setLocalCollision',
            'setLocalPreCollision',
            'setLocalPostCollision',
            'setGlobalCollision',
            'setGlobalPreCollision',
            'setGlobalPostCollision',
            'setFocus',
            'setFocusMultitouch',
            'activateMultitouch',
            'deactivateMultitouch',
            'toastShort',
            'toastLong',
            'comment',
            'requestApi',
            'requestExit',
        'setBackgroundColor',
            'setBackgroundRGB',
            'setBackgroundHEX',
            'setPortraitOrientation',
            'setLandscapeOrientation',
            'scheduleNotification',
            'setAccelerometerFrequency',
            'turnOnAccelerometer'
    },

    ['shapes'] = {
        'setSprite',
        'newCircle',
        'newRoundedRect',
        'newRect',
        'newPolygon',
        'setColor',
        'setRGB',
        'setHEX',
        'newLine',
        'appendLine',
        'newBitmap',
        'updBitmap',
        'setPixel',
        'setPixelRGB',
        'removePixel',
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
        'setFrame',
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
        'addGroupMedia',
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
            'addTagMedia',
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
        'setBullet',
        'removeBullet',
        'setWorldGravity',
            'setAwake',
            'disableCollision',
            'setBounce',
            'setFriction',
            'setTangentSpeed',
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
            'pausePhysics',
            'stopPhysics',
            'setTextBody'
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
        'setFieldRule',
        'setFieldFocus',
        'setFieldFocusNil',
        'hidePanelInterface',
        'showPanelInterface',
        'newScrollView',
            'newSwitch',
            'setSwitchState',
            'insertToScroll',
            'takeFocusScroll'
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
    ['onStart'] = {'events', 'value'},
        ['onFun'] = {'events', 'fun'},
        ['onFunParams'] = {'events', 'fun', 'localtable'},
        ['onCondition'] = {'events', 'value'},
        ['onTouchBegan'] = {'events', 'fun', 'localtable'},
        ['onTouchEnded'] = {'events', 'fun', 'localtable'},
        ['onTouchMoved'] = {'events', 'fun', 'localtable'},
        ['onTouchDisplayBegan'] = {'events', 'localtable'},
        ['onTouchDisplayEnded'] = {'events', 'localtable'},
        ['onTouchDisplayMoved'] = {'events', 'localtable'},
        ['onFirebase'] = {'events', 'fun', 'localvar'},
        ['onBackPress'] = {'events'},
        ['onSuspend'] = {'events'},
        ['onResume'] = {'events'},
        ['onLocalCollisionBegan'] = {'events', 'fun', 'localtable'},
            ['onLocalCollisionEnded'] = {'events', 'fun', 'localtable'},
            ['onLocalPreCollision'] = {'events', 'fun', 'localtable'},
            ['onLocalPostCollision'] = {'events', 'fun', 'localtable'},
            ['onGlobalCollisionBegan'] = {'events', 'fun', 'localtable'},
            ['onGlobalCollisionEnded'] = {'events', 'fun', 'localtable'},
            ['onGlobalPreCollision'] = {'events', 'fun', 'localtable'},
            ['onGlobalPostCollision'] = {'events', 'fun', 'localtable'},
            ['onSliderMoved'] = {'events', 'fun', 'localvar'},
            ['onSwitchCallback'] = {'events', 'fun', 'localvar'},
            ['onFieldBegan'] = {'events', 'fun', 'localtable'},
            ['onFieldEditing'] = {'events', 'fun', 'localtable'},
            ['onFieldEnded'] = {'events', 'fun', 'localtable'},
            ['onWebViewCallback'] = {'events', 'fun', 'localtable'},

        -- noob
        ['onConditionNoob'] = {'events', 'value'},
            ['onFunNoob'] = {'events', 'fun'},
            ['onTouchBeganNoob'] = {'events', 'value'},
            ['onTouchEndedNoob'] = {'events', 'value'},
            ['onTouchMovedNoob'] = {'events', 'value'},
            ['onLocalCollisionBeganNoob'] = {'events', 'value', 'value'},

    -- vars
    ['setVar'] = {'vars', 'var', 'value'},
        ['updVar'] = {'vars', 'var', 'value'},
        ['newText'] = {'vars', 'value', 'value', 'value', 'value', 'color', 'value', 'value', 'value'},
        ['newText2'] = {'vars', 'value', 'value', 'value', 'value', 'color', 'textAlign', 'value', 'value', 'value', 'value'},
        ['setText'] = {'vars', 'value', 'value'},
        ['setTextSize'] = {'vars', 'value', 'value'},
        ['hideText'] = {'vars', 'value'},
        ['showText'] = {'vars', 'value'},
        ['removeText'] = {'vars', 'value'},
        ['setObjVar'] = {'vars', 'value', 'value', 'value'},
        ['addTable'] = {'vars', 'value', 'table', 'value'},
        ['insertTable'] = {'vars', 'value', 'table', 'value'},
        ['removeTable'] = {'vars', 'table', 'value'},
        ['resetTable'] = {'vars', 'table', 'value'},
        ['saveValue'] = {'vars', 'value', 'value'},
        ['setRandomSeed'] = {'vars', 'value'},
        ['setTextPos'] = {'vars', 'value', 'value', 'value'},
            ['setTextPosX'] = {'vars', 'value', 'value'},
            ['setTextPosY'] = {'vars', 'value', 'value'},
            ['setTextRotation'] = {'vars', 'value', 'value'},
            ['setTextAnchor'] = {'vars', 'value', 'value', 'value'},
            ['setTextAlpha'] = {'vars', 'value', 'value'},
            ['setTextColor'] = {'vars', 'value', 'color'},
            ['setTextRGB'] = {'vars', 'value', 'value', 'value', 'value'},
            ['setTextHEX'] = {'vars', 'value', 'value'},
            ['updTextPosX'] = {'vars', 'value', 'value'},
            ['updTextPosY'] = {'vars', 'value', 'value'},
            ['updTextRotation'] = {'vars', 'value', 'value'},
            ['updTextAlpha'] = {'vars', 'value', 'value'},
            ['frontText'] = {'vars', 'value'},
            ['backText'] = {'vars', 'value'},

    -- objects
    ['newObject'] = {'objects', 'value', 'value', 'value', 'value'},
        ['newSprite'] = {'objects', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value'},
        ['setPos'] = {'objects', 'value', 'value', 'value'},
        ['setPosX'] = {'objects', 'value', 'value'},
        ['setPosY'] = {'objects', 'value', 'value'},
        ['setSize'] = {'objects', 'value', 'value'},
        ['setRotation'] = {'objects', 'value', 'value'},
        ['setRotationTo'] = {'objects', 'value', 'value'},
        ['setAlpha'] = {'objects', 'value', 'value'},
        ['setWidth'] = {'objects', 'value', 'value'},
        ['setHeight'] = {'objects', 'value', 'value'},
        ['setAnchor'] = {'objects', 'value', 'value', 'value'},
        ['updPosX'] = {'objects', 'value', 'value'},
        ['updPosY'] = {'objects', 'value', 'value'},
        ['updSize'] = {'objects', 'value', 'value'},
        ['updRotation'] = {'objects', 'value', 'value'},
        ['updAlpha'] = {'objects', 'value', 'value'},
        ['updWidth'] = {'objects', 'value', 'value'},
        ['updHeight'] = {'objects', 'value', 'value'},
        ['hideObject'] = {'objects', 'value'},
        ['showObject'] = {'objects', 'value'},
        ['removeObject'] = {'objects', 'value'},
        ['frontObject'] = {'objects', 'value'},
        ['backObject'] = {'objects', 'value'},

        -- noob
        ['newObjectNoob'] = {'objects', 'value', 'value', 'value'},
            ['setPosNoob'] = {'objects', 'value', 'value', 'value'},
            ['setPosXNoob'] = {'objects', 'value', 'value'},
            ['setPosYNoob'] = {'objects', 'value', 'value'},
            ['setSizeNoob'] = {'objects', 'value', 'value'},
            ['setRotationNoob'] = {'objects', 'value', 'value'},
            ['setAlphaNoob'] = {'objects', 'value', 'value'},
            ['setWidthNoob'] = {'objects', 'value', 'value'},
            ['setHeightNoob'] = {'objects', 'value', 'value'},
            ['updPosXNoob'] = {'objects', 'value', 'value'},
            ['updPosYNoob'] = {'objects', 'value', 'value'},
            ['updSizeNoob'] = {'objects', 'value', 'value'},
            ['updRotationNoob'] = {'objects', 'value', 'value'},
            ['updAlphaNoob'] = {'objects', 'value', 'value'},
            ['updWidthNoob'] = {'objects', 'value', 'value'},
            ['updHeightNoob'] = {'objects', 'value', 'value'},
            ['hideObjectNoob'] = {'objects', 'value'},
            ['showObjectNoob'] = {'objects', 'value'},
            ['removeObjectNoob'] = {'objects', 'value'},
            ['frontObjectNoob'] = {'objects', 'value'},
            ['backObjectNoob'] = {'objects', 'value'},

    -- control
    ['requestFun'] = {'control', 'fun'},
        ['requestFunNoob'] = {'control', 'fun'},
        ['requestFunParams'] = {'control', 'fun', 'value'},
        ['returnValue'] = {'control', 'value'},
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
        ['while'] = {'control', 'value'},
        ['whileEnd'] = {'control'},
        ['foreach'] = {'control', 'table', 'localvar'},
        ['foreachEnd'] = {'control'},
        ['break'] = {'control'},
        ['setListener'] = {'control', 'value', 'fun'},
            ['setLocalCollision'] = {'control', 'value', 'fun'},
            ['setLocalPreCollision'] = {'control', 'value', 'fun'},
            ['setLocalPostCollision'] = {'control', 'value', 'fun'},
            ['setGlobalCollision'] = {'control', 'fun'},
            ['setGlobalPreCollision'] = {'control', 'fun'},
            ['setGlobalPostCollision'] = {'control', 'fun'},
            ['setFocus'] = {'control', 'value'},
            ['toastShort'] = {'control', 'value'},
            ['toastLong'] = {'control', 'value'},
            ['comment'] = {'control', 'value'},
            ['requestExit'] = {'control'},
            ['requestApi'] = {'control', 'value'},
            ['setFocusMultitouch'] = {'control', 'value', 'value'},
            ['activateMultitouch'] = {'control'},
            ['deactivateMultitouch'] = {'control'},
        ['setBackgroundColor'] = {'control', 'color'},
            ['setBackgroundRGB'] = {'control', 'value', 'value', 'value'},
            ['setBackgroundHEX'] = {'control', 'value'},
            ['setPortraitOrientation'] = {'control', 'fun'},
            ['setLandscapeOrientation'] = {'control', 'fun'},
            ['scheduleNotification'] = {'control', 'value', 'value'},
            ['setAccelerometerFrequency'] = {'control', 'value'},
            ['turnOnAccelerometer'] = {'control', 'fun'},

    -- shapes
    ['newRect'] = {'shapes', 'value', 'color', 'value', 'value', 'value', 'value'},
        ['newRoundedRect'] = {'shapes', 'value', 'value', 'value', 'value', 'value', 'value'},
        ['newCircle'] = {'shapes', 'value', 'value', 'value', 'value'},
        ['newPolygon'] = {'shapes', 'value', 'value', 'value', 'value'},
        ['newLine'] = {'shapes', 'value', 'color', 'value', 'value', 'value', 'value'},
        ['appendLine'] = {'shapes', 'value', 'value'},
        ['setSprite'] = {'shapes', 'value', 'value'},
        ['setColor'] = {'shapes', 'value', 'color'},
        ['setRGB'] = {'shapes', 'value', 'value', 'value', 'value'},
        ['setHEX'] = {'shapes', 'value', 'value'},
        ['newBitmap'] = {'shapes', 'value', 'value', 'value'},
        ['updBitmap'] = {'shapes', 'value'},
        ['setPixel'] = {'shapes', 'value', 'value', 'value', 'color'},
        ['setPixelRGB'] = {'shapes', 'value', 'value', 'value', 'value', 'value', 'value'},
        ['removePixel'] = {'shapes', 'value', 'value', 'value'},
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
        ['setFrame'] = {'objects2', 'value', 'value'},
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
        ['addGroupMedia'] = {'groups', 'value', 'value'},
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
            ['addTagMedia'] = {'groups', 'value', 'value'},
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
    ['setBody'] = {'physics', 'value', 'body', 'value', 'value', 'value', 'value', 'value', 'value'},
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
        ['setBullet'] = {'physics', 'value'},
        ['removeBullet'] = {'physics', 'value'},
        ['setWorldGravity'] = {'physics', 'value', 'value'},
            ['setAwake'] = {'physics', 'value'},
            ['disableCollision'] = {'physics', 'value'},
            ['setBounce'] = {'physics', 'value', 'value'},
            ['setFriction'] = {'physics', 'value', 'value'},
            ['setTangentSpeed'] = {'physics', 'value', 'value'},
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
            ['pausePhysics'] = {'physics'},
            ['stopPhysics'] = {'physics'},
            ['setTextBody'] = {'physics', 'value', 'body', 'value', 'value', 'value', 'value'},

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
        ['setFieldFocus'] = {'widgets', 'value'},
        ['setFieldFocusNil'] = {'widgets'},
        ['hidePanelInterface'] = {'widgets'},
        ['showPanelInterface'] = {'widgets'},
        ['newScrollView'] = {'widgets', 'value', 'isBackground', 'fun', 'isBackground', 'value', 'isBackground', 'isBackground', 'color', 'isBackground', 'value', 'value', 'value', 'value'},
            ['newSwitch'] = {'widgets', 'value', 'switchType', 'switchState', 'value', 'value', 'value', 'value', 'fun', 'fun'},
            ['setSwitchState'] = {'widgets', 'value', 'switchState'},
            ['insertToScroll'] = {'widgets', 'value', 'value', 'scrollType'},
            ['takeFocusScroll'] = {'widgets', 'value', 'value'},

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
    ['setTransitionTo'] = {'transition', 'value', 'transitName', 'animation', 'value', 'value', 'value', 'value', 'value',
        'value', 'value', 'value', 'value', 'value', 'transitEasing', 'fun', 'fun', 'fun', 'fun', 'fun'},
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
        ['firebasePUT'] = {'network', 'value', 'value', 'value', 'fun'},
        ['firebasePATCH'] = {'network', 'value', 'value', 'value', 'fun'},
        ['firebaseGET'] = {'network', 'value', 'value', 'fun'},
        ['firebaseDELETE'] = {'network', 'value', 'value', 'fun'},

    -- custom
    ['_custom'] = {'custom'}
}

M.listDelimiter = {
    ['groups'] = {'newTag'},
    ['control'] = {'setListener', 'setBackgroundColor'},
    ['vars'] = {'setTextPos'},
    ['events'] = {'onLocalCollisionBegan'},
    ['physics'] = {'setWorldGravity'},
    ['widgets'] = {'newScrollView'}
}

M.listDelimiterNoob = {
    ['groups'] = {'newTag'},
    ['control'] = {'timerPauseAll'},
    ['vars'] = {'setTextPos'},
    ['physics'] = {'setWorldGravity'}
}

M.listNested = {
    ['forever'] = {'foreverEnd'},
    ['timer'] = {'timerEnd'},
    ['timerName'] = {'timerNameEnd'},
    ['if'] = {'ifEnd'},
    ['repeat'] = {'repeatEnd'},
    ['for'] = {'forEnd'},
    ['while'] = {'whileEnd'},
    ['foreach'] = {'foreachEnd'}
}

M.listDelimiterCopy = COPY_TABLE(M.listDelimiter)
M.listBlock.everyone = {'onStart', 'onFun', 'newObject', 'setSize', 'setVar', 'newText', 'setText', 'timer', 'requestFun', 'setListener'}
M.listBlock._everyone = 'onStart, onFun, newObject, setSize, setVar, newText, setText, timer, requestFun, setListener'

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

M.listBlockNoob = COPY_TABLE(M.listBlock)
M.listBlockCopy = COPY_TABLE(M.listBlock)
M.listDeleteType = {[11] = 'widgets', [12] = 'snapshot', [13] = 'network', [14] = 'objects2', [15] = 'custom'}

for type, blocks in pairs(M.listBlock) do
    if type ~= 'everyone' and type ~= '_everyone' then
        for index, block in pairs(blocks) do
            if M.listName[block .. 'Noob'] then
                M.listBlockNoob.everyone[table.indexOf(M.listBlockNoob.everyone, block)] = block .. 'Noob'
                M.listBlockNoob[type][table.indexOf(M.listBlockNoob[type], block)] = block .. 'Noob'
            end
        end
    end
end

local blocksDelete = {
    ['onFunParams'] = 'events',
        ['onFirebase'] = 'events',
        ['onSuspend'] = 'events',
        ['onResume'] = 'events',
        ['onLocalCollisionEnded'] = 'events',
        ['onLocalPreCollision'] = 'events',
        ['onLocalPostCollision'] = 'events',
        ['onGlobalCollisionBegan'] = 'events',
        ['onGlobalCollisionBeganEnded'] = 'events',
        ['onGlobalPreCollision'] = 'events',
        ['onGlobalPostCollision'] = 'events',
        ['onSliderMoved'] = 'events',
        ['onWebViewCallback'] = 'events',
        ['onFieldBegan'] = 'events',
        ['onFieldEditing'] = 'events',
        ['onFieldEnded'] = 'events',

    ['newSprite'] = 'objects',
        ['setAnchor'] = 'objects',

    ['setListener'] = 'control',
        ['requestFunParams'] = 'control',
        ['for'] = 'control',
        ['while'] = 'control',
        ['foreach'] = 'control',
        ['break'] = 'control',
        ['setLocalCollision'] = 'control',
        ['setLocalPreCollision'] = 'control',
        ['setLocalPostCollision'] = 'control',
        ['setGlobalCollision'] = 'control',
        ['setGlobalPreCollision'] = 'control',
        ['setGlobalPostCollision'] = 'control',
        ['setFocus'] = 'control',
        ['setFocusMultitouch'] = 'control',
        ['requestApi'] = 'control'
}

for index, type in pairs(M.listDeleteType) do
    for index, block in pairs(M.listBlock[type]) do
        blocksDelete[block] = type
    end
end

for block, type in pairs(blocksDelete) do
    table.remove(M.listBlockNoob.everyone, table.indexOf(M.listBlockNoob.everyone, block))
    table.remove(M.listBlockNoob[type], table.indexOf(M.listBlockNoob[type], block))
end

table.remove(M.listBlockNoob.everyone, 4) table.remove(M.listBlockNoob.everyone, 6)
table.remove(M.listBlockNoob.everyone, table.indexOf(M.listBlockNoob.everyone, 'onConditionNoob'))
table.insert(M.listBlockNoob.everyone, 3, 'onConditionNoob')

M.getType = function(name)
    return M.listName[name] and M.listName[name][1] or 'custom'
end

-- math.randomseed(os.time())
-- local r, g, b = math.random(0, 200) / 255, math.random(0, 200) / 255, math.random(0, 200) / 255
-- print(r .. ', ' .. g .. ', ' .. b)

M.getBlockColor = function(name, comment, type, color, lock)
    local type = type or M.getType(name)
    if lock then return 0.3, 0.3, 0.3 end
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
        if color then return unpack(color)
        elseif name then
            local custom, name = GET_GAME_CUSTOM(), UTF8.gsub(name, '_', '', 1) local index = UTF8.gsub(name, 'custom', '', 1)
            if index == '' and _G.type(BLOCKS.custom) == 'table' and _G.type(BLOCKS.custom.color) == 'table' then
            return unpack({BLOCKS.custom.color[1] / 255, BLOCKS.custom.color[2] / 255, BLOCKS.custom.color[3] / 255})
            end color = index and (custom[index] and custom[index][5] or nil) or nil
            return unpack(_G.type(color) == 'table' and {color[1] / 255, color[2] / 255, color[3] / 255} or {0.36, 0.47, 0.5})
        end return 0.36, 0.47, 0.5
    end
end

return M

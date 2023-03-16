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
        'setTextSize',
        'setText',
        'setObjVar',
        'addTable',
        'insertTable',
        'removeTable',
        'resetTable',
        'saveValue',
        'setRandomSeed',
        'hideText',
        'showText',
        'removeText',
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
        'newGif',
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
            'setListener3',
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
            'requestApiRes',
            'requestExit',
        'setBackgroundColor',
            'setBackgroundRGB',
            'setBackgroundHEX',
            'newLevel',
            'removeLevel',
            'showLevel',
            'hideLevel',
            'setPortraitOrientation',
            'setLandscapeOrientation',
            'scheduleNotification',
            'cancelNotification',
            'setAccelerometerFrequency',
            'turnOnAccelerometer',
            'readFileRes',
            'pasteboardCopy',
            'pasteboardPaste',
            'pasteboardClear'
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
        'frontGroup',
        'backGroup',
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
            'updTagAlpha',
            'frontTag',
            'backTag'
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
            'takeFocusScroll',
            'removeWidget',
            'showWidget',
            'hideWidget'
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

    ['snapshot'] = {
        'newSnapshot',
        'invalidateSnapshot',
        'addToSnapshot',
        'removeFromSnapshot',
        'setSnapshotColor',
        'setSnapshotPos',
        'setSnapshotSize',
        'setSnapshotRotation',
        'setSnapshotAlpha',
        'updSnapshotPosX',
        'updSnapshotPosY',
        'updSnapshotWidth',
        'updSnapshotHeight',
        'updSnapshotRotation',
        'updSnapshotAlpha',
        'frontSnapshot',
        'backSnapshot',
        'removeSnapshot',
        'showSnapshot',
        'hideSnapshot'
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
        'firebaseDELETE',
        'initAdsStartApp',
        'loadAdsStartApp',
        'showAdsStartApp'
    },

    ['custom'] = {}
}

M.listName = {
    -- events
    ['onStart'] = {'events', {'value'}},
        ['onFun'] = {'events', {'fun'}},
        ['onFunParams'] = {'events', {'fun'}, {'localtable'}},
        ['onCondition'] = {'events', {'value'}},
        ['onTouchBegan'] = {'events', {'fun'}, {'localtable'}},
        ['onTouchEnded'] = {'events', {'fun'}, {'localtable'}},
        ['onTouchMoved'] = {'events', {'fun'}, {'localtable'}},
        ['onTouchDisplayBegan'] = {'events', {'localtable'}},
        ['onTouchDisplayEnded'] = {'events', {'localtable'}},
        ['onTouchDisplayMoved'] = {'events', {'localtable'}},
        ['onFirebase'] = {'events', {'fun'}, {'localvar'}},
        ['onBackPress'] = {'events'},
        ['onSuspend'] = {'events'},
        ['onResume'] = {'events'},
        ['onLocalCollisionBegan'] = {'events', {'fun'}, {'localtable'}},
            ['onLocalCollisionEnded'] = {'events', {'fun'}, {'localtable'}},
            ['onLocalPreCollision'] = {'events', {'fun'}, {'localtable'}},
            ['onLocalPostCollision'] = {'events', {'fun'}, {'localtable'}},
            ['onGlobalCollisionBegan'] = {'events', {'fun'}, {'localtable'}},
            ['onGlobalCollisionEnded'] = {'events', {'fun'}, {'localtable'}},
            ['onGlobalPreCollision'] = {'events', {'fun'}, {'localtable'}},
            ['onGlobalPostCollision'] = {'events', {'fun'}, {'localtable'}},
            ['onSliderMoved'] = {'events', {'fun'}, {'localvar'}},
            ['onSwitchCallback'] = {'events', {'fun'}, {'localvar'}},
            ['onFieldBegan'] = {'events', {'fun'}, {'localtable'}},
            ['onFieldEditing'] = {'events', {'fun'}, {'localtable'}},
            ['onFieldEnded'] = {'events', {'fun'}, {'localtable'}},
            ['onWebViewCallback'] = {'events', {'fun'}, {'localtable'}},

        -- noob
        ['onConditionNoob'] = {'events', {'value'}},
            ['onFunNoob'] = {'events', {'fun'}},
            ['onTouchBeganNoob'] = {'events', {'value'}},
            ['onTouchEndedNoob'] = {'events', {'value'}},
            ['onTouchMovedNoob'] = {'events', {'value'}},
            ['onTouchDisplayBeganNoob'] = {'events'},
            ['onTouchDisplayEndedNoob'] = {'events'},
            ['onTouchDisplayMovedNoob'] = {'events'},
            ['onLocalCollisionBeganNoob'] = {'events', {'value'}, {'value'}},

    -- vars
    ['setVar'] = {'vars', {'var'}, {'value'}},
        ['updVar'] = {'vars', {'var'}, {'value'}},
        ['newText'] = {'vars', {'value'}, {'value'}, {'value', {'ubuntu', 't'}}, {'value', {'36', 'n'}},
            {'color', {'[255, 255, 255]', 'c'}}, {'value', {'100', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['newText2'] = {'vars', {'value'}, {'value'}, {'value', {'ubuntu', 't'}}, {'value', {'36', 'n'}},
            {'color', {'[255, 255, 255]', 'c'}}, {'textAlign', {'alignCenter', 'sl'}}, {'value'}, {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['setTextSize'] = {'vars', {'value'}, {'value', {'36', 'n'}}},
        ['setText'] = {'vars', {'value'}, {'value'}},
        ['setObjVar'] = {'vars', {'value', {'KEY', 't'}}, {'value'}, {'value'}},
        ['addTable'] = {'vars', {'value', {'KEY', 't'}}, {'table'}, {'value'}},
        ['insertTable'] = {'vars', {'value', {'1', 'n'}}, {'table'}, {'value'}},
        ['removeTable'] = {'vars', {'table'}, {'value', {'1', 'n'}}},
        ['resetTable'] = {'vars', {'table'}, {'value', {'{}', 't'}}},
        ['saveValue'] = {'vars', {'value', {'KEY', 't'}}, {'value'}},
        ['setRandomSeed'] = {'vars', {'value'}},
        ['hideText'] = {'vars', {'value'}},
        ['showText'] = {'vars', {'value'}},
        ['removeText'] = {'vars', {'value'}},
        ['setTextPos'] = {'vars', {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
            ['setTextPosX'] = {'vars', {'value'}, {'value', {'0', 'n'}}},
            ['setTextPosY'] = {'vars', {'value'}, {'value', {'0', 'n'}}},
            ['setTextRotation'] = {'vars', {'value'}, {'value', {'0', 'n'}}},
            ['setTextAnchor'] = {'vars', {'value'}, {'value', {'50', 'n'}}, {'value', {'50', 'n'}}},
            ['setTextAlpha'] = {'vars', {'value'}, {'value', {'100', 'n'}}},
            ['setTextColor'] = {'vars', {'value'}, {'color', {'[255, 255, 255]', 'c'}}},
            ['setTextRGB'] = {'vars', {'value'}, {'value', {'255', 'n'}}, {'value', {'255', 'n'}}, {'value', {'255', 'n'}}},
            ['setTextHEX'] = {'vars', {'value'}, {'value', {'#ffffff', 't'}}},
            ['updTextPosX'] = {'vars', {'value'}, {'value', {'0', 'n'}}},
            ['updTextPosY'] = {'vars', {'value'}, {'value', {'0', 'n'}}},
            ['updTextRotation'] = {'vars', {'value'}, {'value', {'0', 'n'}}},
            ['updTextAlpha'] = {'vars', {'value'}, {'value', {'0', 'n'}}},
            ['frontText'] = {'vars', {'value'}},
            ['backText'] = {'vars', {'value'}},

        -- noob
        ['setVarNoob'] = {'vars', {'var'}, {'value'}},
            ['updVarNoob'] = {'vars', {'var'}, {'value'}},
            ['saveValueNoob'] = {'vars', {'var'}},
            ['readValueNoob'] = {'vars', {'var'}},

    -- objects
    ['newObject'] = {'objects', {'value'}, {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['newSprite'] = {'objects', {'value'}, {'value'}, {'value'}, {'value'}, {'value'}, {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['newGif'] = {'objects', {'value'}, {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['setPos'] = {'objects', {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['setPosX'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
        ['setPosY'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
        ['setSize'] = {'objects', {'value'}, {'value', {'100', 'n'}}},
        ['setRotation'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
        ['setRotationTo'] = {'objects', {'value'}, {'value'}},
        ['setAlpha'] = {'objects', {'value'}, {'value', {'100', 'n'}}},
        ['setWidth'] = {'objects', {'value'}, {'value', {'100', 'n'}}},
        ['setHeight'] = {'objects', {'value'}, {'value', {'100', 'n'}}},
        ['setAnchor'] = {'objects', {'value'}, {'value', {'50', 'n'}}, {'value', {'50', 'n'}}},
        ['updPosX'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
        ['updPosY'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
        ['updSize'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
        ['updRotation'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
        ['updAlpha'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
        ['updWidth'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
        ['updHeight'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
        ['hideObject'] = {'objects', {'value'}},
        ['showObject'] = {'objects', {'value'}},
        ['removeObject'] = {'objects', {'value'}},
        ['frontObject'] = {'objects', {'value'}},
        ['backObject'] = {'objects', {'value'}},

        -- noob
        ['newObjectNoob'] = {'objects', {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
            ['newGifNoob'] = {'objects', {'value'}, {'value', {'1', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
            ['setPosNoob'] = {'objects', {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
            ['setPosXNoob'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
            ['setPosYNoob'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
            ['setSizeNoob'] = {'objects', {'value'}, {'value', {'100', 'n'}}},
            ['setRotationNoob'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
            ['setRotationToNoob'] = {'objects', {'value'}, {'value'}},
            ['setAlphaNoob'] = {'objects', {'value'}, {'value', {'100', 'n'}}},
            ['setWidthNoob'] = {'objects', {'value'}, {'value', {'100', 'n'}}},
            ['setHeightNoob'] = {'objects', {'value'}, {'value', {'100', 'n'}}},
            ['updPosXNoob'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
            ['updPosYNoob'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
            ['updSizeNoob'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
            ['updRotationNoob'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
            ['updAlphaNoob'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
            ['updWidthNoob'] = {'objects', {'value'}, {'value', {'0', 'n'}}},
            ['updHeightNoob'] = {'objects', {'value'}, {'value', {'0', 'n'}}},

    -- control
    ['requestFun'] = {'control', {'fun'}},
        ['requestFunNoob'] = {'control', {'fun'}},
        ['requestFunParams'] = {'control', {'fun'}, {'value'}},
        ['returnValue'] = {'control', {'value'}},
        ['timer'] = {'control', {'value', {'1', 'n'}}, {'value', {'1', 'n'}}},
        ['timerEnd'] = {'control'},
        ['timerName'] = {'control', {'value'}, {'value', {'1', 'n'}}, {'value', {'1', 'n'}}},
        ['timerNameEnd'] = {'control'},
        ['timerPause'] = {'control', {'value'}},
        ['timerResume'] = {'control', {'value'}},
        ['timerCancel'] = {'control', {'value'}},
        ['timerPauseAll'] = {'control'},
        ['timerResumeAll'] = {'control'},
        ['timerCancelAll'] = {'control'},
        ['if'] = {'control', {'value'}},
        ['ifElse'] = {'control', {'value'}},
        ['ifEnd'] = {'control'},
        ['forever'] = {'control'},
        ['foreverEnd'] = {'control'},
        ['repeat'] = {'control', {'value', {'10', 'n'}}},
        ['repeatEnd'] = {'control'},
        ['for'] = {'control', {'value', {'1', 'n'}}, {'value', {'10', 'n'}}, {'localvar'}, {'value', {'1', 'n'}}},
        ['forEnd'] = {'control'},
        ['while'] = {'control', {'value'}},
        ['whileEnd'] = {'control'},
        ['foreach'] = {'control', {'table'}, {'localvar'}, {'localvar'}},
        ['foreachEnd'] = {'control'},
        ['break'] = {'control'},
        ['setListener'] = {'control', {'value'}, {'fun'}},
            ['setListener3'] = {'control', {'value'}, {'fun'}, {'fun'}, {'fun'}},
            ['setLocalCollision'] = {'control', {'value'}, {'fun'}},
            ['setLocalPreCollision'] = {'control', {'value'}, {'fun'}},
            ['setLocalPostCollision'] = {'control', {'value'}, {'fun'}},
            ['setGlobalCollision'] = {'control', {'fun'}},
            ['setGlobalPreCollision'] = {'control', {'fun'}},
            ['setGlobalPostCollision'] = {'control', {'fun'}},
            ['setFocus'] = {'control', {'value'}},
            ['toastShort'] = {'control', {'value'}},
            ['toastLong'] = {'control', {'value'}},
            ['comment'] = {'control', {'value'}},
            ['requestExit'] = {'control'},
            ['requestApi'] = {'control', {'value', {'display.newText(\'0\', CENTER_X, CENTER_Y, nil, 50)', 't'}}},
            ['requestApiRes'] = {'control', {'value'}},
            ['setFocusMultitouch'] = {'control', {'value'}, {'value'}},
            ['activateMultitouch'] = {'control'},
            ['deactivateMultitouch'] = {'control'},
        ['setBackgroundColor'] = {'control', {'color', {'[0, 0, 0]', 'c'}}},
            ['setBackgroundRGB'] = {'control', {'value', {'0', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
            ['setBackgroundHEX'] = {'control', {'value', {'#000000', 't'}}},
            ['newLevel'] = {'control', {'value'}},
            ['removeLevel'] = {'control', {'value'}},
            ['showLevel'] = {'control', {'value'}},
            ['hideLevel'] = {'control', {'value'}},
            ['setPortraitOrientation'] = {'control', {'fun'}},
            ['setLandscapeOrientation'] = {'control', {'fun'}},
            ['scheduleNotification'] = {'control', {'value'}, {'value', {'1', 'n'}}},
            ['cancelNotification'] = {'control'},
            ['setAccelerometerFrequency'] = {'control', {'value', {'10', 'n'}}},
            ['turnOnAccelerometer'] = {'control', {'fun'}},
            ['readFileRes'] = {'control', {'var'}, {'value'}},
            ['pasteboardCopy'] = {'control', {'value'}},
            ['pasteboardPaste'] = {'control', {'var'}},
            ['pasteboardClear'] = {'control'},

    -- shapes
    ['newCircle'] = {'shapes', {'value'}, {'value', {'50', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['newRect'] = {'shapes', {'value'}, {'color', {'[255, 255, 255]', 'c'}},
            {'value', {'100', 'n'}}, {'value', {'100', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['newRoundedRect'] = {'shapes', {'value'}, {'value', {'10', 'n'}}, {'value', {'100', 'n'}},
            {'value', {'100', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['newPolygon'] = {'shapes', {'value'}, {'value', {{'totable', 'f'}, {'(', 's'},
            {'[0, 110, 27, 35, 105, 35, 43, -16, 65, -90, 0, -45, -65, -90, -43, -15, -105, 35, -27, 35]', 't'}, {')', 's'}}},
            {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['newLine'] = {'shapes', {'value'}, {'color', {'[255, 255, 255]', 'c'}},
            {'value', {'0', 'n'}}, {'value', {'200', 'n'}}, {'value', {'0', 'n'}}, {'value', {'-200', 'n'}}},
        ['appendLine'] = {'shapes', {'value'}, {'value'}},
        ['setSprite'] = {'shapes', {'value'}, {'value'}},
        ['setColor'] = {'shapes', {'value'}, {'color', {'[255, 255, 255]', 'c'}}},
        ['setRGB'] = {'shapes', {'value'}, {'value', {'255', 'n'}}, {'value', {'255', 'n'}}, {'value', {'255', 'n'}}},
        ['setHEX'] = {'shapes', {'value'}, {'value', {'#ffffff', 't'}}},
        ['newBitmap'] = {'shapes', {'value'}, {'value', {'100', 'n'}}, {'value', {'100', 'n'}}},
        ['updBitmap'] = {'shapes', {'value'}},
        ['setPixel'] = {'shapes', {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}, {'color', {'[255, 255, 255]', 'c'}}},
        ['setPixelRGB'] = {'shapes', {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}},
            {'value', {'255', 'n'}}, {'value', {'255', 'n'}}, {'value', {'255', 'n'}}},
        ['removePixel'] = {'shapes', {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['setBitmapSprite'] = {'shapes', {'value'}, {'value'}},
        ['getBitmapSprite'] = {'shapes', {'value'}, {'value'}},
        ['setGradientPaint'] = {'shapes', {'value'}, {'color', {'[255, 255, 255]', 'c'}}, {'color', {'[255, 255, 255]', 'c'}},
            {'value', {'100', 'n'}}, {'value', {'100', 'n'}}},
        ['setStrokeWidth'] = {'shapes', {'value'}, {'value', {'8', 'n'}}},
        ['updStrokeWidth'] = {'shapes', {'value'}, {'value', {'0', 'n'}}},
        ['setStrokeColor'] = {'shapes', {'value'}, {'color', {'[255, 255, 255]', 'c'}}},
        ['setStrokeRGB'] = {'shapes', {'value'}, {'value', {'255', 'n'}}, {'value', {'255', 'n'}}, {'value', {'255', 'n'}}},

        -- noob
        ['newCircleNoob'] = {'shapes', {'value'}, {'value', {'50', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
            ['newRectNoob'] = {'shapes', {'value'}, {'color', {'[255, 255, 255]', 'c'}},
                {'value', {'100', 'n'}}, {'value', {'100', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
            ['newRoundedRectNoob'] = {'shapes', {'value'}, {'value', {'10', 'n'}}, {'value', {'100', 'n'}},
                {'value', {'100', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
            ['setSpriteNoob'] = {'shapes', {'value'}, {'value'}},
            ['setColorNoob'] = {'shapes', {'value'}, {'color', {'[255, 255, 255]', 'c'}}},
            ['hideObjectNoob'] = {'shapes', {'value'}},
            ['showObjectNoob'] = {'shapes', {'value'}},
            ['removeObjectNoob'] = {'shapes', {'value'}},
            ['frontObjectNoob'] = {'shapes', {'value'}},
            ['backObjectNoob'] = {'shapes', {'value'}},

    -- objects2
    ['setFrame'] = {'objects2', {'value'}, {'value'}},
        ['newSeqAnimation'] = {'objects2', {'value'}, {'animation', {'forward', 'sl'}},
            {'value'}, {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['newParAnimation'] = {'objects2', {'value'}, {'value'}, {'animation', {'forward', 'sl'}},
            {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['setScale'] = {'objects2', {'value'}, {'value', {'-100', 'n'}}},
        ['setScaleX'] = {'objects2', {'value'}, {'value', {'-100', 'n'}}},
        ['setScaleY'] = {'objects2', {'value'}, {'value', {'-100', 'n'}}},
        ['playAnimation'] = {'objects2', {'value'}, {'value'}},
        ['pauseAnimation'] = {'objects2', {'value'}, {'value'}},
        ['newMask'] = {'objects2', {'value'}, {'value'}},
        ['addMaskToObject'] = {'objects2', {'value'}, {'value'}},
        ['setMaskPos'] = {'objects2', {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['setMaskScale'] = {'objects2', {'value'}, {'value', {'100', 'n'}}},
        ['setMaskScaleX'] = {'objects2', {'value'}, {'value', {'100', 'n'}}},
        ['setMaskScaleY'] = {'objects2', {'value'}, {'value', {'100', 'n'}}},
        ['setMaskHitTrue'] = {'objects2', {'value'}},
        ['setMaskHitFalse'] = {'objects2', {'value'}},

    -- groups
    ['newGroup'] = {'groups', {'value'}},
        ['removeGroup'] = {'groups', {'value'}},
        ['showGroup'] = {'groups', {'value'}},
        ['hideGroup'] = {'groups', {'value'}},
        ['addGroupObject'] = {'groups', {'value'}, {'value'}},
        ['addGroupText'] = {'groups', {'value'}, {'value'}},
        ['addGroupWidget'] = {'groups', {'value'}, {'value'}},
        ['addGroupMedia'] = {'groups', {'value'}, {'value'}},
        ['addGroupTag'] = {'groups', {'value'}, {'value'}},
        ['addGroupGroup'] = {'groups', {'value'}, {'value'}},
        ['setGroupPos'] = {'groups', {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['setGroupSize'] = {'groups', {'value'}, {'value', {'100', 'n'}}, {'value', {'100', 'n'}}},
        ['setGroupRotation'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
        ['setGroupAlpha'] = {'groups', {'value'}, {'value', {'100', 'n'}}},
        ['updGroupPosX'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
        ['updGroupPosY'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
        ['updGroupWidth'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
        ['updGroupHeight'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
        ['updGroupRotation'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
        ['updGroupAlpha'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
        ['frontGroup'] = {'groups', {'value'}},
        ['backGroup'] = {'groups', {'value'}},
        ['newTag'] = {'groups', {'value'}},
            ['removeTag'] = {'groups', {'value'}},
            ['showTag'] = {'groups', {'value'}},
            ['hideTag'] = {'groups', {'value'}},
            ['addTagObject'] = {'groups', {'value'}, {'value'}},
            ['addTagText'] = {'groups', {'value'}, {'value'}},
            ['addTagWidget'] = {'groups', {'value'}, {'value'}},
            ['addTagMedia'] = {'groups', {'value'}, {'value'}},
            ['addTagGroup'] = {'groups', {'value'}, {'value'}},
            ['addTagTag'] = {'groups', {'value'}, {'value'}},
            ['setTagPos'] = {'groups', {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
            ['setTagSize'] = {'groups', {'value'}, {'value', {'100', 'n'}}, {'value', {'100', 'n'}}},
            ['setTagRotation'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
            ['setTagAlpha'] = {'groups', {'value'}, {'value', {'100', 'n'}}},
            ['updTagPosX'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
            ['updTagPosY'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
            ['updTagWidth'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
            ['updTagHeight'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
            ['updTagRotation'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
            ['updTagAlpha'] = {'groups', {'value'}, {'value', {'0', 'n'}}},
            ['frontTag'] = {'groups', {'value'}},
            ['backTag'] = {'groups', {'value'}},

        -- noob
        ['addGroupObjectNoob'] = {'groups', {'value'}, {'value'}},
        ['addTagObjectNoob'] = {'groups', {'value'}, {'value'}},

    -- physics
    ['setBodyType'] = {'physics', {'value'}, {'body', {'dynamic', 'sl'}}},
        ['setBody'] = {'physics', {'value'}, {'body', {'dynamic', 'sl'}},
            {'value', {'1', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}},
            {'value', {'-1', 'n'}}, {'value', {'nil', 'l'}}, {'value', {'nil', 'l'}}},
        ['removeBody'] = {'physics', {'value'}},
        ['setHitboxBox'] = {'physics', {'value'}, {'value', {'0', 'n'}},
            {'value', {'100', 'n'}}, {'value', {'100', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['setHitboxCircle'] = {'physics', {'value'}, {'value', {'50', 'n'}}},
        ['setHitboxMesh'] = {'physics', {'value'}, {'value', {'1', 'n'}}},
        ['setHitboxPolygon'] = {'physics', {'value'}, {'value'}},
        ['updHitbox'] = {'physics', {'value'}},
        ['setGravity'] = {'physics', {'value'}, {'value', {'-1', 'n'}}},
        ['setLinearVelocity'] = {'physics', {'value'}, {'value', {'500', 'n'}}, {'value', {'500', 'n'}}},
        ['setLinearVelocityX'] = {'physics', {'value'}, {'value', {'500', 'n'}}},
        ['setLinearVelocityY'] = {'physics', {'value'}, {'value', {'500', 'n'}}},
        ['setSensor'] = {'physics', {'value'}},
        ['removeSensor'] = {'physics', {'value'}},
        ['setFixedRotation'] = {'physics', {'value'}},
        ['removeFixedRotation'] = {'physics', {'value'}},
        ['setBullet'] = {'physics', {'value'}},
        ['removeBullet'] = {'physics', {'value'}},
        ['setWorldGravity'] = {'physics', {'value', {'0', 'n'}}, {'value', {'-9.8', 'n'}}},
            ['setAwake'] = {'physics', {'value'}},
            ['disableCollision'] = {'physics', {'value'}},
            ['setBounce'] = {'physics', {'value'}, {'value', {'0', 'n'}}},
            ['setFriction'] = {'physics', {'value'}, {'value', {'0', 'n'}}},
            ['setTangentSpeed'] = {'physics', {'value'}, {'value', {'100', 'n'}}},
            ['setAngularVelocity'] = {'physics', {'value'}, {'value', {'100', 'n'}}},
            ['setAngularDamping'] = {'physics', {'value'}, {'value', {'100', 'n'}}},
            ['setLinearDamping'] = {'physics', {'value'}, {'value', {'100', 'n'}}},
            ['setForce'] = {'physics', {'value'}, {'value', {'500', 'n'}}, {'value', {'500', 'n'}},
                {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
            ['setTorque'] = {'physics', {'value'}, {'value', {'50', 'n'}}},
            ['setLinearImpulse'] = {'physics', {'value'}, {'value', {'500', 'n'}}, {'value', {'500', 'n'}},
                {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
            ['setAngularImpulse'] = {'physics', {'value'}, {'value', {'50', 'n'}}},
            ['setHitboxVisible'] = {'physics'},
            ['removeHitboxVisible'] = {'physics'},
            ['startPhysics'] = {'physics'},
            ['pausePhysics'] = {'physics'},
            ['stopPhysics'] = {'physics'},
            ['setTextBody'] = {'physics', {'value'}, {'body', {'dynamic', 'sl'}},
                {'value', {'1', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}, {'value', {'-1', 'n'}}},

        -- noob
        ['setBodyNoob'] = {'physics', {'value'}, {'body', {'dynamic', 'sl'}}, {'value', {'0', 'n'}}, {'value', {'-1', 'n'}}},
            ['removeBodyNoob'] = {'physics', {'value'}},
            ['setLinearVelocityXNoob'] = {'physics', {'value'}, {'value', {'500', 'n'}}},
            ['setLinearVelocityYNoob'] = {'physics', {'value'}, {'value', {'500', 'n'}}},
            ['setSensorNoob'] = {'physics', {'value'}},
            ['removeSensorNoob'] = {'physics', {'value'}},
            ['setFixedRotationNoob'] = {'physics', {'value'}},
            ['removeFixedRotationNoob'] = {'physics', {'value'}},

    -- widgets
    ['setWidgetListener'] = {'widgets', {'value'}, {'fun'}},
        ['newWebView'] = {'widgets', {'value'}, {'value', {'https://google.com', 't'}}, {'value', {'100', 'n'}}, {'value', {'100', 'n'}}},
        ['newHSlider'] = {'widgets', {'value'}, {'value', {'100', 'n'}}, {'fun'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['newVSlider'] = {'widgets', {'value'}, {'value', {'100', 'n'}}, {'fun'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['newField'] = {'widgets', {'value'}, {'value'}, {'inputType', {'inputDefault', 'sl'}}, {'color', {'[255, 255, 255]', 'c'}},
            {'value', {'25', 'n'}}, {'isBackground', {'backgroundTrue', 'sl'}}, {'textAlign', {'alignLeft', 'sl'}}, {'value', {'ubuntu', 't'}},
            {'value', {'400', 'n'}}, {'value', {'80', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['newBox'] = {'widgets', {'value'}, {'value'}, {'color', {'[255, 255, 255]', 'c'}}, {'value', {'25', 'n'}},
            {'isBackground', {'backgroundTrue', 'sl'}}, {'textAlign', {'alignLeft', 'sl'}}, {'value', {'ubuntu', 't'}},
            {'value', {'400', 'n'}}, {'value', {'80', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['setWidgetPos'] = {'widgets', {'value'}, {'value', {'nil', 'l'}}, {'value', {'nil', 'l'}}},
        ['setWidgetSize'] = {'widgets', {'value'}, {'value', {'nil', 'l'}}, {'value', {'nil', 'l'}}},
        ['updWebViewSite'] = {'widgets', {'value'}},
        ['setWebViewLink'] = {'widgets', {'value'}, {'value', {'https://google.com', 't'}}},
        ['setWebViewFront'] = {'widgets', {'value'}},
        ['setWebViewBack'] = {'widgets', {'value'}},
        ['setSliderValue'] = {'widgets', {'value'}, {'value', {'50', 'n'}}},
        ['setFieldSecure'] = {'widgets', {'value'}},
        ['removeFieldSecure'] = {'widgets', {'value'}},
        ['setFieldText'] = {'widgets', {'value'}, {'value'}},
        ['setFieldRule'] = {'widgets', {'value'}, {'rule', {'ruleTrue', 'sl'}}},
        ['setFieldFocus'] = {'widgets', {'value'}},
        ['setFieldFocusNil'] = {'widgets'},
        ['hidePanelInterface'] = {'widgets'},
        ['showPanelInterface'] = {'widgets'},
        ['setSwitchState'] = {'widgets', {'value'}, {'switchState', {'switchOn', 'sl'}}},
            ['newScrollView'] = {'widgets', {'value'}, {'isBackground', {'backgroundTrue', 'sl'}},
                {'fun'}, {'isBackground', {'backgroundTrue', 'sl'}}, {'value', {'0.972', 'n'}}, {'isBackground', {'backgroundFalse', 'sl'}},
                {'isBackground', {'backgroundTrue', 'sl'}}, {'color', {'[255, 255, 255]', 'c'}}, {'isBackground', {'backgroundTrue', 'sl'}},
                {'value', {'100', 'n'}}, {'value', {'100', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
            ['newSwitch'] = {'widgets', {'value'}, {'switchType', {'switchCheckbox', 'sl'}}, {'switchState', {'switchOff', 'sl'}},
                {'value', {'100', 'n'}}, {'value', {'100', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}, {'fun'}, {'fun'}},
            ['insertToScroll'] = {'widgets', {'value'}, {'value'}, {'transitName', {'obj', 'sl'}}},
            ['takeFocusScroll'] = {'widgets', {'value'}, {'value'}},
            ['removeWidget'] = {'widgets', {'value'}},
            ['showWidget'] = {'widgets', {'value'}},
            ['hideWidget'] = {'widgets', {'value'}},

    -- media
    ['resumeMedia'] = {'media', {'value'}},
        ['newVideo'] = {'media', {'value'}, {'value'}, {'fun'},
            {'value', {'0', 'n'}}, {'value', {'0', 'n'}}, {'value', {'100', 'n'}}, {'value', {'100', 'n'}}},
        ['newRemoteVideo'] = {'media', {'value'}, {'value'}, {'fun'},
            {'value', {'0', 'n'}}, {'value', {'0', 'n'}}, {'value', {'100', 'n'}}, {'value', {'100', 'n'}}},
        ['loadSound'] = {'media', {'value'}, {'value'}},
        ['loadStream'] = {'media', {'value'}, {'value'}},
        ['playSound'] = {'media', {'value'}, {'value', {'1', 'n'}}, {'fun'}, {'value', {'nil', 'l'}}, {'value', {'nil', 'l'}}},
        ['pauseMedia'] = {'media', {'value'}},
        ['seekMedia'] = {'media', {'value'}, {'value', {'30', 'n'}}},
        ['setVolume'] = {'media', {'value'}, {'value', {'10', 'n'}}},
        ['fadeVolume'] = {'media', {'value'}, {'value', {'5', 'n'}}, {'value', {'10', 'n'}}},
        ['stopSound'] = {'media', {'value'}},
        ['stopTimerSound'] = {'media', {'value'}, {'value', {'5', 'n'}}},
        ['disposeSound'] = {'media', {'value'}},
        ['removeVideo'] = {'media', {'value'}},

        -- noob
        ['playSoundNoob'] = {'media', {'value'}, {'value', {'1', 'n'}}},
            ['pauseMediaNoob'] = {'media', {'value'}},
            ['seekMediaNoob'] = {'media', {'value'}, {'value', {'30', 'n'}}},
            ['setVolumeNoob'] = {'media', {'value'}, {'value', {'10', 'n'}}},
            ['fadeVolumeNoob'] = {'media', {'value'}, {'value', {'5', 'n'}}, {'value', {'10', 'n'}}},
            ['stopSoundNoob'] = {'media', {'value'}},
            ['stopTimerSoundNoob'] = {'media', {'value'}, {'value', {'5', 'n'}}},

    -- snapshot
    ['invalidateSnapshot'] = {'snapshot', {'value'}, {'snapshotType', {'snapshotGroup', 'sl'}}},
        ['newSnapshot'] = {'snapshot', {'value'}, {'canvasMode', {'canvasModeAppend', 'sl'}},
            {'value', {'100', 'n'}}, {'value', {'100', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['addToSnapshot'] = {'snapshot', {'value'}, {'snapshotType', {'snapshotGroup', 'sl'}},
            {'value'}, {'transitName', {'obj', 'sl'}}},
        ['removeFromSnapshot'] = {'snapshot', {'value'}, {'snapshotType', {'snapshotGroup', 'sl'}},
            {'value'}, {'transitName', {'obj', 'sl'}}},
        ['setSnapshotColor'] = {'snapshot', {'value'}, {'color', {'[0, 0, 0]', 'c'}}},
        ['setSnapshotPos'] = {'snapshot', {'value'}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
        ['setSnapshotSize'] = {'snapshot', {'value'}, {'value', {'100', 'n'}}, {'value', {'100', 'n'}}},
        ['setSnapshotRotation'] = {'snapshot', {'value'}, {'value', {'0', 'n'}}},
        ['setSnapshotAlpha'] = {'snapshot', {'value'}, {'value', {'100', 'n'}}},
        ['updSnapshotPosX'] = {'snapshot', {'value'}, {'value', {'0', 'n'}}},
        ['updSnapshotPosY'] = {'snapshot', {'value'}, {'value', {'0', 'n'}}},
        ['updSnapshotWidth'] = {'snapshot', {'value'}, {'value', {'0', 'n'}}},
        ['updSnapshotHeight'] = {'snapshot', {'value'}, {'value', {'0', 'n'}}},
        ['updSnapshotRotation'] = {'snapshot', {'value'}, {'value', {'0', 'n'}}},
        ['updSnapshotAlpha'] = {'snapshot', {'value'}, {'value', {'0', 'n'}}},
        ['frontSnapshot'] = {'snapshot', {'value'}},
        ['backSnapshot'] = {'snapshot', {'value'}},
        ['removeSnapshot'] = {'snapshot', {'value'}},
        ['showSnapshot'] = {'snapshot', {'value'}},
        ['hideSnapshot'] = {'snapshot', {'value'}},

    -- transition
    ['setTransitionPause'] = {'transition', {'value'}, {'transitName', {'obj', 'sl'}}},
        ['setTransitionResume'] = {'transition', {'value'}, {'transitName', {'obj', 'sl'}}},
        ['setTransitionCancel'] = {'transition', {'value'}, {'transitName', {'obj', 'sl'}}},
        ['setTransitionPauseAll'] = {'transition'},
        ['setTransitionResumeAll'] = {'transition'},
        ['setTransitionCancelAll'] = {'transition'},
        ['setTransitionTo'] = {'transition', {'value'}, {'transitName', {'obj', 'sl'}}, {'animation', {'forward', 'sl'}},
            {'value', {'1', 'n'}}, {'value', {'1', 'n'}}, {'value'}, {'value'}, {'value'}, {'value'}, {'value'}, {'value'}, {'value'}, {'value'},
            {'transitEasing', {'linear', 'sl'}}, {'fun'}, {'fun'}, {'fun'}, {'fun'}, {'fun'}},
        ['setTransitionPos'] = {'transition', {'value'}, {'transitName', {'obj', 'sl'}}, {'animation', {'forward', 'sl'}},
            {'value', {'1', 'n'}}, {'value', {'1', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}},
            {'transitEasing', {'linear', 'sl'}}, {'fun'}, {'fun'}, {'fun'}, {'fun'}, {'fun'}},
        ['setTransitionSize'] = {'transition', {'value'}, {'transitName', {'obj', 'sl'}}, {'animation', {'forward', 'sl'}},
            {'value', {'1', 'n'}}, {'value', {'1', 'n'}}, {'value', {'100', 'n'}}, {'value', {'100', 'n'}},
            {'transitEasing', {'linear', 'sl'}}, {'fun'}, {'fun'}, {'fun'}, {'fun'}, {'fun'}},
        ['setTransitionScale'] = {'transition', {'value'}, {'transitName', {'obj', 'sl'}}, {'animation', {'forward', 'sl'}},
            {'value', {'1', 'n'}}, {'value', {'1', 'n'}}, {'value', {'100', 'n'}}, {'value', {'100', 'n'}},
            {'transitEasing', {'linear', 'sl'}}, {'fun'}, {'fun'}, {'fun'}, {'fun'}, {'fun'}},
        ['setTransitionRotation'] = {'transition', {'value'}, {'animation', {'forward', 'sl'}}, {'transitName', {'obj', 'sl'}},
            {'value', {'1', 'n'}}, {'value', {'1', 'n'}}, {'value', {'0', 'n'}},
            {'transitEasing', {'linear', 'sl'}}, {'fun'}, {'fun'}, {'fun'}, {'fun'}, {'fun'}},
        ['setTransitionAlpha'] = {'transition', {'value'}, {'animation', {'forward', 'sl'}}, {'transitName', {'obj', 'sl'}},
            {'value', {'1', 'n'}}, {'value', {'1', 'n'}}, {'value', {'100', 'n'}},
            {'transitEasing', {'linear', 'sl'}}, {'fun'}, {'fun'}, {'fun'}, {'fun'}, {'fun'}},
        ['setTransitionAngles'] = {'transition', {'value'}, {'animation', {'forward', 'sl'}}, {'transitName', {'obj', 'sl'}},
            {'value', {'1', 'n'}}, {'value', {'1', 'n'}}, {'value'},
            {'transitEasing', {'linear', 'sl'}}, {'fun'}, {'fun'}, {'fun'}, {'fun'}, {'fun'}},

        -- noob
        ['setTransitionAlphaNoob'] = {'transition', {'value'}, {'noobName', {'pic', 'sl'}}, {'value', {'1', 'n'}}, {'value', {'100', 'n'}}},
            ['setTransitionPosNoob'] = {'transition', {'value'}, {'noobName', {'pic', 'sl'}},
                {'value', {'1', 'n'}}, {'value', {'0', 'n'}}, {'value', {'0', 'n'}}},
            ['setTransitionSizeNoob'] = {'transition', {'value'}, {'noobName', {'pic', 'sl'}},
                {'value', {'1', 'n'}}, {'value', {'100', 'n'}}, {'value', {'100', 'n'}}},
            ['setTransitionScaleNoob'] = {'transition', {'value'}, {'noobName', {'pic', 'sl'}},
                {'value', {'1', 'n'}}, {'value', {'100', 'n'}}, {'value', {'100', 'n'}}},
            ['setTransitionRotationNoob'] = {'transition', {'value'}, {'noobName', {'pic', 'sl'}},
                {'value', {'1', 'n'}}, {'value', {'0', 'n'}}},

    -- network
    ['createServer'] = {'network', {'value', {'22222', 'n'}}, {'fun'}},
        ['connectToServer'] = {'network', {'value'}, {'value', {'22222', 'n'}}, {'fun'}},
        ['openURL'] = {'network', {'value', {'https://google.com', 't'}}},
        ['requestGET'] = {'network', {'value'}, {'value'}, {'value'}, {'fun'},
            {'networkProgress'}, {'networkRedirects', {'redirectsTrue', 'sl'}}, {'value', {'30', 'n'}}},
        ['requestPOST'] = {'network', {'value'}, {'value'}, {'value'}, {'fun'},
            {'networkProgress'}, {'networkRedirects', {'redirectsTrue', 'sl'}}, {'value', {'30', 'n'}}},
        ['requestPUT'] = {'network', {'value'}, {'value'}, {'value'}, {'fun'},
            {'networkProgress'}, {'networkRedirects', {'redirectsTrue', 'sl'}}, {'value', {'30', 'n'}}},
        ['requestPATCH'] = {'network', {'value'}, {'value'}, {'value'}, {'fun'},
            {'networkProgress'}, {'networkRedirects', {'redirectsTrue', 'sl'}}, {'value', {'30', 'n'}}},
        ['requestHEAD'] = {'network', {'value'}, {'value'}, {'value'}, {'fun'},
            {'networkProgress'}, {'networkRedirects', {'redirectsTrue', 'sl'}}, {'value', {'30', 'n'}}},
        ['requestDELETE'] = {'network', {'value'}, {'value'}, {'value'}, {'fun'},
            {'networkProgress'}, {'networkRedirects', {'redirectsTrue', 'sl'}}, {'value', {'30', 'n'}}},
        ['firebasePUT'] = {'network', {'value'}, {'value'}, {'value', {'KEY', 't'}}, {'fun'}},
        ['firebasePATCH'] = {'network', {'value'}, {'value'}, {'value', {'KEY', 't'}}, {'fun'}},
        ['firebaseGET'] = {'network', {'value'}, {'value', {'KEY', 't'}}, {'fun'}},
        ['firebaseDELETE'] = {'network', {'value'}, {'value', {'KEY', 't'}}, {'fun'}},
        ['initAdsStartApp'] = {'network', {'value'}, {'fun'}},
        ['loadAdsStartApp'] = {'network', {'adsType'}},
        ['showAdsStartApp'] = {'network', {'adsType'}},

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
    ['vars'] = {'setTextPos'}
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
M.listDeleteType = {[11] = 'widgets', [12] = 'snapshot', [13] = 'network', [14] = 'objects2', [15] = 'custom'}

for type, blocks in pairs(M.listBlock) do
    if type ~= 'everyone' and type ~= '_everyone' then
        for index, block in pairs(blocks) do
            if M.listName[block .. 'Noob'] then
                for index, name in ipairs(M.listBlockNoob.everyone) do
                    if name == block then
                        M.listBlockNoob.everyone[index] = block .. 'Noob'
                    end
                end

                for index, name in ipairs(M.listBlockNoob[type]) do
                    if name == block and M.listName[block .. 'Noob'] and M.listName[block .. 'Noob'][1] == type then
                        M.listBlockNoob[type][index] = block .. 'Noob'
                    end
                end
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
        ['onGlobalCollisionEnded'] = 'events',
        ['onGlobalPreCollision'] = 'events',
        ['onGlobalPostCollision'] = 'events',
        ['onSliderMoved'] = 'events',
        ['onSwitchCallback'] = 'events',
        ['onWebViewCallback'] = 'events',
        ['onFieldBegan'] = 'events',
        ['onFieldEditing'] = 'events',
        ['onFieldEnded'] = 'events',

    ['newSprite'] = 'objects',
        ['setAnchor'] = 'objects',
        ['hideObject'] = 'objects',
        ['showObject'] = 'objects',
        ['removeObject'] = 'objects',
        ['frontObject'] = 'objects',
        ['backObject'] = 'objects',
        ['addGroupWidget'] = 'groups',
        ['addTagWidget'] = 'groups',
        ['addGroupMedia'] = 'groups',
        ['addTagMedia'] = 'groups',

    ['newPolygon'] = 'shapes',
        ['newLine'] = 'shapes',
        ['appendLine'] = 'shapes',
        ['setRGB'] = 'shapes',
        ['setHEX'] = 'shapes',
        ['newBitmap'] = 'shapes',
        ['updBitmap'] = 'shapes',
        ['setPixel'] = 'shapes',
        ['setPixelRGB'] = 'shapes',
        ['removePixel'] = 'shapes',
        ['setBitmapSprite'] = 'shapes',
        ['getBitmapSprite'] = 'shapes',
        ['setGradientPaint'] = 'shapes',
        ['setStrokeWidth'] = 'shapes',
        ['updStrokeWidth'] = 'shapes',
        ['setStrokeColor'] = 'shapes',
        ['setStrokeRGB'] = 'shapes',

    ['setListener'] = 'control',
        ['setListener3'] = 'control',
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
        ['requestApi'] = 'control',
        ['requestApiRes'] = 'control',
        ['comment'] = 'control',
        ['setBackgroundRGB'] = 'control',
        ['setBackgroundHEX'] = 'control',
        ['setPortraitOrientation'] = 'control',
        ['setLandscapeOrientation'] = 'control',
        ['scheduleNotification'] = 'control',
        ['cancelNotification'] = 'control',
        ['setAccelerometerFrequency'] = 'control',
        ['turnOnAccelerometer'] = 'control',
        ['readFileRes'] = 'control',
        ['pasteboardCopy'] = 'control',
        ['pasteboardPaste'] = 'control',
        ['pasteboardClear'] = 'control',

    ['setObjVar'] = 'vars',
        ['insertTable'] = 'vars',
        ['removeTable'] = 'vars',
        ['resetTable'] = 'vars',
        ['saveValue'] = 'vars',
        ['setRandomSeed'] = 'vars',
        ['setTextAnchor'] = 'vars',
        ['setTextRGB'] = 'vars',
        ['setTextHEX'] = 'vars',
        ['setTransitionTo'] = 'transition',
        ['setTransitionAngles'] = 'transition',
        ['newVideo'] = 'media',
        ['newRemoteVideo'] = 'media',
        ['loadSound'] = 'media',
        ['loadStream'] = 'media',
        ['disposeSound'] = 'media',
        ['removeVideo'] = 'media',

    ['setBodyType'] = 'physics',
        ['setHitboxBox'] = 'physics',
        ['setHitboxMesh'] = 'physics',
        ['setHitboxCircle'] = 'physics',
        ['setHitboxPolygon'] = 'physics',
        ['updHitbox'] = 'physics',
        ['setGravity'] = 'physics',
        ['setLinearVelocity'] = 'physics',
        ['setBullet'] = 'physics',
        ['removeBullet'] = 'physics',
        ['setAwake'] = 'physics',
        ['setBounce'] = 'physics',
        ['setFriction'] = 'physics',
        ['setTangentSpeed'] = 'physics',
        ['disableCollision'] = 'physics',
        ['setAngularVelocity'] = 'physics',
        ['setAngularDamping'] = 'physics',
        ['setLinearDamping'] = 'physics',
        ['setForce'] = 'physics',
        ['setTorque'] = 'physics',
        ['setLinearImpulse'] = 'physics',
        ['setAngularImpulse'] = 'physics',
        ['setTextBody'] = 'physics'
}

for index, type in pairs(M.listDeleteType) do
    for index, block in pairs(M.listBlock[type]) do
        blocksDelete[block] = type
    end
end

for block, type in pairs(blocksDelete) do
    for index, name in ipairs(M.listBlockNoob.everyone) do
        if name == block then
            table.remove(M.listBlockNoob.everyone, index)
        end
    end

    for index, name in ipairs(M.listBlockNoob[type]) do
        if name == block then
            table.remove(M.listBlockNoob[type], index)
        end
    end
end

table.remove(M.listBlockNoob.everyone, 4)
    table.remove(M.listBlockNoob.everyone, 6)
    table.remove(M.listBlockNoob.everyone, table.indexOf(M.listBlockNoob.everyone, 'onConditionNoob'))
    table.insert(M.listBlockNoob.everyone, 3, 'onConditionNoob')
    table.remove(M.listBlockNoob.control, table.indexOf(M.listBlockNoob.control, 'setBackgroundColor'))
    table.insert(M.listBlockNoob.control, 1, 'setBackgroundColor')
    table.remove(M.listBlockNoob.vars, table.indexOf(M.listBlockNoob.vars, 'addTable'))
    table.insert(M.listBlockNoob.vars, 3, 'addTable')
    table.remove(M.listBlockNoob.vars, table.indexOf(M.listBlockNoob.vars, 'saveValueNoob'))
    table.insert(M.listBlockNoob.vars, 11, 'saveValueNoob')
    table.insert(M.listBlockNoob.everyone, table.indexOf(M.listBlockNoob.everyone, 'saveValueNoob') + 1, 'readValueNoob')
    table.insert(M.listBlockNoob.vars, 12, 'readValueNoob')

    table.insert(M.listBlockNoob.shapes, 'hideObjectNoob')
    table.insert(M.listBlockNoob.shapes, 'showObjectNoob')
    table.insert(M.listBlockNoob.shapes, 'removeObjectNoob')
    table.insert(M.listBlockNoob.shapes, 'frontObjectNoob')
    table.insert(M.listBlockNoob.shapes, 'backObjectNoob')

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

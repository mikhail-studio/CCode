local classes = {}

local currentClassName
local workingField
local nextClassIsLocal = false
local nextFieldDecorators = {}

function table.copy(t)
    local t2 = {};
    for k,v in pairs(t) do
        if type(v) == "table" then
            t2[k] = table.copy(v)
        else
            t2[k] = v
        end
    end
    return t2
end

local function isNameUniqueInCurrentClass(name)
    for _, field in ipairs(classes[currentClassName].fields) do
        if field.name == name then return false end
    end
    return true
end

local function createNewEmptyField(scope, name)
    if not isNameUniqueInCurrentClass(name) then return error('"' ..name .. '" field already exists in class ' .. currentClassName) end
    classes[currentClassName].fields[#classes[currentClassName].fields + 1] = {
        name = name,
        type = scope,
        value = nil
    }
    workingField = #classes[currentClassName].fields
end

local function checkAndAddFieldToStatics(name, value)
    if classes[currentClassName].fields[workingField].type == "static" then
        classes[currentClassName].statics[name] = value
    end
end


local function safeCallMethodWithContext(method, decorators, this, privateThis, ...)
    local currentContext = _G.this ~= nil and "inside" or "outside"
    _G.pub = this
    _G.this = privateThis
    for _, decorator in ipairs(decorators or {}) do
        decorator()
    end
    local returned = method(...)
    if currentContext == "outside" then
        _G.pub = nil
        _G.this = nil
    end
    return returned
end


function localClass(name)
    nextClassIsLocal = true
    return class(name)
end

function class(name)
    classes[name] = {
        fields = {},
        statics = {},
        onConstructor = function()  end
    }
    currentClassName = name

    local mt = {
        __call = function(self, ...)
            local newClass = {}
            local privateNewClass = {}

            for i = 1, #classes[name].fields do
                local currentField = table.copy(classes[name].fields[i])

                if currentField.type == "public" then
                    if type(currentField.value) == "function" then
                        newClass[currentField.name] = function(...)
                            return safeCallMethodWithContext(currentField.value, currentField.decorators, newClass, privateNewClass, ...)
                        end
                    else
                        newClass[currentField.name] = currentField.value
                    end
                end

                if currentField.type == "private" then
                    if type(currentField.value) == "function" then
                        privateNewClass[currentField.name] = function(...)
                            return safeCallMethodWithContext(currentField.value, newClass, privateNewClass, ...)
                        end
                    else
                        privateNewClass[currentField.name] = currentField.value
                    end
                end
            end

            safeCallMethodWithContext(classes[name].onConstructor, {}, newClass, privateNewClass, ...)

            return newClass
        end
    }

    local thisClass = classes[name].statics

    setmetatable(thisClass, mt)
    if nextClassIsLocal then
        nextClassIsLocal = false
        return thisClass
    end
    _G[name] = thisClass
end


function extends(parentClassName)
    local parentClass = classes[parentClassName]

    if parentClass == nil then
        return error("Class " .. parentClassName .. " is undefined")
    end
    for k, v in pairs(table.copy(parentClass.fields)) do
        classes[currentClassName].fields[k] = {
            name = v.name,
            value = v.value,
            type = "public"
        }
    end
    classes[currentClassName].parent = parentClass
end

function super(...)
    classes[currentClassName].parent.onConstructor(...)
end

function override(fieldName)
    if isNameUniqueInCurrentClass(fieldName) then return error("You can't override of undefined field " .. fieldName) end
    for i, field in ipairs(classes[currentClassName].fields) do
        if field.name == fieldName then
            field.value = nil
            workingField = i
        end
    end
end

function private(fieldName)
    createNewEmptyField("private", fieldName)
end

function public(fieldName)
    createNewEmptyField("public", fieldName)
end

function static(fieldName)
    createNewEmptyField("static", fieldName)
end

function Decorators(decoratorList)
    for _, v in ipairs(decoratorList) do
        nextFieldDecorators[#nextFieldDecorators + 1] = v
    end
end

function method(methodName)
    if workingField ~= nil then
        if not isNameUniqueInCurrentClass(methodName) then return error('"' .. methodName .. '" field already exists in class ' .. currentClassName) end
        classes[currentClassName].fields[workingField].name = methodName
        classes[currentClassName].fields[workingField].value = function()  end
        checkAndAddFieldToStatics(classes[currentClassName].fields[workingField].name, methodName)
    else
        public()
        method(methodName)
    end
end

function define(value)
    if workingField == nil then return error("You can't set value of undefined field. At class " .. currentClassName) end
    classes[currentClassName].fields[workingField].value = value
    checkAndAddFieldToStatics(classes[currentClassName].fields[workingField].name, value)
    workingField = nil
end

function undefined()
    workingField = nil
end

function callback(callbackFn)
    if not workingField then return error("You can't set callback function to undefined method. At class " .. currentClassName) end
    classes[currentClassName].fields[workingField].value = callbackFn
    classes[currentClassName].fields[workingField].decorators = nextFieldDecorators
    checkAndAddFieldToStatics(classes[currentClassName].fields[workingField].name, callbackFn)
    nextFieldDecorators = {}
    workingField = nil
end

function constructor(callbackFn)
    classes[currentClassName].onConstructor = callbackFn
end

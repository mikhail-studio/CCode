local M = {}
local P = {}

local listTypes = {
    {'eye', 'all'}, {'move', 'all'}, {'scale', 'image'}, {'rotate', 'all'},
    {'clone', 'all'}, {'delete', 'all'}, {'name', 'all'},
    {'x', 'all'}, {'y', 'all'}, {'width', 'image'}, {'height', 'image'},
    {'text', 'text'}, {'size', 'text'}, {'rotate2', 'all'}, {'layer', 'all'},
    {'body', 'image'}
}

local function clear()
    for i = 1, #listTypes do
        P[listTypes[i][1]] = false
    end
end

local function addSprite(textureLink)
    if P.level.sprites[textureLink] then
        P.level.sprites[textureLink] = P.level.sprites[textureLink] + 1
    else
        P.level.sprites[textureLink] = 1
    end
end

local function deleteSprite(textureLink)
    if not _G.type(P.level.sprites[textureLink]) == 'number' then
        return
    end

    if P.level.sprites[textureLink] > 1 then
        P.level.sprites[textureLink] = P.level.sprites[textureLink] - 1
    else
        P.level.sprites[textureLink] = nil
        OS_REMOVE(DOC_DIR .. '/' .. CURRENT_LINK .. '/Images/' .. textureLink)
    end
end

function M:saveClone(data)
    for index, obj in ipairs(P.level.params) do
        if obj.name == data.name then
            local data = COPY_TABLE(data)
            data.name = data.name .. math.random(100000, 999999)
            data.x, data.y = data.x + 10, data.y + 10
            table.insert(P.level.params, data)
            addSprite(data.type[2])
            return data
        end
    end
end

function M:saveDelete(data)
    for index, obj in ipairs(P.level.params) do
        if obj.name == data.name then
            table.remove(P.level.params, index)
            deleteSprite(data.type[2])
        end
    end
end

function M:saveMove(currentObj, data)
    for index, obj in ipairs(P.level.params) do
        if obj.name == data.name then
            P.level.params[index].x = currentObj.x - CENTER_X
            P.level.params[index].y = CENTER_Y - currentObj.y
        end
    end
end

function M:saveScale(currentObj, data)
    for index, obj in ipairs(P.level.params) do
        if obj.name == data.name then
            P.level.params[index].width = currentObj.width
            P.level.params[index].height = currentObj.height
        end
    end
end

function M:saveRotation(currentObj, data)
    for index, obj in ipairs(P.level.params) do
        if obj.name == data.name then
            P.level.params[index].rotation = currentObj.rotation
        end
    end
end

function M:saveText(currentObj, data)
    for index, obj in ipairs(P.level.params) do
        if obj.name == data.name then
            P.level.params[index].type[2] = currentObj.text
        end
    end
end

function M:saveSize(currentObj, data)
    for index, obj in ipairs(P.level.params) do
        if obj.name == data.name then
            P.level.params[index].size = currentObj.size
        end
    end
end

function M:saveName(newName, data)
    for index, obj in ipairs(P.level.params) do
        if obj.name == data.name then
            P.level.params[index].name = newName
        end
    end
end

function M:saveLayer(value, img)
    local data = COPY_TABLE(img.data)
    for index, obj in ipairs(P.level.params) do
        if obj.name == data.name then
            table.remove(P.level.params, index)
            table.insert(P.level.params, value, data)
        end
    end
end

local completeImportPicture = function(import)
    if import.done and import.done == 'ok' then
        local name = P.importName
        local isPixel = P.importIsPixel
        local callback = P.importCallback
        local textureLink = P.importTextureLink
        local fullTextureLink = CURRENT_LINK .. '/Images/' .. textureLink
        local width, height = 0, 0

        local checkImage = display.newImage(fullTextureLink,
            system.DocumentsDirectory, 10000, 10000)

        if checkImage then
            width, height = checkImage.width, checkImage.height
            checkImage:removeSelf()
        end

        local obj = {
            y = 0, x = 0, rotation = 0, body = 'nil',
            type = {'image', textureLink, isPixel and 'nearest' or 'linear'},
            gravity = -1, bounce = 0, density = 1, friction = 0,
            width = width, height = height, name = name
        }

        table.insert(P.level.params, obj)
        addSprite(textureLink)
        callback(obj)
    end
end

function M:addTextInLevel(name, text, callback)
    local obj = {
        type = {'text', text}, y = 0, x = 0, font = 'ubuntu',
        rotation = 0, size = 50, name = name
    }

    table.insert(P.level.params, obj)
    callback(obj)
end

function M:addObjectInLevel(name, isPixel, callback)
    local numImage = 1
    local path = DOC_DIR .. '/' .. CURRENT_LINK .. '/Images'

    while true do
        local file = io.open(path .. '/Image' .. numImage, 'r')
        if file then
            numImage = numImage + 1
            io.close(file)
        else
            P.importName = name
            P.importIsPixel = isPixel
            P.importCallback = callback
            P.importTextureLink = 'Image' .. numImage

            GIVE_PERMISSION_DATA()
            FILE.pickFile(path, completeImportPicture,
                'Image' .. numImage, '', 'image/*', nil, nil, nil)

            break
        end
    end
end

function M:getSprite(guid)
    return CURRENT_LINK .. '/Images/' .. guid
end

function M:getScene(guid)
    if P.guid == guid or not guid then
        return P.level
    end

    P.guid = guid
    P.path = DOC_DIR .. '/' .. CURRENT_LINK .. '/Levels/' .. guid
    P.level = JSON.decode(READ_FILE(P.path))

    return P.level
end

function M:setBool(bool, type)
    clear()
    P[type] = bool
end

function M:getBool(type)
    return P[type]
end

function M:getActiveBool()
    for i = 1, #listTypes do
        if P[listTypes[i][1]] then
            return listTypes[i][1]
        end
    end
end

function M:save()
    WRITE_FILE(P.path, JSON.encode(P.level))
end

function M:getListTypes()
    return listTypes
end

function M:init()
    system.activate('multitouch')
end

return M

local Bytemap = require 'plugin.Bytemap'
local moonassimp = require 'plugin.moonassimp'
local tinyrenderer = require 'plugin.tinyrenderer'

local _ = require 'plugin.MemoryBlob'
local _ = require 'Core.Simulation.quatRotateEuler'
local quaternion = Quaternion.new(1, 0, 0, 0)
local M = {}

M.createObject = function(path, path2, baseDir)
    local import, errmsg = moonassimp.import_file(path,
        -- post-processing flags:
    	   'triangulate', 'gen normals')
    local meshes = import:meshes()

    local model = tinyrenderer.NewModel()
    local mesh1 = meshes[1]

    pcall(function()
        for i = 1, mesh1:num_vertices() do
        	model:AddVertex(mesh1:position(i))
        	model:AddNormal(mesh1:normal(i))
        	pcall(function() model:AddUV(mesh1:texture_coords(1, i)) end)
        end
    end)

    pcall(function()
        for i = 1, mesh1:num_faces() do
        	local face = mesh1:face(i)
        	model:AddFace(face:indices())
        end
    end)

    pcall(function()
        local bmap = Bytemap.loadTexture({
                filename = path2,
                baseDir = baseDir, is_non_external = true
            })
        moonassimp.release_import(import)

        local texture = tinyrenderer.NewTexture()
            texture:Bind(bmap:GetBytes({format = 'rgba'}), bmap.width, bmap.height, 4)
        model:SetDiffuse(texture)
    end)

    local object = tinyrenderer.NewObject(model)
        M.root:Insert(object)
    return object
end

M.scaleObject = function(obj, x, y, z)
    obj:SetScale(x, y, z)
end

M.rotateObject = function(obj, x, y, z)
    local quat = rotateQuaternionByEulerAngles(quaternion, x, y, z)
	obj:SetRotation(quat.x, quat.y, quat.z, quat.w)
end

M.moveObject = function(obj, x, y, z)
    obj:SetPosition(x, y, z)
end

M.eyeScene = function(x, y, z)
    M.scene:SetEye(x, y, z)
end

M.centerScene = function(x, y, z)
    M.scene:SetCenter(x, y, z)
end

M.createScene = function(width, height)
    if not M.scene then
        M.bm = Bytemap.newTexture({width = width, height = height, format = 'rgba'})
        M.image = display.newImage(M.bm.filename, M.bm.baseDir)
        M.image.x, M.image.y = display.contentCenterX, display.contentCenterY

        M.scene = tinyrenderer.NewScene(M.bm.width, M.bm.height, {has_alpha = true, using_blob = true})
        M.root = M.scene:GetRoot()
        M.bm:BindBlob(M.scene:GetBlob())
    end
end

M.removeScene = function()
    M.scene:Clear()
    M.scene = nil
    M.root = nil
    M.bm = nil
    M.image = nil
end

M.updateScene = function()
    M.scene:Clear()
    M.scene:Render()
    M.bm:invalidate()
end

return M

local render = require('render')
local path = system.pathForFile('squirrel/Ball OBJ.obj')

render.createScene(400, 400)
render.eyeScene(1, 0, 1)

local obj = render.createObject(path)
	render.scaleObject(obj, 0.3, 0.3, 0.3)
	render.moveObject(obj, -0.35, 0, 0.35)
	render.rotateObject(obj, 0, 0, 0)

local obj2 = render.createObject(path)
	render.scaleObject(obj2, 0.3, 0.3, 0.3)
	render.moveObject(obj2, 0.35, 0, -0.35)
	render.rotateObject(obj2, 0, 0, 0)

local x = 0
local x2 = 0

timer.performWithDelay(0, function()
	render.rotateObject(obj, x, 0, 0)
	render.rotateObject(obj2, x2, 0, 0)
	x = x + 5 x2 = x2 + 5
	render.updateScene()
end, 0)

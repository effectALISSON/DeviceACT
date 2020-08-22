extends Node

class_name Entity

var projectile = Projectile.new()
var helper = preload("res://objectHelper.tscn").instance()

var velocity = Vector2()
var speed = 100
var body = null
var lifes = 100

var gun = Data.items[0]

var dir_types = {
	"left": 0,
	"right": 1
}

var dir = dir_types['right']

func defineEntity(_body):
	body = _body
	_body.add_child(helper)
	pass

func isRunning():
	if velocity != Vector2():
		return true
	else:
		return false
	pass

func getDirAxis():
	return helper.dir
	pass

func updateEntity():
	if body:
		helper.setLookAt(body.get_global_mouse_position(), gun)
	pass

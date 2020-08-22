extends KinematicBody2D

class_name NPC

var helper_node = preload("res://objectHelper.tscn")
var bullet_node = preload("res://Bullet.tscn")
var ray_node = RayCast2D.new()

var velocity = Vector2()
var speed = 70
var max_speed = 0.800 * speed

var has_helper = null
var has_gun = null
var has_target = null

var health = 30

var may_fire = true
var ww = 0

var on_target_area = false

enum states {
	NONE,
	ANGRY,
	SCARY,
	WARNING
}

enum npc_type {
	NONE,
	COP
}

var ray_distance = 10

var ray_left = Vector2.LEFT * ray_distance
var ray_right = Vector2.RIGHT * ray_distance
var ray_up = Vector2.UP * ray_distance
var ray_down = Vector2.DOWN * ray_distance

var ray = ray_right

var ray_collide = null

var state = states.NONE
var npc = npc_type.NONE

var on_car = false

func addHelperNode():
	var data = helper_node.instance()
	has_helper = data
	add_child(data)
	
	var r_data = ray_node
	r_data.position = Vector2(0, 0)
	add_child(r_data)
	pass

func followTarget(target, _speed, dir = 1):
	if target:
		if dir > 0:
			velocity = (target.position - position) * Vector2(_speed, _speed)
		else:
			velocity = (-target.position + position) * Vector2(_speed, _speed)
	pass

func setTargetTo(target, _state):
	has_target = target
	state = _state
	pass

func setHarmHealth(gun, target, _state):
	if gun:
		health -= gun['bullet']['bullet_damage']
		has_target = target
		state = _state
	pass

func setHelperGun(gun):
	if has_helper:
		if gun:
			has_helper.setGun(gun)
		else:
			has_helper.setGun(null)
	pass

func setHelperLookAt(target):
	if has_helper:
		if target:
			has_helper.setLookAt(target)
	pass

func getHelperAxis():
	if has_helper:
		return has_helper.helper_axis
	pass

func getVelocity():
	if velocity != Vector2():
		return true
	else:
		return false
	pass

func fireBullet(_bullet, helper, gun):
	if helper:
		if gun:
			if may_fire == true:
				var data = _bullet.instance()
				data.setValues(helper.rotation_degrees, gun['bullet']['bullet_speed'], helper.getPosition(), gun['bullet'], self)
				get_parent().add_child(data)
				may_fire = false
	pass

func _ready():
	addHelperNode()
	pass

func _physics_process(delta):
	match state:
		states.NONE:
			pass
		states.WARNING:
			setHelperLookAt(has_target)
		states.ANGRY:
			followTarget(has_target, max_speed)
			setHelperLookAt(has_target)
			match npc:
				npc_type.COP:
					if on_target_area:
						fireBullet(bullet_node, has_helper, has_gun)
					
		states.SCARY:
			followTarget(has_target, max_speed * 0.55, -1)
	
	setHelperGun(has_gun)
	
	ray_node.force_raycast_update()
	ray_node.enabled = true
	ray_node.cast_to = ray
	
	if ray_node.is_colliding():
		ray_collide = ray_node.get_collider()
	else:
		ray_collide = null
	
	if velocity.y > 0:
		ray = ray_down
	elif velocity.y < 0:
		ray = ray_up
	elif velocity.x > 0:
		ray = ray_right
	elif velocity.x < 0:
		ray = ray_left
	
	if has_gun:
		if may_fire == false:
			if ww < has_gun['max_time_to_fire']:
				ww += 0.5
			else:
				may_fire = true
				ww = 0
		
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	pass

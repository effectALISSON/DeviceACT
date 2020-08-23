extends "res://NPC.gd"

var flip = false
var animation = "idle"

func _ready():
	max_speed = 0.900
	has_gun = Data.items[0]
	pass

func _physics_process(delta):
	var g_position = global_position
	var m_position = get_global_mouse_position()
	
	if getVelocity():
		animation = "run"
	else:
		animation = "idle"
	
	if getHelperAxis() == has_helper.axis.RIGHT:
		flip = false
	elif getHelperAxis() == has_helper.axis.LEFT:
		flip = true
		
	if Input.is_action_pressed("ui_up"):
		velocity.y = -max_speed
	elif Input.is_action_pressed("ui_down"):
		velocity.y = max_speed
	else:
		velocity.y = 0
		
	if Input.is_action_pressed("ui_left"):
		velocity.x = -max_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = max_speed
	else:
		velocity.x = 0
	
	$AnimatedSprite.flip_h = flip
	$AnimatedSprite.play(animation)
	
	if Input.is_action_pressed("ui_fire"):
		if on_car == false:
			fireBullet(bullet_node, has_helper, has_gun)
	
	setHelperLookAt(m_position)
	
		
	get_node("HUD/Icons/Gun").region_rect = has_gun['sprite']
	
	if Input.is_action_just_pressed("ui_x"):
		if ray_collide:
			if ray_collide.is_in_group("car"):
				ray_collide.drive(self)
	
	pass

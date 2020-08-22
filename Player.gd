extends "res://NPC.gd"

var flip = false
var animation = "idle"

func _ready():
	speed = 130
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
	
	"""if hand:
		get_node("helper/GunSprite").visible = true
		get_node("helper/GunSprite").region_rect = hand['sprite']
		
		if Input.is_action_pressed("ui_fire"):
			var p = Projectile.new()
			p.fireProjectile(hand, hand['bullet']['bullet_speed'], get_node("helper").rotation_degrees, get_node("helper/Position2D").global_position, self, get_parent())
	
	else:
		get_node("helper/GunSprite").visible = false"""
	
	has_gun = Data.items[0]
	setHelperLookAt(m_position)
	
	if Input.is_action_just_pressed("ui_x"):
		if ray_collide:
			if ray_collide.is_in_group("car"):
				ray_collide.drive(self)
	
	pass

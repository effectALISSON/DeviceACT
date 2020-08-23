extends KinematicBody2D

class_name NPC

var helper_node = preload("res://objectHelper.tscn")
var bullet_node = preload("res://Bullet.tscn")
var ray_node = RayCast2D.new()

var velocity = Vector2()
var speed = Vector2()
var max_speed = 0.010
var speed_limit = 1.6

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

var gun_bullets = 100

var loot = []

var is_shoot = false

var crimes = 0

func addHelperNode():
	var data = helper_node.instance()
	has_helper = data
	add_child(data)
	
	var r_data = ray_node
	r_data.position = Vector2(0, 0)
	add_child(r_data)
	pass

func followTarget(target, _speed):
	if target:
		velocity = ((target.position - position) * _speed) + Vector2(rand_range(-0.800, -0.800), rand_range(-0.300, 0.300))
	else:
		velocity = Vector2(0, 0)
	pass

func setTargetTo(target, _state):
	has_target = target
	state = _state
	pass

func setHarmHealth(damage, target, _state):
	health -= damage
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
			if gun['type'] == Data.item_type.GUN:
				if may_fire == true:
					if gun_bullets > 0:
						var bullet_own = null
						var data = _bullet.instance()
						
						if not  npc == npc_type.COP:
							bullet_own = self
						else:
							if Data.configs['intolerant_police'] == false:
								bullet_own = null
							else:
								bullet_own = self
						
						data.setValues(helper.rotation_degrees, gun['bullet']['bullet_speed'], helper.getPosition(), gun['bullet'], bullet_own)
						
						get_parent().add_child(data)
						
						may_fire = false
						gun_bullets -= gun['bullet']['use']
						is_shoot = true
						
						if self.is_in_group("player"):
							get_node("Animations/AnimationPlayer").play("shake")
	pass

func dropLoot(item_id):
	if item_id in Data.items:
		var i0 = preload("res://ItemCatch.tscn").instance()
		i0.item_id = item_id
		i0.position = position + Vector2(rand_range(0, 10), rand_range(0, 24))
		get_parent().add_child(i0)
		#print(str(item_id) + " Dropped loot item: " + str(Data.items[item_id]['name']))
	pass

func die(heal):
	if heal < 1:
		var x0 = Sprite.new()
		x0.texture = preload("res://_artwork_sprites.png")
		x0.region_enabled = true
		x0.region_rect = Rect2(0, 64, 16, 16)
		x0.position = position
		get_parent().add_child(x0)
		
		for i in loot:
			dropLoot(i)
		queue_free()
	pass

func _ready():
	addHelperNode()
	
	for i in rand_range(0, len(Data.items)):
		loot.append(i)
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
					if has_target:
						fireBullet(bullet_node, has_helper, has_gun)
	
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
				is_shoot = false
	
	die(health)
	
	#set_safe_margin(0.001)
	move_and_collide(velocity)
	pass

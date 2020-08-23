extends KinematicBody2D

class_name Vehicle

enum vehicle_type {
	NONE,
	CAR
}

var vehicle_data = {
	0:{
		"name": "Brown",
		"max_speed": 2.0,
		"speed": 0.05,
		"max_rot": 0.8,
		"sprite": Rect2(224, 0, 32,16),
		"type": vehicle_type.CAR
	}
}

var velocity = Vector2()
var speed = 100
var max_speed = 0.08 * speed

var data = null

var vehicle = vehicle_type.NONE
var has_driver = null

var has_driver_backup = null

var rot = 0.8

var spd = 0
var max_spd = 100

var car_crimes = 0

func drive(driver):
	if not has_driver:
		has_driver = driver
		enterVehicle(has_driver)
	else:
		exitVehicle(has_driver)
	pass

func enterVehicle(driver):
	driver.visible = false
	driver.get_node("CollisionShape2D").disabled = true
	driver.has_helper.getPosition().x += position.x
	driver.on_car = true
	pass

func exitVehicle(driver):
	driver.visible = true
	driver.position += Vector2(16, 16)
	driver.on_car = false
	if driver == has_driver:
		driver.get_node("CollisionShape2D").disabled = false
		has_driver = null
	pass

func interpolate(speed):
	spd += -(speed * 0.08)
	pass

func _physics_process(delta):
	match vehicle:
		vehicle_type.NONE:
			pass
		vehicle_type.CAR:
			if has_driver:
				has_driver.position = position
	
	if data:
		get_node("Sprite").region_rect = data['sprite']
		
		vehicle = data['type']
		
		if has_driver:
			if Input.is_action_pressed("ui_up"):
				if spd < data['max_speed']:
					spd += data['speed']
			elif Input.is_action_pressed("ui_down"):
				if spd > -data['max_speed']:
					spd -= data['speed']
			else:
				interpolate(spd)
					
			if not int(spd) == 0:
				if Input.is_action_pressed("ui_left"):
					rotation_degrees -= (data['max_rot'] + (spd * 0.008))
				elif Input.is_action_pressed("ui_right"):
					rotation_degrees += (data['max_rot'] + (spd * 0.008))
		else:
			interpolate(spd)
		
		velocity = Vector2(spd, 0)
	
	velocity = velocity.rotated(rotation)
	var hit = move_and_collide(velocity)
	
	if data:
		if hit:
			if has_driver:
				if int(spd) >= data['max_speed'] or int(spd) <= -data['max_speed']:
					if has_driver.is_in_group("player"):
						has_driver.get_node("Animations/AnimationPlayer").play("shake")
					
					if hit.collider.is_in_group("cop") or hit.collider.is_in_group("player"):
						hit.collider.setHarmHealth(1000, has_driver, hit.collider.state)
						car_crimes += 1
						has_driver.crimes += 1
					
					if hit.collider.is_in_group("car"):
						if not hit.collider == self:
							velocity += hit.collider.velocity * 2
	pass

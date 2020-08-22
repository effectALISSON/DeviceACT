extends KinematicBody2D

class_name Vehicle

enum vehicle_type {
	NONE,
	CAR
}

var vehicle_data = {
	0:{
		"name": "Brown",
		"max_speed": 300,
		"max_rot": 0.8,
		"sprite": Rect2(224, 0, 32,16),
		"type": vehicle_type.CAR
	}
}

var velocity = Vector2()
var speed = 100
var max_speed = 0.800 * speed

var data = null

var vehicle = vehicle_type.NONE
var has_driver = null

var has_driver_backup = null

var rot = 0.8

var spd = 0
var max_spd = 100

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
	driver.velocity += Vector2(32, 32)
	driver.on_car = false
	if driver == has_driver:
		driver.get_node("CollisionShape2D").disabled = false
		has_driver = null
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
		
		if velocity.x == 0 and velocity.y == 0:
			if spd != 0:
				spd = -(spd * 0.200)
		
		if has_driver:
			if Input.is_action_pressed("ui_up"):
				if spd < data['max_speed']:
					spd += 1
			elif Input.is_action_pressed("ui_down"):
				if spd > -data['max_speed']:
					spd -= 1
			else:
				if spd > 0:
					spd -= 1
				elif spd < 0:
					spd += 1
					
			if velocity != Vector2():
				if Input.is_action_pressed("ui_left"):
					rotation_degrees -= (data['max_rot'] + (spd * 0.008))
				elif Input.is_action_pressed("ui_right"):
					rotation_degrees += (data['max_rot'] + (spd * 0.008))
		else:
			if spd > 0:
				spd -= 1
			elif spd < 0:
				spd += 1
						
		velocity = Vector2(spd, 0)
	
	velocity = velocity.rotated(rotation)
	velocity = move_and_slide(velocity, Vector2(0, -1))
	pass

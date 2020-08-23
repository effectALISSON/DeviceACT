extends "res://NPC.gd"

var flip = false
var animation = "idle"

var area_target = null

func _ready():
	has_gun = Data.items[0]
	npc = npc_type.COP
	pass

func _physics_process(delta):
	if getHelperAxis() == has_helper.axis.RIGHT:
		flip = false
	elif getHelperAxis() == has_helper.axis.LEFT:
		flip = true
	
	if area_target:
		if area_target.is_in_group("cop") and has_target == area_target:
			setTargetTo(area_target, states.ANGRY)
			
		if area_target.is_in_group("player"):
			on_target_area = true
			if area_target.crimes > 0:
				setTargetTo(area_target, states.ANGRY)
			else:
				if area_target.is_shoot == true:
					setTargetTo(area_target, states.ANGRY)
				
		if area_target.is_in_group("car"):
			if area_target.car_crimes > 0:
				if area_target.has_driver:
					setTargetTo(area_target.has_driver, states.ANGRY)
	
	$AnimatedSprite.flip_h = flip
	
	if getVelocity():
		animation = "run"
	else:
		animation = "idle"
	
	$AnimatedSprite.play(animation)
	pass

func _on_Area2D_body_entered(body):
	area_target = body
	if area_target.is_in_group("player"):
		on_target_area = true
		if area_target.has_gun:
			if area_target.has_gun['type'] == Data.item_type.GUN:
				if area_target.crimes < 1:
					setTargetTo(area_target, states.WARNING)
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		on_target_area = false
	area_target = null
	pass # Replace with function body.

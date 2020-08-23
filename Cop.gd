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
	
	$AnimatedSprite.flip_h = flip
	
	if getVelocity():
		animation = "run"
	else:
		animation = "idle"
	
	$AnimatedSprite.play(animation)
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		on_target_area = true
		if body.has_gun:
			setTargetTo(body, states.ANGRY)
		else:
			setTargetTo(body, states.WARNING)
	area_target = body
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		on_target_area = false
	area_target = null
	pass # Replace with function body.

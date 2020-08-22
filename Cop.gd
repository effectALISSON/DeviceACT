extends "res://NPC.gd"

var flip = false
var animation = "idle"

func _ready():
	has_gun = Data.items[0]
	max_speed = 0.800 * 2
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
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		on_target_area = false
	pass # Replace with function body.

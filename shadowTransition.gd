extends Control

export(String, FILE, "*.tscn") var go_scene

export var transition_show = true

func _ready():
	$CanvasLayer/ColorRect.color = Color(0,0,0,0)
	if transition_show == true:
		$AnimationPlayer.play("show")
	else:
		$AnimationPlayer.play("close")
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "close":
		get_tree().change_scene(go_scene)
	elif anim_name == "show":
		queue_free()
	pass # Replace with function body.

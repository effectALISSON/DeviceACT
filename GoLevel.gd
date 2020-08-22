extends Area2D

export(String, FILE, "*.tscn") var go = ""

func _on_GoLevel_body_entered(body):
	if body.is_in_group("player"):
		body.createTransitionScreen(false, go)
	pass # Replace with function body.

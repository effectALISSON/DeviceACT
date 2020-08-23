extends Area2D

export var item_id = 0

func _physics_process(delta):
	if item_id in Data.items:
		get_node("Sprite").region_rect = Data.items[item_id]['sprite']
	else:
		queue_free()
	pass


func _on_ItemCatch_body_entered(body):
	if body.is_in_group("player"):
		if Data.items[item_id]['type'] == Data.item_type.CATCH:
			match item_id:
				1:
					body.gun_bullets += 10
					
		if Data.items[item_id]['type'] == Data.item_type.GUN:
			body.has_gun = Data.items[item_id]
		queue_free()
	pass # Replace with function body.

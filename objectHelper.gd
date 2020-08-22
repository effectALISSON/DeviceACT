extends Node2D

enum axis {
	LEFT,
	RIGHT
}

var helper_axis = axis.RIGHT

func getPosition():
	return get_node("helperPosition").global_position
	pass

func setSprite(filename, rect):
	get_node("helperSprite").region_enabled = true
	get_node("helperSprite").region_rect = rect
	get_node("helperSprite").texture = filename
	pass

func setSpriteVisible(set):
	get_node("helperSprite").visible = set
	pass

func setGun(gun):
	if gun:
		setSprite(preload("res://_artwork_items_0.png"), gun['sprite'])
		setSpriteVisible(true)
	else:
		setSprite(null, Rect2(0,0,0,0))
		setSpriteVisible(false)
	pass

func setLookAt(target):
	if target is Vector2:
		look_at(target)
	else:
		look_at(target.position)
	
	if global_position > get_node("helperPosition").global_position:
		get_node("helperSprite").flip_v = true
		helper_axis = axis.LEFT
	elif global_position < get_node("helperPosition").global_position:
		get_node("helperSprite").flip_v = false
		helper_axis = axis.RIGHT
	pass

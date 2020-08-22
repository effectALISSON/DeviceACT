extends Area2D

var velocity = Vector2()

var particle = preload("res://objectParticles.tscn")

var speed = 0
var data = null

var by = null

func setValues(_rotation, _speed, _position, _data, _by):
	rotation_degrees = _rotation
	speed = _speed
	position = _position
	data = _data
	by = _by
	pass

func _physics_process(delta):
	$Sprite.region_rect = data['sprite']
	velocity = Vector2(speed, 0)
	velocity = velocity.rotated(rotation)
	
	position += velocity
	pass

func _on_Bullet_body_entered(body):
	if body.is_in_group("cop"):
		if by:
			body.setHarmHealth(by.has_gun, by, body.states.ANGRY)
	queue_free()
	pass # Replace with function body.

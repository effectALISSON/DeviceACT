extends Node

var bullet = preload("res://Bullet.tscn")

class_name Projectile

func fireProjectile(gun_data, speed, rot, pos, by, node):
	var b = bullet.instance()
	b.setValues(rot, gun_data['bullet']['bullet_speed'], pos, gun_data['bullet'], by)
	node.add_child(b)
	pass

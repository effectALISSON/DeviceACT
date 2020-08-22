extends Node

var bullets = {
	0:{
		'sprite': Rect2(16,0,16,16),
		'bullet_damage': 2,
		'bullet_speed': 5,
		'max_bullet_fire_time': 10,
		'bullet_fire_time': 10
	}
}

var types = {
	'gun': 0
}

var items = {
	0: {
		'name': 'Pistol',
		'sprite': Rect2(0,0,16,16),
		'bullet': bullets[0],
		'type': types['gun'],
		'max_time_to_fire': 10
	}
}
var max_test_time = 10

var test_time = max_test_time

var gun = [0]

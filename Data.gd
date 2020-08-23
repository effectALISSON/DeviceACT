extends Node

var bullets = {
	0: {
		'sprite': Rect2(16,0,16,16),
		'bullet_damage': 2,
		'bullet_speed': 5,
		'max_bullet_fire_time': 10,
		'bullet_fire_time': 10,
		'use': 1
	},
	1: {
		'sprite': Rect2(16,16,16,16),
		'bullet_damage': 10,
		'bullet_speed': 10,
		'max_bullet_fire_time': 10,
		'bullet_fire_time': 10,
		'use': 4
	}
}

enum item_type {
	CATCH,
	GUN
}

var items = {
	0: {
		'name': 'Pistol',
		'sprite': Rect2(0,0,16,16),
		'bullet': bullets[0],
		'type': item_type.GUN,
		'max_time_to_fire': 10
	},
	1: {
		'name': 'Munition',
		'sprite': Rect2(32, 0, 16, 16),
		'type': item_type.CATCH,
	},
	2: {
		'name': 'ShootGun',
		'sprite': Rect2(0,16,16,16),
		'bullet': bullets[1],
		'type': item_type.GUN,
		'max_time_to_fire': 30
	}
}
var max_test_time = 10

var test_time = max_test_time

var gun = [0]

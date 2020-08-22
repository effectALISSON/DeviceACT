extends "res://Vehicle.gd"

export var vehicle_id = 0

func _ready():
	if vehicle_id in vehicle_data:
		data = vehicle_data[vehicle_id]
	pass

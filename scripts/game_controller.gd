extends Node

var total_points: int = 0

func points_get(value:int):
	total_points += value
	EventController.emit_signal("points_get", total_points)
	

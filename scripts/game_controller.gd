extends Node

var total_points: int = 0

func coin_collected(value:int):
	total_points += value
	EventController.emit_signal("coin_collected", total_points)

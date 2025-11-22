extends Node

var total_points: int = 0
var total_medjed: int = 0

#points system
func points_get(value:int):
	total_points += value
	EventController.emit_signal("points_get", total_points)
	
#Global Medjed counter
func medjed_spawn(value:int):
	total_medjed += 1
	EventController.emit_signal("medjed_spawn", total_medjed)
	
	
func medjed_killed(value:int):
	total_medjed -= 1
	EventController.emit_signal("medjed_killed", total_medjed)
	
	
	
	

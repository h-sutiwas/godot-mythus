extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.play("closed")
	$AnimationPlayer.play("RESET")
	EventController.connect("objective_LV_pass", on_event_LV_pass)
	
func on_event_LV_pass(value: bool) -> void:
	$AnimatedSprite2D.play("open")
	$AnimationPlayer.play("door_glowing")
	

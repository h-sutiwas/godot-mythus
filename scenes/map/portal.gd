extends Node2D

var clear = false
var step = 0

func _ready() -> void:
	$AnimatedSprite2D.play("closed")
	$AnimationPlayer.play("RESET")
	EventController.connect("objective_LV_pass", on_event_LV_pass)
	
func on_event_LV_pass(value: bool) -> void:
	$AnimatedSprite2D.play("open")
	$AnimationPlayer.play("door_glowing")
	clear = true



func _on_area_2d_body_entered(body) -> void:
	if body is Player and clear == true and step == 0:
		#GameController.
		$sfx_warp_sound.play()
		print("Go to next level!! (soon...)")
		step += 1

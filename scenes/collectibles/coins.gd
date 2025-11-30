class_name Coin extends Node2D

#points get from collect
@export var value: int = 1

func _ready():
	$AnimationPlayer.play("collect_float")

func _on_area_2d_body_entered(body):
	if body is Player:
		GameController.points_get(value)
		GameController.coins_get(value)
		$AnimationPlayer.play("collect_collected")
		$"AudioStreamPlayer2D".play()
		get_node("Timer").start()

func _on_timer_timeout() -> void:
	self.queue_free()

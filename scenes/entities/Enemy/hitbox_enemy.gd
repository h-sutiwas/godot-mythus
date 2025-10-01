class_name hitbox_enemy
extends Area2D

@export var damage := 10


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	collision_layer = 2
	collision_mask = 0
	pass # Replace with function body.

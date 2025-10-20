extends Area2D
class_name HitBox

signal Damaged( hurt_box : HurtBox )

#@onready var parent : Node = $"../.."

func _ready():
	pass # Replace with function body



func TakeDamage( hurt_box : HurtBox ) -> void:
	Damaged.emit( hurt_box )

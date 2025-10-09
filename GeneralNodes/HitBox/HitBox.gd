extends Area2D
class_name HitBox

signal Damaged( damage : int )

func _ready():
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame
func _process( delta ):
	pass

func TakeDamage( damage : int ) -> void:
	print("Take Damage:", damage)
	Damaged.emit( damage )

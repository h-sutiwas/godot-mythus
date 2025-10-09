extends Area2D
class_name HurtBox

@export var damage : int = 1

func _ready():
	area_entered.connect( Area2DEntered )
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame
func _process( delta ):
	pass

func Area2DEntered( a ):
	if a is HitBox:
		a.TakeDamage( damage )

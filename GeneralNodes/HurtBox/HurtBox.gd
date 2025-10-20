extends Area2D
class_name HurtBox

@export var damage : int = 1

func _ready():
	area_entered.connect( _on_area_entered )
	pass # Replace with function body



func _on_area_entered( a ):
	if a is HitBox:
		a.TakeDamage( self )

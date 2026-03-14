class_name HurtBox
extends Area2D



signal received_damage( _hit_box : HitBox )
#@export var effect : String

func _ready():
	area_entered.connect( _on_area_entered )
	pass # Replace with function body


func _on_area_entered( _hit_box : HitBox ):
	#print( "HurtBox detected something entering: ", _hit_box.name, _hit_box.get_parent() )
	if _hit_box != null:
		#print( "It was a HitBox, Signaling to take damage" )
		received_damage.emit( _hit_box )
	pass

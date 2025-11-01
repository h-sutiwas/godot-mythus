extends Node
class_name PlayerInteractionsHost

@onready var player: Player = $".."
@onready var interactions_polygon_2d: CollisionPolygon2D = $"../HurtBox/CollisionPolygon2D"

# Called when the node enters the scene tree for the first time
func _ready():
	player.direction_changed.connect( UpdateDirection )
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame
func _process( delta: float ) -> void:
	pass

func UpdateDirection( new_direction : Vector2 ) -> void:
	match new_direction:
		Vector2.LEFT:
			interactions_polygon_2d.scale.x = -1
		Vector2.RIGHT:
			interactions_polygon_2d.scale.x = 1
		_:
			pass
	pass

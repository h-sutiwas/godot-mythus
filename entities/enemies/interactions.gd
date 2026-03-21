extends Node
class_name EnemyInteractionsHost

@onready var enemy : EnemyRevised = $".."
@onready var collision_shape_2d : CollisionShape2D = $"../HurtBox/CollisionShape2D"

# Called when the node enters the scene tree for the first time
func _ready():
	enemy.direction_changed.connect( UpdateDirection )
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame
func _process( delta: float ) -> void:
	pass

func UpdateDirection( new_direction : Vector2 ) -> void:
	match new_direction:
		Vector2.LEFT:
			collision_shape_2d.scale.x = -1
		Vector2.RIGHT:
			collision_shape_2d.scale.x = 1
		_:
			pass
	pass

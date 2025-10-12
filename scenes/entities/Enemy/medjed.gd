class_name Medjed extends CharacterBody2D
@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

var isAttacking = false
var pos : Vector2
var spawn_pos : Vector2


func _ready():
	pos = global_position
	if isAttacking == false:
		$Laser.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

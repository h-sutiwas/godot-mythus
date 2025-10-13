class_name Medjed extends CharacterBody2D
@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

var isAttacking = false
var pos : Vector2
var spawn_pos : Vector2
var player_move : bool
var player_pos : Vector2
var player_oldpos : Vector2


func _ready():
	pos = global_position
	player_pos = player.global_position
	player_oldpos = player.global_position
	if isAttacking == false:
		$Laser.visible = false



func _physics_process(delta: float) -> void:
	player_pos = player.global_position
	#check if player move
	if player_pos != player_oldpos:
		player_move = true
	else:
		player_move = false
		
	
	
	
	
	
	
	
	
	
	player_oldpos = player_pos

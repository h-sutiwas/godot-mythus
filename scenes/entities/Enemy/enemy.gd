extends CharacterBody2D
@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

const SPEED = 50.0
const dist_before_attack = 90.0
var pos : Vector2
var old_pos : Vector2
var moving : bool;

func _ready():
	old_pos = global_position
	pos = global_position


func _physics_process(delta: float) -> void:
	#shortest path to player
	var direction := position.direction_to(player.global_position).normalized()
	velocity = direction * SPEED
	pos = global_position
	#print(pos)
	#enemy walk (not near player)
	if position.distance_to(player.global_position) > dist_before_attack:
		animated_sprites.play("walk")
		move_and_slide()
		
	#enemy stop (near player)
	if position.distance_to(player.global_position) < dist_before_attack:
		animated_sprites.play("attack")
	
	#enemy stop (all distance)
	#if pos == old_pos: 
		#animated_sprites.play("idle")
		

	
	
#walk animation
	if velocity.x > 0:
		$AnimatedSprite2D.scale.x = -1
	if velocity.x < 0:
		$AnimatedSprite2D.scale.x = 1
	old_pos = pos

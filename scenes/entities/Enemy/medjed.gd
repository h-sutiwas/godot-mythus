class_name Medjed extends CharacterBody2D
@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

const dist_before_attack = 300
const dist_toscreen_x = 500
const dist_toscreen_y = 300
var isAttacking = false
var isVisible = false
var isPlayerNear = false
var pos : Vector2
var spawn_pos : Vector2
var player_move : bool
var player_pos : Vector2
var player_oldpos : Vector2

#var screen_limitx : Vector2
#var screen_limity : Vector2


func _ready():
	pos = global_position
	player_pos = player.global_position
	player_oldpos = player.global_position
	$warning.play("warning")
	if isAttacking == false:
		$Laser.visible = false
		$warning.visible = false




func _physics_process(delta):
	player_pos = player.global_position
	
	
	#check if player move
	if player_pos != player_oldpos:
		player_move = true
	else:
		player_move = false
		
	#when player is near
	if position.distance_to(player.global_position) < dist_before_attack:
		isAttacking = true
		$warning.visible = true
		
		#too many play same time?????
		#$"sfx_medjed_warning".play()
		#Timer #count ซัก 5 วิ
		
	#when player is not near
	if position.distance_to(player.global_position) > dist_before_attack:
		$warning.visible = false
		
		
		
		
		
		
	#medjed turn left/right toward player
	if player_pos.x > pos.x:
		$AnimatedSprite2D.scale.x = -1
	if player_pos.x < pos.x:
		$AnimatedSprite2D.scale.x = 1
	
	
	
	
	
	
	
	
	player_oldpos = player_pos

class_name Enemy_Attack
extends EnemyState

#var player : CharacterBody2D
var isAttacking : bool = false

@onready var idle : Enemy_Idle = $"../Idle"
@onready var wander : Enemy_Wander = $"../Wander"
@onready var chase : Enemy_Chase = $"../Chase"

@onready var hurt_box: HurtBox = $"../../HurtBox"

@export var attack_sound : AudioStream
@onready var audio : = $"../../AudioStreamPlayer2D"

## What happens when the enemy exit this State?
func Enter() -> void:
	isAttacking = true
	#player = get_tree().get_first_node_in_group( "Player" )
	enemy.animated_sprites.play( "attack" )
	enemy.animated_sprites.animation_finished.connect( EndAttack )
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range( 0.9, 1.1 )
	audio.play()
	
	await get_tree().create_timer( 0.075 ).timeout


## What happens when the enemy exits this State?
func Exit() -> void:
	isAttacking = false
	enemy.animated_sprites.animation_finished.disconnect( EndAttack )


## What happens during the _process update in this State?
func Process( _delta : float ):	
	var direction = enemy.global_position - enemy.player.global_position
	
	if isAttacking == false:
		if direction.length() > enemy.dist_before_chase: 
			return idle 
		else:
			return chase
	return null


## What happens during the _process update in this State?
func Physics( _delta : float ):
	enemy.velocity = Vector2.ZERO
	return null

func EndAttack():
	isAttacking = false

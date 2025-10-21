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
	enemy.AtkBall.visible = true
	#enemy.AtkBall
	enemy.animated_sprites.play( "attack" )
	enemy.animated_sprites.animation_finished.connect( EndAttack )
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range( 0.9, 1.1 )
	audio.play()
	
	await get_tree().create_timer( 0.075 ).timeout


## What happens when the enemy exits this State?
func Exit() -> void:
	isAttacking = false
	enemy.AtkBall.visible = false
	enemy.animated_sprites.animation_finished.disconnect( EndAttack )


## What happens during the _process update in this State?
func Process( _delta : float ):
	return null


## What happens during the _process update in this State?
func Physics( _delta : float ):
	var direction = enemy.global_position - enemy.player.global_position
	
	if enemy.global_position.x - enemy.player.global_position.x < 0:
		enemy.animated_sprites.scale.x = -1
	else:
		enemy.animated_sprites.scale.x = 1
	
	enemy.velocity = Vector2.ZERO
	
	var ball_direction = enemy.position.direction_to( enemy.player.global_position ).normalized()
	enemy.AtkBall.position = enemy.position + ( 15 * ball_direction )
	enemy.AtkBall.rotation = randf_range( 0, 180 )
	
	if isAttacking == false:
		if direction.length() > enemy.dist_before_chase: 
			return idle 
		else:
			return chase
	
	return null

func EndAttack():
	isAttacking = false

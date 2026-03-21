class_name Enemy_Attack
extends EnemyState

var isAttacking : bool = false

@onready var idle : Enemy_Idle = $"../Idle"
@onready var wander : Enemy_Wander = $"../Wander"
@onready var chase : Enemy_Chase = $"../Chase"
@onready var stun : Enemy_Stun = $"../Stun"
@onready var destroyed : Enemy_Destroy = $"../Destroy"

@export var attack_sound : AudioStream
@onready var audio : = $"../../Audio/AudioStreamPlayer2D"

var _damage_position : Vector2

## What happens when the enemy exit this State?
func Enter() -> void:	
	enemy.velocity = Vector2.ZERO
	
	isAttacking = true
	enemy.hit_box.monitorable = true

	enemy.animated_sprites.play( "attack" )
	enemy.animated_sprites.animation_finished.connect( EndAttack )
	
	var ball_direction = enemy.position.direction_to( enemy.player.global_position ).normalized()
	enemy.AtkBall.position = enemy.position + ( 15 * ball_direction )
	enemy.AtkBall.rotation = randf_range( 0, 180 )	
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range( 0.9, 1.1 )
	audio.play()
		
	await get_tree().create_timer( 0.75 ).timeout
	pass


## What happens when the enemy exits this State?
func Exit() -> void:
	isAttacking = false
	enemy.hit_box.set_deferred( "monitorable", false )
	
	enemy.animated_sprites.animation_finished.disconnect( EndAttack )
	pass


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
	
	if isAttacking == false:
		if direction.length() > enemy.dist_before_chase: 
			return idle 
		else:
			return chase
	
	return null

func EndAttack():
	isAttacking = false

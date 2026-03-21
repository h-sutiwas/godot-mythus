class_name Enemy_Stun
extends EnemyState

@onready var idle : Enemy_Idle = $"../Idle"
@onready var wander : Enemy_Wander = $"../Wander"
@onready var chase : Enemy_Chase = $"../Chase"
@onready var attack : Enemy_Attack = $"../Attack"
@onready var destroyed : Enemy_Destroy = $"../Destroy"

@export var attack_sound : AudioStream
@onready var audio : = $"../../Audio/AudioStreamPlayer2D"

@export var knockback_speed : float = 100.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0

@export_category( "AI" )
@export var next_state : EnemyState

var hurt_box : HurtBox
var _move_direction : Vector2
var _damage_position : Vector2
var _animated_finished : bool = false

## What happens when we initialize this state?
func Init() -> void:
	enemy.enemy_damaged.connect( _on_enemy_damaged )


## What happens when the enemy exit this State?
func Enter() -> void:
	#print( "Enemy entering STUN state" )
	enemy.animated_sprites.play( "hurt" )
	enemy.animated_sprites.animation_finished.connect( _on_animated_finished )
	_animated_finished = false
	
	_move_direction = enemy.global_position.direction_to( _damage_position )
	enemy.velocity = _move_direction * knockback_speed
	enemy.set_direction( _move_direction )
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range( 0.9, 1.1 )
	audio.play()
	
	enemy.make_invulnerable( invulnerable_duration )
	await get_tree().create_timer( 0.075 ).timeout
	pass


## What happens when the enemy exits this State?
func Exit() -> void:
	enemy.animated_sprites.animation_finished.disconnect( _on_animated_finished )
	next_state = null
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> EnemyState:
	if _animated_finished == true:
		return next_state
	return null



## What happens during the _process update in this State?
func Physics( _delta : float ) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null



func _on_enemy_damaged( _hurt_box : HurtBox ) -> void:
	#print( "Stun state recieved 'enemy_damaged' signal, CHANGE STATE" )
	_damage_position = _hurt_box.global_position
	
	state_machine.ChangeState( self )
	pass



func _on_animated_finished() -> void:
	_animated_finished = true
	next_state = idle

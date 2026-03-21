class_name Enemy_Destroy
extends EnemyState

@onready var idle : Enemy_Idle = $"../Idle"
@onready var wander : Enemy_Wander = $"../Wander"
@onready var chase : Enemy_Chase = $"../Chase"
@onready var attack : Enemy_Attack = $"../Attack"
@onready var stun : Enemy_Stun = $"../Stun"

@export var attack_sound : AudioStream
@onready var audio : = $"../../Audio/AudioStreamPlayer2D"

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category( "AI" )

var hurt_box : HurtBox
var _move_direction : Vector2
var _damage_position : Vector2


## What happens when we initialize this state?
func Init() -> void:
	enemy.enemy_destroyed.connect( _on_enemy_destroyed )
	pass

## What happens when the enemy exit this State?
func Enter() -> void:
	enemy.invulnerable = true	
	_move_direction = enemy.global_position.direction_to( _damage_position )
	enemy.set_direction( _move_direction )
	enemy.velocity = _move_direction * knockback_speed
	enemy.animated_sprites.play( "death" )
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range( 0.9, 1.1 )
	audio.play()
	
	enemy.animated_sprites.animation_finished.connect( _on_animated_finished )
	pass


## What happens when the enemy exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null



## What happens during the _process update in this State?
func Physics( _delta : float ) -> EnemyState:
	return null



func _on_enemy_destroyed( hurt_box : HurtBox ) -> void:
	_damage_position = hurt_box.global_position
	state_machine.ChangeState( self )



func _on_animated_finished() -> void:
	enemy.queue_free()
	enemy.animated_sprites.visible = false

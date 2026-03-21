class_name Enemy_Idle
extends EnemyState

@onready var wander : Enemy_Wander = $"../Wander"
@onready var chase : Enemy_Chase = $"../Chase"
@onready var attack : Enemy_Attack = $"../Attack"
@onready var stun : Enemy_Stun = $"../Stun"
@onready var destroyed : Enemy_Destroy = $"../Destroy"

@export_category( "AI" )
@export var max_state_duration : float = 1.5
@export var min_state_duration : float = 0.5
@export var after_idle_state : EnemyState

var _timer : float = 0.0
var _damage_position : Vector2
var move_direction : Vector2

## What happens when the enemy exit this State?
func Enter() -> void:
	enemy.velocity = Vector2.ZERO
	_timer = randf_range( min_state_duration, max_state_duration )
	enemy.animated_sprites.play( "idle" )
	pass


## What happens when the enemy exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ):
	_timer -= _delta
	
	if _timer <= 0:
		return after_idle_state
		
	return null


## What happens during the _process update in this State?
func Physics( _delta : float ):
	
	var direction = enemy.global_position - enemy.player.global_position
	
	enemy.velocity = Vector2.ZERO
	
	if direction.length() <= enemy.dist_before_chase:
		return chase
	
	if direction.length() <= enemy.dist_before_attack:
		return attack

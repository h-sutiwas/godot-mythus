class_name Enemy_Wander
extends EnemyState

@onready var idle : Enemy_Idle = $"../Idle"
@onready var chase : Enemy_Chase = $"../Chase"
@onready var attack : Enemy_Attack = $"../Attack"
@onready var stun : Enemy_Stun = $"../Stun"
@onready var destroyed : Enemy_Destroy = $"../Destroy"

@export var wander_speed : float = 20.0

@export_category( "AI" )
@export var state_animated_duration : float = 0.5
@export var state_cyle_min : int = 1
@export var state_cyle_max : int = 3
@export var next_state : EnemyState

var _timer : float = 0.0
var _damage_position : Vector2
var _move_direction : Vector2


## What happens when we initialize this state?
func Init() -> void:
	pass


## What happens when the enemy exit this State?
func Enter() -> void:
	_timer = randi_range( state_cyle_min, state_cyle_max ) * state_animated_duration
	var rand = randi_range( 0, 3 )
	_move_direction = enemy.DIR_4[ rand ]
	enemy.velocity = _move_direction * wander_speed
	enemy.set_direction( _move_direction )
	enemy.animated_sprites.play( "walk" )
	pass

## What happens when the enemy exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return



## What happens during the _process update in this State?
func Physics( _delta : float ) -> EnemyState:	
	if enemy.velocity.length() > 0:
		enemy.animated_sprites.play( "walk" )
	else:
		return idle
	
	var direction = enemy.global_position - enemy.player.global_position
	
	if direction.length() <= enemy.dist_before_chase:
		return chase
	
	if direction.length() <= enemy.dist_before_attack:
		return attack
	
	return null

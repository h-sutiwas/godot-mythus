class_name Enemy_Chase
extends EnemyState

@onready var idle : Enemy_Idle = $"../Idle"
@onready var wander : Enemy_Wander = $"../Wander"
@onready var attack : Enemy_Attack = $"../Attack"
@onready var stun : Enemy_Stun = $"../Stun"
@onready var destroyed : Enemy_Destroy = $"../Destroy"

@export_category( "AI" )
@export var next_state : EnemyState

var _damage_position : Vector2
var _move_direction : Vector2

## What happens when we initialize this state?
func Init() -> void:
	pass


## What happens when the enemy exit this State?
func Enter() -> void:
	pass


## What happens when the enemy exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> EnemyState:
	return null


## What happens during the _process update in this State?
func Physics( _delta : float ) -> EnemyState:
	var _player_direction : Vector2 = enemy.global_position - enemy.player.global_position
	
	if enemy.global_position.x - enemy.player.global_position.x < 0:
		enemy.animated_sprites.scale.x = -1
	else:
		enemy.animated_sprites.scale.x = 1
	
	enemy.velocity = -_player_direction.normalized() * enemy.chase_speed
	enemy.animated_sprites.play( "walk" )
	
	if _player_direction.length() <= enemy.dist_before_attack:
		return attack
	
	if _player_direction.length() > enemy.dist_before_chase:
		return idle
	
	return null

class_name Enemy_Idle
extends EnemyState

@onready var wander : Enemy_Wander = $"../Wander"
@onready var chase : Enemy_Chase = $"../Chase"
@onready var attack : Enemy_Attack = $"../Attack"

var move_direction : Vector2
#var player : CharacterBody2D

## What happens when the enemy exit this State?
func Enter() -> void:
	enemy.animated_sprites.play( "idle" )
	#player = get_tree().get_first_node_in_group( "Player" )
	pass


## What happens when the enemy exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ):
	return null


## What happens during the _process update in this State?
func Physics( _delta : float ):
	var direction = enemy.global_position - enemy.player.global_position
	
	enemy.velocity = Vector2.ZERO
	
	if direction.length() <= enemy.dist_before_chase:
		return chase
	
	if direction.length() <= enemy.dist_before_attack:
		return attack

func timer():
	pass

class_name Enemy_Chase
extends EnemyState

@export var enemy : CharacterBody2D
@export var move_speed : float = 70.0

var player : CharacterBody2D


## What happens when the enemy exit this State?
func Enter() -> void:
	player = get_tree().get_first_node_in_group( "Player" )


## What happens when the enemy exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ):
	return null


## What happens during the _process update in this State?
func Physics( _delta : float ):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() < enemyRev.dist_before_chase:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2.ZERO
	
	if direction.length() > enemyRev.dist_before_chase:
		Transitioned.emit( self, "idle" )

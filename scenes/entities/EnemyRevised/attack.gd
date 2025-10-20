class_name Enemy_Attack
extends EnemyState


@export var enemy : CharacterBody2D
@export var move_speed : float = 70.0

var move_direction : Vector2
var wander_time : float
var isAttacking : bool = false

var player : CharacterBody2D

@onready var audio : = $"../../AudioStreamPlayer2D"

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
	return null

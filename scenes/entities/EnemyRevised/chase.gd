class_name Enemy_Chase
extends EnemyState

@onready var idle : Enemy_Idle = $"../Idle"
@onready var wander : Enemy_Wander = $"../Wander"
@onready var attack : Enemy_Attack = $"../Attack"

#var player : CharacterBody2D



func _ready():
	pass # Replace with function body.


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
	
	var direction = enemy.global_position - enemy.player.global_position
	enemy.velocity = -direction.normalized() * enemy.chase_speed
	enemy.animated_sprites.play( "walk" )
	
	if direction.length() <= enemy.dist_before_attack:
		return attack
	
	if direction.length() > enemy.dist_before_chase:
		return idle
	
	return null

class_name Enemy_Wander
extends EnemyState

@onready var idle : Enemy_Idle = $"../Idle"
@onready var chase : Enemy_Chase = $"../Chase"
@onready var attack : Enemy_Attack = $"../Attack"

var move_direction : Vector2
var wander_time : float
#var player : CharacterBody2D


func randomize_wander():
	move_direction = Vector2( randf_range( -1, 1 ), randf_range( -1, 1 ) ).normalized()
	wander_time = randf_range( 1, 3 )


func _ready():
	pass # Replace with function body.


## What happens when we initialize this state?
func Init() -> void:
	pass


## What happens when the enemy exit this State?
func Enter() -> void:
	randomize_wander()


## What happens when the enemy exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> EnemyState:
	if wander_time > 0:
		wander_time -= _delta
	else:
		randomize_wander()
	return



## What happens during the _process update in this State?
func Physics( _delta : float ) -> EnemyState:
	enemy.velocity = move_direction * enemy.regular_speed
	
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

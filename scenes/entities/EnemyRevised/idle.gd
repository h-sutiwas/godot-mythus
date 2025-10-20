class_name Enemy_Idle
extends EnemyState

@export var enemy : CharacterBody2D
@export var move_speed : float = 70.0

var move_direction : Vector2
var wander_time : float

var player : CharacterBody2D

func randomize_wander():
	move_direction = Vector2( randf_range( -1, 1 ), randf_range( -1, 1 ) ).normalized()
	wander_time = randf_range( 1, 3 )


func Enter():
	player = get_tree().get_first_node_in_group( "Player" )
	randomize_wander()


## What happens when the enemy exits this State?
func Exit() -> void:
	pass



func Process( _delta : float ):
	if wander_time > 0:
		wander_time -= _delta
	else:
		randomize_wander()



func Physics( _delta : float ):
	if enemy:
		enemy.velocity = move_direction * move_speed
	
	var direction = player.global_position - enemy.global_position
	
	if direction.length() < enemyRev.dist_before_chase:
		Transitioned.emit( self, "chase" )

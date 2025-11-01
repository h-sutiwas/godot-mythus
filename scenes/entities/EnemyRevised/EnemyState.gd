class_name EnemyState
extends Node


## Stores a reference to the enemy that this State belongs to
var enemy : EnemyRevised
var state_machine : EnemyStateMachine


func _ready():
	pass # Replace with function body.



## What happens when we initialize this state?
func Init():
	pass

## What happens when the enemy exit this State?
func Enter():
	pass


## What happens when the enemy exits this State?
func Exit():
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> EnemyState:
	return null



## What happens during the _process update in this State?
func Physics( _delta : float ) -> EnemyState:
	return null

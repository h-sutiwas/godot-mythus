class_name EnemyState
extends Node


## Stores a reference to the enemy that this State belongs to
static var enemy : EnemyRevised
static  var state_machine : EnemyStateMachine


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
	return null

class_name State
extends Node

## Stores a reference to the player that this State belongs to
static var player : Player
static  var state_machine : PlayerStateMachine

func _ready():
	pass # Replace with function body.



## What happens when we initialize this state?
func Init() -> void:
	pass

## What happens when the player exit this State?
func Enter() -> void:
	pass


## What happens when the player exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	return null



## What happens during the _process update in this State?
func Physics( _delta : float ) -> State:
	return null


## What happens during the _process update in this State?
func HandleInput( _event: InputEvent ) -> State:
	return null

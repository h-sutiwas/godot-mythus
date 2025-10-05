class_name State_Idle extends State

@onready var walk : State = $'../Walk'


## What happens when the player exit this State?
func Enter() -> void:
	player.UpdateAnimatedSprite( "idle" )
	pass


## What happens when the player exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null


## What happens during the _process update in this State?
func Physics( _delta : float ) -> State:
	return null


## What happens during the _process update in this State?
func HandleInput( _event: InputEvent ) -> State:
	return null

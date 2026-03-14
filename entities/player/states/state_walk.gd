extends State
class_name State_Walk

@export var move_speed : float = 200.0

@onready var idle : State = $"../Idle"
@onready var attack : State = $"../Attack"


## What happens when the player exit this State?
func Enter() -> void:
	player.animated_sprites.play( player.AnimSpritesDirection() )
	pass


## What happens when the player exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	return null


## What happens during the _process update in this State?
func Physics( _delta : float ) -> State:
	return null


## What happens during the _process update in this State?
func HandleInput( _event: InputEvent ) -> State:
	if _event.is_action_pressed( "attack" ):
		return attack
	
	return null

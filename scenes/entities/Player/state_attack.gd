class_name State_Attack extends State

var attacking : bool = false

@onready var animated_sprites : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var idle : State = $"../Idle"
@onready var walk : State = $"../Walk"

## What happens when the player exit this State?
func Enter() -> void:
	player.animated_sprites.play( "double_slash" )
	if not player.animated_sprites.animation_finished.is_connected( EndAttack ):
		player.animated_sprites.animation_finished.connect( EndAttack )
	attacking = true
	pass


## What happens when the player exits this State?
func Exit() -> void:
	if player.animated_sprites.animation_finished.is_connected( EndAttack ):
		player.animated_sprites.animation_finished.disconnect( EndAttack )
	attacking = false
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	player.velocity = Vector2.ZERO
	
	if attacking == false:
		return idle if player.direction == Vector2.ZERO else walk
	return null


## What happens during the _process update in this State?
func Physics( _delta : float ) -> State:
	return null


## What happens during the _process update in this State?
func HandleInput( _event: InputEvent ) -> State:
	if not _event.is_action_pressed( "attack" ):
		attacking = false
		return idle if player.direction == Vector2.ZERO else walk
	return null


## Additional function for ending attacking animated 2D
func EndAttack( _newAnimName : String ) -> void:
	attacking = false

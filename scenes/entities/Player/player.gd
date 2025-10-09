extends CharacterBody2D
class_name Player

const  MOVE_SPEED : float = 200.0
var direction : Vector2 = Vector2.ZERO # Declare the initial direction variable

@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine

signal DirectionChanged( new_direction : Vector2 )

# Called when the node enters the scene tree for the first time
func _ready():
	state_machine.Initialize( self )
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process( delta ):
	var input_count : int = 0
	
	if Input.get_action_strength("player_right"):
		input_count += 1
	if Input.get_action_strength("player_left"):
		input_count += 1
	if Input.get_action_strength("player_up"):
		input_count += 1
	if Input.get_action_strength("player_down"):
		input_count += 1
	
	if input_count >= 3:
		direction = Vector2.ZERO
	else:
		### Receive inputs from the player WASD buttons for movement
		direction.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
		direction.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
		
		### Normalized Diagonal Direction and Velocity calculation
		velocity = direction.normalized() * MOVE_SPEED if direction != Vector2.ZERO else Vector2.ZERO
	
	pass



@warning_ignore("unused_parameter")
func _physics_process( delta ):
	SetDirection() # Handling flipping
	move_and_slide() # Handles Movement



func SetDirection() -> bool:
	DirectionChanged.emit( direction )
	
	## Flipping Mechanics
	if direction.x < 0:
		animated_sprites.flip_h = true
		return true
	elif direction.x > 0:
		animated_sprites.flip_h = false
		return false
	else:
		return false



func AnimSpritesDirection() -> String:
	## Animated Sprites
	if direction == Vector2.ZERO:
		return "idle"
	else:
		if direction.y != 0:
			return "all_form_move"
		elif direction.x != 0:
			return "horizontal_move"
		else:
			return "idle"

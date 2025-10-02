class_name Player extends CharacterBody2D

var move_speed : float = 200.0
var current_direction : Vector2 = Vector2.ZERO # Store the last known direction for idle animation
var direction : Vector2 = Vector2.ZERO # Declare the initial direction variable

@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine




# Called when the node enters the scene tree for the first time
func _ready():
	state_machine.Initialize( self )
	pass # Replace with function body



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( delta ):
	
	
	### Receive inputs from the player WASD buttons for movement
	direction.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	direction.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	
	### Normalized Diagonal Direction and Velocity calculation
	velocity = direction.normalized() * move_speed if direction != Vector2.ZERO else Vector2.ZERO
	
	pass



func _physics_process( delta ):
	SetDirection()
	UpdateAnimatedSprite( AnimatedDirection() )
	move_and_slide()



func SetDirection() -> bool:
	
	## Flipping Mechanics
	if velocity.x < 0:
		animated_sprites.flip_h = true
		return true
	elif velocity.x > 0:
		animated_sprites.flip_h = false
		return false
	else:
		return false



func UpdateAnimatedSprite( state : String ) -> void:
	animated_sprites.play( AnimatedDirection() + "_" + "move" ) if state != "idle" else animated_sprites.play( state )



func AnimatedDirection() -> String:
	if velocity == Vector2.ZERO:
		return "idle"
	else:
		if velocity.y != 0:
			return "all_form"
		elif velocity.x != 0:
			return "vertical"
		else:
			return "idle"

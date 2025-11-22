extends CharacterBody2D
class_name Player

signal direction_changed( new_direction : Vector2 )
signal player_damaged( _hurt_box : HurtBox )

const  MOVE_SPEED : float = 200.0
var direction : Vector2 = Vector2.ZERO # Declare the initial direction variable

var invulnerable : bool = false
var hp : int = 6
var max_hp : int = 12

@export var damage : int = 3

@onready var hit_box: HitBox = $HitBox
@onready var hurt_box: HurtBox = $HurtBox

@onready var state_machine : PlayerStateMachine = $StateMachine
@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time
func _ready():
	GlobalPlayerManager.player = self
	state_machine.Initialize( self )
	hurt_box.received_damage.connect( _take_damage )
	hp = clampi( hp + 99, 0, max_hp )
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
	direction_changed.emit( direction )
	
	## Flipping Mechanics
	if direction.x < 0:
		animated_sprites.flip_h = true
		hit_box.scale.x = -1
		hurt_box.scale.x = -1
		return true
	elif direction.x > 0:
		animated_sprites.flip_h = false
		hit_box.scale.x = 1
		hurt_box.scale.x = 1
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



func _take_damage( _hit_box : HitBox ) -> void:
	
	#print( "Player taking damage" )
	if invulnerable == true:
		#print( "Player INVULNERABLE!" )
		return
	
	#update_hp( -_hit_box.damage )
	#print( "Current HP:", hp, " minus ", _hit_box.damage )
	hp = clampi( hp -_hit_box.damage, 0, max_hp )
	#print( "Current HP:", hp )
	
	#print( "Emitting 'player_damaged' signal." )
	
	if hp > 0:
		player_damaged.emit( hurt_box )
	else:
		player_damaged.emit( hurt_box )
		hp = clampi( hp + 99, 0, max_hp )


#func update_hp( delta : int ) -> void:
	#hp = clampi( hp + delta, 0, max_hp )
	#pass



func make_invulnerable( _duration : float = 1.0 ) -> void:
	invulnerable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer( _duration ).timeout
	
	invulnerable = false
	hit_box.monitoring = true
	
	pass

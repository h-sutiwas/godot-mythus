extends State
class_name State_Attack

var attacking : bool = false

@onready var idle : State = $"../Idle"
@onready var walk : State = $"../Walk"

@onready var animated_sprites : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var hurt_box: HurtBox = $"../../HurtBox"

@export var attack_sound : AudioStream
@onready var audio = $"../../Audio/AudioStreamPlayer2D"


## What happens when the player exit this State?
func Enter() -> void:
	player.animated_sprites.play( "double_slash" )
	animated_sprites.animation_finished.connect( EndAttack )
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range( 0.9, 1.1 )
	audio.play()
	
	attacking = true
	player.hit_box.visible = true
	
	await get_tree().create_timer( 0.075 ).timeout
	hurt_box.monitoring = true
	pass


## What happens when the player exits this State?
func Exit() -> void:
	animated_sprites.animation_finished.disconnect( EndAttack )
	attacking = false
	player.hit_box.visible = false
	
	hurt_box.monitoring = false
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
	if attacking == false:
		if not _event.is_action_pressed( "attack" ):
			return idle if player.direction == Vector2.ZERO else walk
		else:
			attacking = true
	return null

## Additional function for ending attacking animated 2D
func EndAttack( ) -> void:
	attacking = false

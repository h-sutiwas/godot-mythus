extends State
class_name State_Stun

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0

@onready var idle : State = $"../Idle"

var hurt_box : HurtBox
var direction : Vector2

var next_state : State = null


## What happens when we initialize this state?
func Init() -> void:
	player.player_damaged.connect( _player_damage )


## What happens when the player exit this State?
func Enter() -> void:
	player.animated_sprites.animation_finished.connect( _animation_finished )
	
	direction = player.global_position.direction_to( hurt_box.global_position )
	player.velocity = direction * -knockback_speed
	player.SetDirection()
	
	player.animated_sprites.play( "get_hit" )
	player.make_invulnerable( invulnerable_duration )
	pass


## What happens when the player exits this State?
func Exit() -> void:
	next_state = null
	player.animated_sprites.animation_finished.disconnect( _animation_finished )
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	return next_state


## What happens during the _process update in this State?
func Physics( _delta : float ) -> State:
	return null


## What happens during the _process update in this State?
func HandleInput( _event: InputEvent ) -> State:
	return null



func _player_damage( _hurt_box : HurtBox ) -> void:
	hurt_box = _hurt_box
	state_machine.ChangeState( self )
	pass



func _animation_finished( _a : String ) -> void:
	next_state = idle

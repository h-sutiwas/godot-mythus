extends State
class_name State_Stun

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0

@onready var idle : State = $"../Idle"

var hurt_box : HurtBox
var _move_direction : Vector2
var _damage_position : Vector2
var next_state : State = null

## What happens when we initialize this state?
func Init() -> void:
	player.player_damaged.connect( _on_player_damage )


## What happens when the player exit this State?
func Enter() -> void:
	#print( "Player entering STUN state" )
	player.animated_sprites.animation_finished.connect( _animated_finished )
	
	_move_direction = player.global_position.direction_to( _damage_position )
	player.velocity = _move_direction * -knockback_speed
	player.SetDirection()
	
	player.animated_sprites.play( "get_hit" )
	player.make_invulnerable( invulnerable_duration )
	
	await get_tree().create_timer( 0.075 ).timeout
	pass


## What happens when the player exits this State?w
func Exit() -> void:
	next_state = null
	player.animated_sprites.animation_finished.disconnect( _animated_finished )
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



func _on_player_damage( _hurt_box : HurtBox ) -> void:
	#print( "Stun state recieved 'player_damaged' signal, CHANGE STATE" )
	_damage_position = _hurt_box.global_position
	
	state_machine.ChangeState( self )
	pass



func _animated_finished() -> void:
	next_state = idle

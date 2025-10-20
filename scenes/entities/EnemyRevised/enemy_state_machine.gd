class_name EnemyStateMachine
extends Node

@export var initial_state : EnemyState


var states : Dictionary = {}
var prev_state : EnemyState
var current_state : EnemyState

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	for child in get_children():
		if child is EnemyState:
			states[ child.name.to_lower() ] = child
			child.Transitioned.connect( _on_child_transition )
	
	if initial_state:
		initial_state.Enter()
		current_state = initial_state



func _process( delta ):
	if current_state:
		current_state.Process( delta )


func _physics_process( delta ) -> void:
	if current_state:
		current_state.Physics( delta )



func _on_child_transition( state : EnemyState, new_state_name ):
	if state != current_state:
		return
	
	var new_state : EnemyState = states.get( new_state_name.to_lower() )
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state

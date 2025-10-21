class_name EnemyStateMachine
extends Node

var states : Array [ EnemyState ]
var prev_state : EnemyState
var current_state : EnemyState

# Called when the node enters the scene tree for the first time
func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame
func _process( delta ):
	ChangeState( current_state.Process( delta ) )
	pass



func _physics_process( delta ) -> void:
	ChangeState( current_state.Physics( delta ) )
	pass



func Initialize( _enemy : EnemyRevised ) -> void:
	states = []
	
	for c in get_children():
		if c is EnemyState:
			states.append(c)
	
	if states.size() == 0:
		return
	
	states[0].enemy = _enemy
	states[0].state_machine = self
	
	for state in states:
		state.Init()
	
	ChangeState( states[0] )
	process_mode = Node.PROCESS_MODE_INHERIT



func ChangeState( new_state : EnemyState ) -> void:
	if new_state == null or new_state == current_state:
		return
	print(current_state)
	if current_state:
		current_state.Exit()
	
	prev_state = current_state
	current_state = new_state
	print(current_state)
	current_state.Enter()

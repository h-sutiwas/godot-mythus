extends Node2D

@onready var main = get_node("/root/Playground")
@export var enemy_prefab : PackedScene
@export var target : Node2D
var spawn_points := []

const GENERAL_ENEMY_SCALE: Vector2 = Vector2( 2.5, 2.5 )

var enemy_num = 1 # 1 because default cyclops on field (change if no default cyclops)
var enemy_limit = 3 #set starting enemy limit
var timer_counter = 0 #condition to increase enemy limit / shorten spawn time
var spawn_time = 35
const spawn_time_decrease = 2
const least_spawn_time = 7



func _ready():
	EventController.connect("cyclops_spawn", on_event_cyclops_spawn)
	EventController.connect("cyclops_killed", on_event_cyclops_killed)
	$Timer.set_wait_time(spawn_time)
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

	

#spawn far from player?

func _on_timer_timeout() -> void:
	#set location
	var enemy = enemy_prefab.instantiate()
	enemy.scale = GENERAL_ENEMY_SCALE
	var spawn = spawn_points[randi() % spawn_points.size()]
	timer_counter +=1
	#spawn an enemy when enemy_num below limit
	if enemy_num < enemy_limit:
		enemy.position = spawn.position
		enemy.player = target
		main.add_child(enemy)

	
#receive outside signal for Cyclops counter, limit the shortest time interval between spawn
func on_event_cyclops_spawn(value: int) -> void:
	enemy_num += 1
	if spawn_time >= least_spawn_time:
		$Timer.set_wait_time(spawn_time)
		spawn_time -= spawn_time_decrease
	print("Cyclops on field: ", enemy_num, " spawn, Next spawn in ", spawn_time, "s, ", timer_counter, " cycles")

func on_event_cyclops_killed(value: int) -> void:
	enemy_num -= 1
	print("Cyclops on field: ", enemy_num, " killed")

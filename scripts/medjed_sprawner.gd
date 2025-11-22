extends Node2D

@onready var main = get_node("/root/Playground")
@export var enemy_prefab : PackedScene
@export var target : Node2D
var spawn_points := []


var enemy_num = 1 # 1 because default medjed on field (change if no default medjed)
var enemy_limit = 3 #set starting enemy limit
var timer_counter = 0 #condition to increase enemy limit / shorten spawn time
var spawn_time = 20
const least_spawn_time = 7



func _ready():
	EventController.connect("medjed_spawn", on_event_medjed_spawn)
	EventController.connect("medjed_killed", on_event_medjed_killed)
	$Timer.set_wait_time(spawn_time)
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

	

#spawn far from player?

func _on_timer_timeout() -> void:
	#set location
	var enemy = enemy_prefab.instantiate()
	var spawn = spawn_points[randi() % spawn_points.size()]
	timer_counter +=1
	#spawn an enemy when enemy_num below limit
	if enemy_num < enemy_limit:
		enemy.position = spawn.position
		enemy.player = target
		main.add_child(enemy)

	
#receive outside signal for Medjed counter
func on_event_medjed_spawn(value: int) -> void:
	enemy_num += 1
	print("Medjed on field: ", enemy_num, " spawn")

func on_event_medjed_killed(value: int) -> void:
	enemy_num -= 1
	print("Medjed on field: ", enemy_num, " killed")
	
	
	
	
	#limit the shortest time interval between spawn
	
	#if spawn_time >= least_spawn_time:
	#	$Timer.set_wait_time(spawn_time)
	#	spawn_time -= timer_counter
	#print("Times: ", timer_counter, " spawn timer: ", spawn_time, " enemy num: ")

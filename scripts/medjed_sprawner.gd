extends Node2D

@onready var main = get_node("/root/Playground")
@export var enemy_prefab : PackedScene
@export var target : Node2D
var spawn_points := []

#@onready var enemy = enemy_prefab.instantiate()
var enemy_num : int
var enemy_limit = 3 #set starting enemy limit
var timer_counter = 0 #condition to increase enemy limit / shorten spawn time
var spawn_time = 20
const least_spawn_time = 7



func _ready():
	$Timer.set_wait_time(spawn_time)
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

#func _process(delta: float) -> void:
	#enemy_num = main.get_child_count(enemy)
	

#spawn far from player?

func _on_timer_timeout() -> void:
	#set location
	var enemy = enemy_prefab.instantiate()
	var spawn = spawn_points[randi() % spawn_points.size()]
	timer_counter +=1
	
	
	#spawn an enemy when enemy_num below limit
	if enemy_num <= enemy_limit: #needs fixing!!!!
		enemy.position = spawn.position
		enemy.player = target
		main.add_child(enemy)

	
	#limit the shortest time interval between spawn
	
	#if spawn_time >= least_spawn_time:
	#	$Timer.set_wait_time(spawn_time)
	#	spawn_time -= timer_counter
	#print("Times: ", timer_counter, " spawn timer: ", spawn_time, " enemy num: ")

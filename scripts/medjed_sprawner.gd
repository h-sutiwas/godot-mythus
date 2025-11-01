extends Node2D

@onready var main = get_node("/root/Playground")
@export var enemy_prefab : PackedScene
@export var target : Node2D
var spawn_points := []

var enemy_num = 0

func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

#spawn far from player

func _on_timer_timeout() -> void:
	#set location
	var spawn = spawn_points[randi() % spawn_points.size()]
	
	#spawn an enemy
	if enemy_num < 3:
		var enemy = enemy_prefab.instantiate()
		enemy.position = spawn.position
		enemy.player = target
		main.add_child(enemy)
		enemy_num += 1

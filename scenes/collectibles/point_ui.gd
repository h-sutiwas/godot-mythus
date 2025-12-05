extends Control

@onready var label_score =$score
@onready var label_coin =$coin
@onready var label_enemy =$enemy
@onready var label_objective_coin =$Objective_coin


# Called when the node enters the scene tree for the first time.
func _ready():
	$levelUPtext.visible = false
	EventController.connect("points_get", on_event_points_get)
	EventController.connect("coins_get", on_event_coin_collected)
	EventController.connect("enemy_killed_pts", on_event_enemy_get)
	
	EventController.connect("objective_LV", on_event_LV_objective)
	EventController.connect("objective_coin_pass", on_event_LV_objective_coin_pass)
	
func on_event_LV_objective(value: Array) -> void:
	label_objective_coin.text = str(value[0])
	
func on_event_LV_objective_coin_pass(value: bool) -> void:
	label_objective_coin.set("theme_override_colors/font_color", Color(0.0, 0.901, 0.0, 1.0))
	

# Update UI when get score
func on_event_points_get(value: int) -> void:
	label_score.text = str(value)

# Update UI when get coin
func on_event_coin_collected(value: int) -> void:
	label_coin.text = str(value)

# Update UI when get points from enemy
func on_event_enemy_get(value: int) -> void:
	label_enemy.text = str(value)

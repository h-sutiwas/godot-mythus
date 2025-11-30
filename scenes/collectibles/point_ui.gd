extends Control

@onready var label_score =$score
@onready var label_coin =$coin
@onready var label_enemy =$enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	$levelUPtext.visible = false
	EventController.connect("points_get", on_event_points_get)
	EventController.connect("coins_get", on_event_coin_collected)
	EventController.connect("enemy_killed_pts", on_event_enemy_get)


# Update UI when get score
func on_event_points_get(value: int) -> void:
	label_score.text = str(value)

# Update UI when get coin
func on_event_coin_collected(value: int) -> void:
	label_coin.text = str(value)

# Update UI when get points from enemy
func on_event_enemy_get(value: int) -> void:
	label_enemy.text = str(value)

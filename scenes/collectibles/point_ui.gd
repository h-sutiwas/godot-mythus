extends Control

@onready var label =$score

# Called when the node enters the scene tree for the first time.
func _ready():
	EventController.connect("coin_collected", on_event_coin_collected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_event_coin_collected(value: int) -> void:
	label.text = str(value)

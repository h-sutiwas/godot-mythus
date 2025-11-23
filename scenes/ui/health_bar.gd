extends ProgressBar

@export var player : Player

func _ready():
	player.health_changed.connect( update_health_bar )
	update_health_bar()

func update_health_bar():
	value = 100 * player.hp / player.max_hp

class_name Player extends CharacterBody2D

@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
var move_speed : float = 400.0
var current_direction = 'down' # Store the last known direction for idle animation

# Called when the node enters the scene tree for the first time
func _ready():
	pass # Replace with function body

# Called every frame. 'delta' is the elapsed time since the previous time
#func _process(delta):
	#var direction : Vector2 = Vector2.ZERO
	#
	#direction.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	#direction.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	#
	#if direction.length() > 0:
		#direction = direction.normalized()
	#
	#velocity = direction * move_speed

func _physics_process(delta):
	var direction : Vector2 = Vector2.ZERO
	
	direction.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	direction.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	
	if direction.length() > 0:
		direction = direction.normalized()
	
	velocity = direction * move_speed
	
	move_and_slide()
	
	if velocity == Vector2.ZERO:
		animated_sprites.play("idle")
	else:
		if direction.x != 0:
			if direction.y != 0: 
				animated_sprites.play("move_around")
			else:
				animated_sprites.play("vertical_move")
		elif direction.y != 0:
			animated_sprites.play("move_around")
		
	
	

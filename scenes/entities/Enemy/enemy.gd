#ิbuilt in: เดี๋ยวลองแก้เอง
#shortest path to player

extends CharacterBody2D


const SPEED = 100.0

@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:

	var direction_x := Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var direction_y := Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	
	if velocity.x == 0 and velocity.y ==0:
		animated_sprites.play("idle")
	if velocity.x != 0 or velocity.y != 0:
		animated_sprites.play("walk")
	if velocity.x > 0:
		$AnimatedSprite2D.scale.x = -1
	if velocity.x < 0:
		$AnimatedSprite2D.scale.x = 1

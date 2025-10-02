extends CharacterBody2D
@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

const SPEED = 50.0
const dist_before_attack = 100.0
var isAttacking = false
var pos : Vector2
var old_pos : Vector2
var moving : bool;

func _ready():
	old_pos = global_position
	pos = global_position

# สร้าง func take_damage ด้วน


func _physics_process(delta: float) -> void:
	#shortest path to player
	var direction := position.direction_to(player.global_position).normalized()
	velocity = direction * SPEED
	pos = global_position
	
	#enemy walk (not near player)
	if position.distance_to(player.global_position) > dist_before_attack and isAttacking == false:
		animated_sprites.play("walk")
		move_and_slide()
		
	#enemy stop (near player)
	if position.distance_to(player.global_position) < dist_before_attack:
		animated_sprites.play("attack")
		isAttacking = true
		$AtkBall/hitbox_enemy/CollisionShape2D.disabled = false
	
	#enemy stop (all distance)
	if pos == old_pos and isAttacking == false:
		animated_sprites.play("idle")
		move_and_slide()
		
#walk animation
	if velocity.x > 0:
		$AnimatedSprite2D.scale.x = -1
	if velocity.x < 0:
		$AnimatedSprite2D.scale.x = 1
	old_pos = pos
	
	#AtkBall hide when not attack
	if isAttacking == false:
		$AtkBall.visible = false


#AtkBall attack
func _on_animated_sprite_2d_animation_changed() -> void:
	if $AnimatedSprite2D.animation == "attack" or isAttacking == true:
		$AtkBall.visible = true
		var direction := position.direction_to(player.global_position).normalized()
		$AtkBall.position = ($AnimatedSprite2D.position + (20 * direction))
		$AtkBall.rotation = randf_range(0,180)


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "attack":
		$AtkBall/hitbox_enemy/CollisionShape2D.disabled = true
		isAttacking = false
		

	

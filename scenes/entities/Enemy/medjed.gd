class_name Medjed extends CharacterBody2D
@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

#const dist_toscreen_x = 500
#const dist_toscreen_y = 300
var isAttacking = false
var pos : Vector2
var laser_rotate : int
#var spawn_pos : Vector2
var player_move : bool
var player_pos : Vector2
var player_oldpos : Vector2

#var screen_limitx : Vector2
#var screen_limity : Vector2


func _ready():
	pos = global_position
	player_pos = player.global_position
	player_oldpos = player.global_position
	$warning.play("warning")
	if isAttacking == false:
		$Laser.visible = false
		$warning.visible = false




func _physics_process(delta):
	player_pos = player.global_position
	
	
	#check if player move
	if player_pos != player_oldpos:
		player_move = true
	else:
		player_move = false
		
	#medjed turn left/right toward player
	if player_pos.x > pos.x:
		$AnimatedSprite2D.scale.x = -1
	if player_pos.x < pos.x:
		$AnimatedSprite2D.scale.x = 1
	
	
	
	
	
	
	
	
	
	player_oldpos = player_pos



func _on_danger_area_body_entered(body):
	var laser_slope: float
	if isAttacking == false and body is Player:
		isAttacking = true
		$warning.visible = true
		$"sfx_medjed_warning".play()
		
		#ปรับ position / rotation ก่อน timer + warning sight ขยับได้ 2 วิก่อนยิง?
		
		laser_slope = (pos.y - player_pos.y)/(player_pos.x - pos.x) # y เกมกลับด้าน!!!!
		laser_rotate = rad_to_deg(atan(laser_slope))
		if pos.x > player_pos.x:
			laser_rotate +=180
		if pos.y < player_pos.y and pos.x < player_pos.x:
			laser_rotate +=360
		$Laser.rotation_degrees = -laser_rotate
		
		#wait before attack
		await get_tree().create_timer(3).timeout
		
		
		$Laser.visible = true
		$sfx_medjed_atk.play()
		$AnimationPlayer.play("laser_shoot")
		
		print("atk!")
		
		#animtaion end
		


func _on_animation_player_animation_finished(anim_name: StringName):
	if anim_name == 'laser_shoot':
		$Laser.visible = false
		$AnimationPlayer.play("medjed_dead")
		$warning.visible = false
		await get_tree().create_timer(2).timeout
		self.queue_free()
		

class_name Medjed extends CharacterBody2D
@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

#const dist_toscreen_x = 500
#const dist_toscreen_y = 300
const atk_warnsec = 2
const atk_atksec = 1
const pts_get = 1
var isAttacking = false
var isWarning = false
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
	$AnimationPlayer.play("medjed_spawn")
	if isAttacking == false:
		$Laser.visible = false
		$Lasersight.visible = false
		$warning.visible = false



func _physics_process(delta):
	var laser_slope: float
	player_pos = player.global_position
	
	#check if player move
	if player_pos != player_oldpos:
		player_move = true
	else:
		player_move = false
		
	
	#laser rotation calculation
	laser_slope = (pos.y - player_pos.y)/(player_pos.x - pos.x)
	laser_rotate = rad_to_deg(atan(laser_slope))
	if pos.x > player_pos.x:
		laser_rotate +=180
	if pos.y < player_pos.y and pos.x < player_pos.x:
		laser_rotate +=360
	
	#when not atk: medjed turn left/right toward player, lasersight rotate toward player
	if isWarning == false:
		$Lasersight.rotation_degrees = -laser_rotate
		if player_pos.x > pos.x:
			$AnimatedSprite2D.scale.x = -1
		if player_pos.x < pos.x:
			$AnimatedSprite2D.scale.x = 1
	
	
	
	
	
	
	
	
	player_oldpos = player_pos


#Medjed laser attack
func _on_danger_area_body_entered(body):
	if isAttacking == false and body is Player:
		medjed_atk()
		


func _on_animation_player_animation_finished(anim_name: StringName):
	if anim_name == 'laser_shoot':
		medjed_dead()


#medjed warning and attack
func medjed_atk():
	isAttacking = true
	$"sfx_medjed_warning".play()
	$warning.play("warning")
	$warning.visible = true
	$Lasersight.visible = true
	
	#warn/wait before attack
	await get_tree().create_timer(atk_warnsec).timeout
	isWarning = true
	$Lasersight.rotation_degrees = -laser_rotate
	$Laser.rotation_degrees = -laser_rotate
	
	await get_tree().create_timer(atk_atksec).timeout
	$Lasersight.visible = false
	$warning.visible = false
	$Laser.visible = true
	$sfx_medjed_atk.play()
	$AnimationPlayer.play("laser_shoot")

#medjed dead / after shoot laser
func medjed_dead():
	GameController.points_get(pts_get)
	$AnimationPlayer.play("medjed_dead")
	$sfx_medjed_dead.play()
	$warning.visible = false
	await get_tree().create_timer(2).timeout
	self.queue_free()

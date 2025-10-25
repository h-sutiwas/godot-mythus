class_name Medjed extends CharacterBody2D
@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")


const pts_get = 1
const atk_warnsec = 2
const atk_atksec = 1
var atk_interval = 5
const atk_interval_end = 1

var isAttacking = false
var isWarning = false
var pos : Vector2
var laser_rotate : float
var player_pos : Vector2



func _ready():
	#find location
	player_pos = player.global_position
	pos = global_position
	
	#start spawn
	$AnimationPlayer.play("medjed_spawn")
	$Laser.visible = false
	$Lasersight.visible = false
	$warning.visible = false
	#1st Atk
	await get_tree().create_timer(atk_interval).timeout
	medjed_atk()



func _physics_process(_delta):
	var laser_slope: float
	player_pos = player.global_position
	
	#laser rotation calculation
	if isWarning == false:
		laser_slope = (pos.y - player_pos.y)/(player_pos.x - pos.x)
		laser_rotate = rad_to_deg(atan(laser_slope))
		if pos.x > player_pos.x:
			laser_rotate +=180
		if pos.y < player_pos.y and pos.x < player_pos.x:
			laser_rotate +=360
		$Lasersight.rotation_degrees = -laser_rotate
	
	#when not atk: medjed turn left/right toward player, lasersight rotate toward player
	if isWarning == false:
		if player_pos.x > pos.x:
			$AnimatedSprite2D.scale.x = -1
		if player_pos.x < pos.x:
			$AnimatedSprite2D.scale.x = 1


#medjed laser warning and attack
func medjed_atk():
	$"sfx_medjed_warning".play()
	$warning.play("warning")
	$warning.visible = true
	$Lasersight.visible = true
	
	#warn/wait before attack
	isAttacking = true
	if isAttacking == true:
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


#when finish attacking
func _on_animation_player_animation_finished(anim_name: StringName):
	isAttacking = false
	isWarning = false
	if anim_name == 'laser_shoot':
		await get_tree().create_timer(atk_interval).timeout
		medjed_atk()
		#medjed will attack faster every time
		if atk_interval > atk_interval_end:
			atk_interval -= 0.5


#medjed dead from player attack
func medjed_dead():
	GameController.points_get(pts_get)
	$AnimationPlayer.play("medjed_dead")
	$sfx_medjed_dead.play()
	$warning.visible = false
	await get_tree().create_timer(2).timeout
	self.queue_free()

#for player hitbox
func _on_hurtbox_area_entered(area: Area2D) -> void:
	#print(area)
	pass

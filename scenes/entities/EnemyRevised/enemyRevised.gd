extends CharacterBody2D
class_name EnemyRevised

signal enemy_damaged( hurt_box : HurtBox )


@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_box : HitBox = $HitBox
@onready var AtkBall : AnimatedSprite2D = $HitBox/AtkBall

@onready var state_machine : EnemyStateMachine = $StateMachine

@onready var player: Player

@export var hp : int = 24.0
@export var damage: int = 6
@export var idle_time : float = 3.5
@export var regular_speed : float = 70.0
@export var chase_speed : float = 100

@onready var isWander : bool = true
@onready var isChasing : bool = false
@onready var isAttacking : bool = false
@export var invulnerable : bool = false

@export var dist_before_attack : float = 120
@export var dist_before_chase : float = 300


# Called when the node enters the scene tree for the first time
func _ready():
	player = GlobalPlayerManager.player
	state_machine.Initialize( self )
	hit_box.Damaged.connect( _take_damage )
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( delta ):
	pass



func _physics_process( delta ):
	
	# Flipping scale
	if velocity.x > 0:
		animated_sprites.scale.x = -1
	else:
		animated_sprites.scale.x = 1
	
	move_and_slide()



func _take_damage( hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return
	
	hp -= hurt_box.damage
	emit_signal( "damaged" )
	
	if hp > 0:
		enemy_damaged.emit( hurt_box )
	else:
		queue_free()



#func update_hp( delta : int ) -> void:
	#hp = clamp( hp + delta, 0, 24 )
	#pass



#func make_invulnerable( _duration : float = 1.0 ) -> void:
	#invulnerable = true
	#hit_box.monitoring = false
	#
	#await get_tree().create_timer( _duration ).timeout
	#
	#invulnerable = false
	#hit_box.monitoring = true
	#
	#pass

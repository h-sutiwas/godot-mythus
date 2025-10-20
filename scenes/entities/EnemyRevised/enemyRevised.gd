extends CharacterBody2D
class_name EnemyRevised

signal enemy_damaged( hurt_box : HurtBox )

@export var invulnerable : bool = false
@export var hp : int = 24.0 # Will change to const for this type of enemy
@export var damage: int = 6
#@export var position: Vector2 = self.global_position
@onready var isAttacking : bool = false

@export var SPEED : float = 70.0
@export var dist_before_attack : float = 18
@export var dist_before_chase : float = 35

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : EnemyStateMachine = $StateMachine

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group( "Player" )

@onready var AtkBall : AnimatedSprite2D = $HitBox/AtkBall
@onready var hit_box : HitBox = $HitBox

var gp : Player

# Called when the node enters the scene tree for the first time
func _ready():
	gp = GlobalPlayerManager.player
	hit_box.Damaged.connect( _take_damage )
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( delta ):
	pass



func _physics_process( delta ):
	move_and_slide()
	
	if velocity.length() > 0:
		animated_sprites.play( "walk" )
	
	if velocity.x > 0:
		animated_sprites.flip_h = true
	else:
		animated_sprites.flip_h = false



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

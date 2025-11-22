extends CharacterBody2D
class_name EnemyRevised

signal direction_changed( new_direction : Vector2 )
signal enemy_damaged( _hurt_box : HurtBox )
signal enemy_destroyed( _hurt_box : HurtBox )

const DIR_4 = [ Vector2.DOWN, Vector2.LEFT, Vector2.UP, Vector2.RIGHT ]

var cardinal_direction : Vector2 = Vector2.LEFT
var direction : Vector2 = Vector2.ZERO

@onready var animated_sprites : AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_box : HitBox = $HitBox
@onready var hurt_box : HurtBox = $HurtBox
@onready var AtkBall : AnimatedSprite2D = $HitBox/AtkBall

@onready var state_machine : EnemyStateMachine = $StateMachine

@onready var player: Player

@export var hp : int = 24.0
@export var damage: int = 6
@export var idle_time : float = 3.5
@export var wander_speed : float = 30.0
@export var chase_speed : float = 30.0

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
	hurt_box.received_damage.connect( _take_damage )
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( delta ):	
	pass



func _physics_process( delta ):
	
	## NOTICE: WILL BE REFACTORING INTO A FUNCTION LATER
	if animated_sprites.scale.x == -1:
		hit_box.position.x = 66
	elif animated_sprites.scale.x == 1:
		hit_box.position.x = -66
	else:
		pass
	
	move_and_slide()



func set_direction( _new_direction : Vector2 ) -> bool:
	direction = _new_direction
	
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int( round(
		( direction + cardinal_direction * 0.1 ).angle()
		/ TAU * DIR_4.size()
	) )
	
	var new_dir = DIR_4[ direction_id ]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	direction_changed.emit( new_dir )
	
	if cardinal_direction == Vector2.RIGHT:
		animated_sprites.scale.x = -1
	else:
		animated_sprites.scale.x = 1
	
	direction_changed.emit( direction )
	return true



func _take_damage( _hit_box : HitBox ) -> void:
	
	#print( "Enemy taking damage" )
	if invulnerable == true:
		#print( "Enemy INVULNERABLE!" )
		return
	
	#print( "Current HP:", hp, " minus ", _hit_box.damage )
	hp -= _hit_box.damage
	#print( "Current HP:", hp )
	#print( "Emitting 'enemy_damaged' signal." )
	
	if hp > 0:
		enemy_damaged.emit( hurt_box )
	else:
		enemy_destroyed.emit( hurt_box )



#func update_hp( delta : int ) -> void:
	#hp = clamp( hp + delta, 0, 24 )
	#pass



func make_invulnerable( _duration : float = 1.0 ) -> void:
	invulnerable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer( _duration ).timeout
	
	invulnerable = false
	hit_box.monitoring = true
	
	pass


#func _on_enemy_damaged(hurt_box: HurtBox) -> void:
	#pass # Replace with function body.
#
#
#func _on_enemy_destroyed(hurt_box: HurtBox) -> void:
	#pass # Replace with function body.
#
#
#func _on_hit_box_damaged(hurt_box: HurtBox) -> void:
	#pass # Replace with function body.

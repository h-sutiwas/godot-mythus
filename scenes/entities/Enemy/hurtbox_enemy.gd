class_name hurtbox_enemy
extends Area2D


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	collision_layer = 0
	collision_mask = 2

#func _ready() -> void:
#	connect("area_entered", self, "_on_area_entered")
	
func _on_area_entered(hitbox: hitbox_enemy) -> void:
	if hitbox == null:
		return
	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)

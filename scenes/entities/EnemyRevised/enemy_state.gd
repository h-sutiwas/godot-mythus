class_name EnemyState
extends Node

static var enemyRev : EnemyRevised

signal Transitioned



## What happens when the enemy exit this State?
func Enter() -> void:
	pass


## What happens when the enemy exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ):
	return null


## What happens during the _process update in this State?
func Physics( _delta : float ):
	return null

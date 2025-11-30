extends Node

var total_points: int = 0
var total_coins: int = 0
var total_enemy_pts: int = 0
var total_medjed: int = 0


#Level and objectives
var level_now = 'LV1'
var level_list = ['LV1', 'LV2']
var level_objective = {'LV1':[7, 10]} #x = num of coin, y = num of enemy
#Ex. LV1 เก็บเหรียญครบ 7 + ฆ่าศัตรู 10 == ไปด่านต่อไปได้


#points system (from coin and killing enemy)
func points_get(value:int):
	total_points += value
	EventController.emit_signal("points_get", total_points)
	#check if complete objective


#coins counter
func coins_get(value:int):
	total_coins += value
	EventController.emit_signal("coins_get", total_coins)

#Global points get from killing enemy [*Dont forget to add code to every enemy*]
func enemy_killed_pts(value:int):
	total_enemy_pts += 1
	EventController.emit_signal("enemy_killed_pts", total_enemy_pts)


#Global Medjed counter
func medjed_spawn(value:int):
	total_medjed += 1
	EventController.emit_signal("medjed_spawn", total_medjed)
func medjed_killed(value:int):
	total_medjed -= 1
	EventController.emit_signal("medjed_killed", total_medjed)

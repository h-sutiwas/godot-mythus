extends Node

var total_points: int = 0
var total_coins: int = 0
var total_enemy_pts: int = 0
var total_medjed: int = 0
var total_cyclops: int = 0


#Level and objectives
var coin_pass = false
var enemy_pass = false
var level_now = 'LV1'
var level_list = ['LV1', 'LV2']
var level_objective = {'LV1':[2, 2]} #x = num of coin, y = num of enemy
#Ex. LV1 เก็บเหรียญครบ 7 + ฆ่าศัตรู 10 == ไปด่านต่อไปได้


func ready():
	#signal objective for the level ***เดี๋ยวจะแก้ให้ใช้ได้หลาย level ด้วย***
	EventController.emit_signal("objective_LV", level_objective[level_now])
	


#points system (from coin and killing enemy)
func points_get(value:int):
	if coin_pass == true and enemy_pass == true:
		EventController.emit_signal("objective_LV_pass", true)
		#build portalin the middle
		
	total_points += value
	EventController.emit_signal("points_get", total_points)

	#for debug **objective still not showing when start**
	EventController.emit_signal("objective_LV", level_objective[level_now])
	
	

#coins counter
func coins_get(value:int):
	total_coins += value
	EventController.emit_signal("coins_get", total_coins)
	#check if complete objective [array[0] = coin]
	if level_objective[level_now][0] == total_coins:
		EventController.emit_signal("objective_coin_pass", true)
		coin_pass = true



#Global points get from killing enemy [*Dont forget to add code to every enemy*]
func enemy_killed_pts(_value:int):
	total_enemy_pts += 1
	EventController.emit_signal("enemy_killed_pts", total_enemy_pts)
	#check if complete objective [array[1] = enemy]
	if level_objective[level_now][1] == total_enemy_pts:
		EventController.emit_signal("objective_enemy_pass", true)
		enemy_pass = true
	



#Global Medjed counter
func medjed_spawn(_value:int):
	total_medjed += 1
	EventController.emit_signal("medjed_spawn", total_medjed)
func medjed_killed(_value:int):
	total_medjed -= 1
	EventController.emit_signal("medjed_killed", total_medjed)


#Global Medjed counter
func cyclops_spawn(value:int):
	total_cyclops += 1
	EventController.emit_signal("cyclops_spawn", total_medjed)
func cyclops_killed(value:int):
	total_cyclops -= 1
	EventController.emit_signal("cyclops_killed", total_medjed)

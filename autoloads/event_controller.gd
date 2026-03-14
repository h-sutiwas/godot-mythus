extends Node

signal points_get(value: int)
signal coins_get(value: int)
signal medjed_spawn(value: int)
signal medjed_killed(value: int)
signal cyclops_spawn(value: int)
signal cyclops_killed(value: int)
signal enemy_killed_pts(value: int)

signal objective_LV(value: Array)
signal objective_LV_pass(value: bool)
signal objective_coin_pass(value: bool)
signal objective_enemy_pass(value: bool)

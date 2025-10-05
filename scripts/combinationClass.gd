extends Node



## Get combinations out of an array with the number to choose 'k'.
##
## 	This is a function to create a combination out of an array for every integer k.
##
##		-- Function Parameters
##			arr:	Array
##			k:		int
##
## 	Example: 
##
##		arr = ["player_left", "player_right", "player_down", "player_up"]
##		k = 3
##
##		Before Backtrack
##		--- At the current_combination of ["player_left", "player_right"] ---
##
##		The current recursive 'start_index' value = 2 so the loop will start and 
##		current_combination appends "player_down" meaning that the size of current_combination 
##		is 3.
##
##		The recursive change through i + 1 so it's at 3 right now. 
##		current_combination = ["player_left", "player_right", "player_down"] makes 
##		The array 'result' appends this combination and then return out of the minor
##		_generate_combinations_recursive. 
##
##		Backtracking
##
##		The current_combination will pop back the "player_down" and
##		back track to the previous recursive start_index of 2 which will turn into 3 since it's in 
##		a for loop. 
##
##		Now the current_combination will appends "player_up" and go through a similar if-statement
##		which this current_combination, ["player_left", "player_right", "player_up"] would then be 
##		appends by the array 'result'.
##
func get_combination(arr: Array, k: int) -> Array:
	var result = []
	var current_combination = []
	_generate_combinations_recursive(arr, k, 0, current_combination, result)
	return result


# Recursive combination generator
func _generate_combinations_recursive(arr: Array, k: int, start_index: int, current_combination: Array, result: Array):
	if current_combination.size() == k:
		result.append(current_combination.duplicate())
		return
	
	for i in range(start_index, arr.size()):
		current_combination.append(arr[i])
		_generate_combinations_recursive(arr, k, i + 1, current_combination, result)
		current_combination.pop_back()

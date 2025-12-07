extends Control



func ready():
	pass



func process( delta ):
	pass



func _on_start_pressed() -> void:
	#print( "Start Pressed" )
	get_tree().change_scene_to_file( "res://scenes/playground.tscn" )
	pass # Replace with function body.



func _on_options_pressed() -> void:
	print( "Options Pressed" )
	pass # Replace with function body.



func _on_exit_pressed() -> void:
	#print( "Exit Pressed" )
	get_tree().quit()
	pass # Replace with function body.

extends Control
class_name PauseMenu

## Pause menu overlay ---> matches main menu visual style.
## Add as a CanvasLayer child in any gameplay scene.
## Listens for "pause" input action (We use ESC)

@onready var resume_btn : Button = %Resume
@onready var main_menu_btn : Button = %MainMenu
@onready var quit_btn : Button = %Quit
@onready var animation_player : AnimationPlayer = $AnimationPlayer

var is_paused : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	
	resume_btn.pressed.connect( _on_resume_pressed )
	main_menu_btn.pressed.connect( _on_main_menu_pressed )
	quit_btn.pressed.connect( _on_quit_pressed )


func _unhandled_input( event : InputEvent ) -> void:
	if event.is_action_pressed( "pause" ):
		if is_paused:
			unpause()
		else:
			pause()
		get_viewport().set_input_as_handled()


func pause() -> void:
	is_paused = true
	visible = true
	get_tree().paused = true
	#if animation_player:
		#animation_player.play( "fade_in" )
	resume_btn.grab_focus()


func unpause() -> void:
	is_paused = false
	get_tree().paused = false
	#if animation_player:
		#animation_player.play( "fade_out" )
		#await animation_player.animation_finished
	visible = false


func _on_resume_pressed() -> void:
	unpause()


func _on_main_menu_pressed() -> void:
	# Unpause before changing scene so the new scene isn't frozen
	is_paused = false
	get_tree().paused = false
	get_tree().change_scene_to_file( "res://scenes/ui/main_menu.tscn" )


func _on_quit_pressed() -> void:
	get_tree().quit()

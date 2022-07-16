extends Control

onready var globals = get_node("/root/Globals")

export(int) var level = 1

func _next_level():
	print("Running")
	print("res://Level" + String(globals.current_level+1) + ".tscn")
	var change_worked = get_tree().change_scene("res://Level" + String(globals.current_level+1) + ".tscn")
	print(change_worked)
	if change_worked != OK:
		get_tree().change_scene("res://MainMenu.tscn")


func _on_Button_pressed():
	_next_level()

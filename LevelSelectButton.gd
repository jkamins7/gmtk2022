extends Button

export(int) var level_to_select = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Label").text = "Level" + String(level_to_select)
	pass # Replace with function body.


func _on_LevelSelectButton_pressed():
	print("Opening level ", "res://Level" + String(level_to_select) + ".tscn")
	get_tree().change_scene("res://Level" + String(level_to_select) + ".tscn")

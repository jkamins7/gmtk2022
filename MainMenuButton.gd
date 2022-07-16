extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()
	pass # Replace with function body.


func _on_Options_pressed():
	print("HERE")
	get_tree().change_scene("res://MainMenu.tscn")

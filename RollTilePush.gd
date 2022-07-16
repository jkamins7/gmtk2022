extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(int) var permitted_number = 3
var parent_transform
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", self, "_on_Hitbox_area_entered")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Hitbox_area_entered(area):
	get_tree().change_scene("res://LevelEnd.tscn")

extends Node2D

onready var globals = get_node("/root/Globals")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	globals.current_level = level


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

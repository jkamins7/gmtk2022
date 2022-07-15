extends Node
class_name PushEvent

var thing_to_move
func _init(var thing_to_move):
	self.thing_to_move = thing_to_move

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func run():
	print("I moved:")
	print(thing_to_move.my_name)

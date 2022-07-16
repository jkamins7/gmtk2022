extends Node
class_name RollEvent

var thing_to_move
var direction
var valid_number

func _init(var thing_to_move, direction = Vector2.RIGHT, x = 1):
	self.thing_to_move = thing_to_move
	self.direction = direction
	self.valid_number = x

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func run():
	var current_side = thing_to_move.return_upward_side()
	if (current_side == self.valid_number):
		thing_to_move.move(direction)

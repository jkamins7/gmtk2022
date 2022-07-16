extends Node
class_name PushEvent

var thing_to_move
var direction
var valid_number

func _init(var thing_to_move, direction = Vector2.RIGHT, x = 0):
	self.thing_to_move = thing_to_move
	self.direction = direction
	self.valid_number = x
	self.name = 'slide'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func matches(num):
	return self.valid_number == 0 or num == self.valid_number
	
func run():
	var current_side = thing_to_move.return_upward_side()
	if matches(current_side):
		thing_to_move.slide(direction)

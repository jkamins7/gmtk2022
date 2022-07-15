extends Node
class_name PushEvent

var thing_to_move
var direction
var valid_number

func _init(var thing_to_move, direction = "RIGHT", x = 1):
	self.thing_to_move = thing_to_move
	self.direction = direction
	self.valid_number = x

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func run():
	print("I moved:")
	print(thing_to_move.my_name)
	var current_side = thing_to_move.return_upward_side()
	if (current_side == self.valid_number):
		match self.direction:
			"RIGHT":
				thing_to_move.move_right()
			"LEFT":
				thing_to_move.move_left()
			"UP":
				thing_to_move.move_up()
			"DOWN":
				thing_to_move.move_down()

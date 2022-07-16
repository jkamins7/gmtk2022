extends Node
class_name RollEvent

var thing_to_move
var direction
var valid_number

func _init(var thing_to_move, direction = Vector2.RIGHT, x = 0):
	self.thing_to_move = thing_to_move
	self.direction = direction
	self.valid_number = x
	self.name = 'roll'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func matches(num):
	return self.valid_number == 0 or num == self.valid_number

func permitted():
	var current_side = thing_to_move.return_upward_side()
	return (matches(current_side)) && (thing_to_move.can_move(direction))

func run():
	if(permitted()):
		thing_to_move.move(direction)

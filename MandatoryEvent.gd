extends Node
class_name MandatoryEvent

var thing_with_counter
var thing_that_moved
var valid_number

func _init(thing_that_moved, thing_with_counter, valid_number = 0):
	self.thing_that_moved = thing_that_moved
	self.thing_with_counter = thing_with_counter
	self.valid_number = valid_number
	self.name = 'mandatory'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func matches(num):
	return self.valid_number == 0 or num == self.valid_number

func permitted():
	var current_side = self.thing_that_moved.return_upward_side()
	return matches(current_side)

func run():
	print("YES")
	if permitted():
		print("YESYES")
		thing_with_counter.mandatory_events_remaining -= 1
		print(thing_with_counter.mandatory_events_remaining)

extends Node
class_name EndEvent

var thing_that_moved
var thing_with_counter
var valid_number

func _init(var thing_that_moved, var thing_with_counter, permitted_number):
	self.thing_that_moved = thing_that_moved
	self.thing_with_counter = thing_with_counter
	self.valid_number = permitted_number
	self.name = 'end'

func matches(num):
	return self.valid_number == 0 or num == self.valid_number

func permitted():
	var current_side = thing_that_moved.return_upward_side()
	return(matches(current_side) && (thing_with_counter.mandatory_events_remaining <= 0))

func run():
	if (permitted()):
		print(get_tree())
		thing_that_moved.get_tree().change_scene("res://LevelEnd.tscn")

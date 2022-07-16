extends Node2D

var player_node

onready var background = $background
onready var rs = $RIGHT_sprite
onready var ls = $LEFT_sprite
onready var us = $UP_sprite
onready var ds = $DOWN_sprite

var reverse_direction = 1

func _ready():
	self.player_node = get_owner().find_node("Player")
	player_node.connect("change_face", self, "_on_change_face")
	player_node.connect("select_pressed", self, "_on_select_pressed")
	_on_change_face(NAN, player_node.return_upward_side())

func update_compass_in_direction(direction, sprite):
	var upward_side_in_direction = player_node.return_upward_side_in_direction(reverse_direction * direction)

	#if upward_side_in_direction[0]:
	sprite.set_frame(upward_side_in_direction[1] - 1)
	if upward_side_in_direction[0]:
		sprite.modulate.a = 1
	else:
		sprite.modulate.a=.5
		#return
	# JK : This probably should be 7, a special NAN pip set, and greyed out
	#sprite.set_frame(6)
	
func _on_select_pressed():
	self.reverse_direction *= -1
	_on_change_face(null,null)
	
func _on_change_face(old_face, new_face):
	if reverse_direction == 1:
		background.set_frame(0)
	else:
		background.set_frame(1)
	update_compass_in_direction(Vector2.RIGHT,rs)
	update_compass_in_direction(Vector2.LEFT,ls)
	update_compass_in_direction(Vector2.UP,us)
	update_compass_in_direction(Vector2.DOWN,ds)

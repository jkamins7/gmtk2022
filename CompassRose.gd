extends Node2D

var player_node

onready var rs = $RIGHT_sprite
onready var ls = $LEFT_sprite
onready var us = $UP_sprite
onready var ds = $DOWN_sprite

func _ready():
	self.player_node = get_owner().find_node("Player")
	player_node.connect("change_face", self, "_on_change_face")
	_on_change_face(NAN, player_node.return_upward_side())

func update_compass_in_direction(direction, sprite):
	var upward_side_in_direction = player_node.return_upward_side_in_direction(direction)
	if upward_side_in_direction[0]:
		sprite.set_frame(upward_side_in_direction[1] - 1)
		return
	# JK : This probably should be 7, a special NAN pip set, and greyed out
	sprite.set_frame(upward_side_in_direction[1] - 1)
	

func _on_change_face(old_face, new_face):
	update_compass_in_direction(Vector2.RIGHT,rs)
	update_compass_in_direction(Vector2.LEFT,ls)
	update_compass_in_direction(Vector2.UP,us)
	update_compass_in_direction(Vector2.DOWN,ds)

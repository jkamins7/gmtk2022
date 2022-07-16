extends Node2D

var player_node

onready var rs = $RIGHT_sprite
func _ready():
	self.player_node = get_owner().find_node("Player")
	player_node.connect("change_face", self, "_on_change_face")
	
func _on_change_face(old_face, new_face):
	rs.set_frame(2-1)
	#player_node.face_on()
	pass

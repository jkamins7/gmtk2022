extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export(int) var permitted_number = 3
export(Vector2) var parent_transform = Vector2.UP
# Called when the node enters the scene tree for the first time.
func _ready():
	var player_node = get_owner().find_node("Player")
	player_node.connect("change_face", self, "_on_change_face")
	find_node("Hitbox").parent_transform = 	Vector2.UP.rotated(self.global_rotation_degrees*2*PI/360)


func _on_change_face(old_face, new_face):
	print("Changed from", old_face, "->", new_face)

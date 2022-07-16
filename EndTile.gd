extends Sprite

func _ready():
	var player_node = get_owner().find_node("Player")
	player_node.connect("change_face", self, "_on_change_face")

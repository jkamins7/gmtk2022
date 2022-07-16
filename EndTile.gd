extends Sprite

export(int) var permitted_number = 0

onready var hitbox = $Hitbox

func _ready():
	var player_node = get_owner().find_node("Player")
	player_node.connect("change_face", self, "_on_change_face")
	hitbox.permitted_number = permitted_number

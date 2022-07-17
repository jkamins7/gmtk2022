extends Sprite

export(int) var permitted_number = 0
export(Color) var color_i_turn_when_active = Color(.3,.9,.4)

onready var hitbox = $Hitbox

func _ready():
	var player_node = get_owner().find_node("Player")
	hitbox.permitted_number = permitted_number
	player_node.connect("all_events_over", self, "_on_all_events_over")
	if player_node.mandatory_events == 0:
		self.set_modulate(color_i_turn_when_active)

func _on_all_events_over():
	print("HERE")
	self.set_modulate(color_i_turn_when_active)
	self.get_parent()

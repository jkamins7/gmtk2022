extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", self, "_on_Hitbox_area_entered")
	var player_node = get_owner().find_node("Player")
	player_node.connect("change_face", self, "_on_change_face")


func _on_change_face(old_face, new_face):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Hitbox_area_entered(area):
	print("Something")
	area.get_parent().add_event(PushEvent.new(area.get_parent(), Vector2.RIGHT, 3))
	pass # Replace with function body.

extends Area2D

export(int) var permitted_number = 0
var parent_transform

func _ready():
	connect("area_entered", self, "_on_Hitbox_area_entered")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Hitbox_area_entered(area):
	area.get_parent().add_event(MandatoryEvent.new(
		area.get_parent(),
		area.get_parent(),
		permitted_number
	))

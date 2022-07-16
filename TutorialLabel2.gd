extends Label


# Declare member variables here. Examples:

func _on_Area2D_area_entered(area):
	self.visible = true


func _on_Area2D_area_exited(area):
	self.visible = false

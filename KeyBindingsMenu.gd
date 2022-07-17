extends VBoxContainer




enum action_tags {ui_right, ui_left, ui_up, ui_down, ui_select, ui_cancel, ui_home}
var button = null
var action_string = ""
var action_display = ""
var action_label = null


var can_change_key = false
var hbox = null

func _ready():
	action_tags.ui_right = "RIGHT"
	action_tags.ui_left = "LEFT"
	action_tags.ui_up = "UP"
	action_tags.ui_down = "DOWN"
	action_tags.ui_select = "SELECT"
	action_tags.ui_cancel = "RESTART"
	action_tags.ui_home = "MAIN MENU"
	_set_keys()  

func set_button_label(button, action_type, action_text, action_label):
		action_label.set_text(action_text)
		button.toggle_mode = true
		button.set_pressed(false)
		if !InputMap.get_action_list(action_type).empty():
			button.set_text(InputMap.get_action_list(action_type)[0].as_text())
		else:
			button.set_text("No Button Set")
		button.connect("pressed", self, "_on_button_pressed", [button, action_type, action_text, action_label ])


func _set_keys():
	for j in action_tags:
		hbox = HBoxContainer.new()
		add_child(hbox)
		var action_label = Label.new()
		hbox.add_child(action_label)
		var button = Button.new()
		hbox.add_child(button)
		
		print(j)
		print(action_tags[j])
		set_button_label(button, j, action_tags[j], action_label)
		# if !InputMap.get_action_list(j).empty():
		# 	get_node("Panel/ScrollContainer/VBoxContainer/HBoxCont_" + str(j) + "/Button").set_text(InputMap.get_action_list(j)[0].as_text())
		# else:
		# 	get_node("Panel/ScrollContainer/VBoxContainer/HBoxCont_" + str(j) + "/Button").set_text("No Button!")


func _mark_button(button, action_string, action_display, action_label):
	can_change_key = true
	self.button = button
	self.action_string = action_string
	self.action_display = action_display
	self.action_label = action_label
	button.set_pressed(false)

func _on_button_pressed(button, action_name, action_display, action_label):
	print("Pressed button " + action_label.get_text() + ": " + button.get_text())
	_mark_button(button, action_name, action_display, action_label)
		
func _input(event):
	if can_change_key && (event is InputEventKey):
		_change_key(event)
		can_change_key = false
		

func _change_key(new_key):
	while !InputMap.get_action_list(action_string).empty():
		InputMap.action_erase_event(action_string, InputMap.get_action_list(action_string)[0])
	
	# for i in action_tags:
	# 	if InputMap.action_has_event(i, new_key):
	# 		InputMap.action_erase_event(i, new_key)
	
	InputMap.action_add_event(action_string, new_key)
	set_button_label(self.button, self.action_string, self.action_display, self.action_label)

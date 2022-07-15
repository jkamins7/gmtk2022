extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVEMENT_SIZE = 32

var current_state = [Vector3(0,0,1), Vector3(1,0,0)]

signal change_face(old_face, new_face)

var state = "WAIT_FOR_INPUT"
onready var player = $AnimationPlayer
onready var ray = $RayCast2D
 
var event_array = []
var my_name: String

# Called when the node enters the scene tree for the first time.
func _ready():
	my_name = "Player"
	pass # Replace with function body.

func return_upward_side():
	if (current_state[0][2] > 0.5):
		return(1)
	if (current_state[0][2] < -0.5):
		return(6)
		
	if (current_state[1][2] > 0.5):
		return(2)
	if (current_state[1][2] < -0.5):
		return(5)
		
	if (current_state[0].cross(current_state[1])[2] > 0.5):
		return(3)
	if (current_state[0].cross(current_state[1])[2] < -0.5):
		return(4)

func can_move(direction):
	ray.cast_to = direction * MOVEMENT_SIZE
	ray.force_raycast_update()
	return !ray.is_colliding()

func rotate(direction):
	if !can_move(direction):
		return false
	var rotation_axis = Vector3.ZERO
	match direction:
		Vector2.RIGHT:
			rotation_axis = Vector3(0,1,0)
		Vector2.LEFT:
			rotation_axis = Vector3(0,-1,0)
		Vector2.UP:
			rotation_axis = Vector3(1,0,0)	
		Vector2.DOWN:
			rotation_axis = Vector3(-1,0,0)
	current_state[0] = current_state[0].rotated(rotation_axis,PI/2)
	current_state[1] = current_state[1].rotated(rotation_axis,PI/2)
	return true

func slide(direction):
	position += direction * MOVEMENT_SIZE

func move(var direction):
	var previous_face = return_upward_side()
	if !rotate(direction):
		return false
	emit_signal("change_face", previous_face, return_upward_side())
	slide(direction)
	return true
	
func process_input():
	if Input.is_action_just_pressed("ui_right"):
		move(Vector2.RIGHT)
		print(return_upward_side())
		state = "EVENTS_RUNNING"
		pass
	if Input.is_action_just_pressed("ui_left"):
		move(Vector2.LEFT)
		print(return_upward_side())
		state = "EVENTS_RUNNING"
		pass
	if Input.is_action_just_pressed("ui_up"):
		move(Vector2.UP)
		print(return_upward_side())
		state = "EVENTS_RUNNING"
		pass
	if Input.is_action_just_pressed("ui_down"):
		move(Vector2.DOWN)
		print(return_upward_side())
		state = "EVENTS_RUNNING"
		pass

func add_event(event):
	event_array.push_back(event)

func run_events_until_empty():
	if(event_array.empty()):
		state = "WAIT_FOR_INPUT"
		pass
	
	if(!event_array.empty()):
		var this_event = event_array.pop_front()
		this_event.run()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	match state:
		"WAIT_FOR_INPUT":
			process_input()
		"EVENTS_RUNNING":
			run_events_until_empty()
	player.play(str(return_upward_side()))

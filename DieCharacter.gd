extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVEMENT_SIZE = 32

var current_state = [Vector3(0,0,1), Vector3(1,0,0)]

const tol = .01
signal change_face(old_face, new_face)

var state = "WAIT_FOR_INPUT"
onready var player = $AnimationPlayer
onready var ray = $RayCast2D
 
var event_array = []
var my_name: String

# Called when the node enters the scene tree for the first time.
func _ready():
	my_name = "Player"
	emit_signal("change_face", NAN, return_upward_side())
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

func return_upward_side_in_direction(direction):
	var rotation_success = rotate(direction)
	var rc = [rotation_success, return_upward_side()]
	print(rc)
	if (!rotation_success):
		return rc
	rotate(-direction,false)
	return (rc)

func can_move(direction):
	ray.cast_to = direction * MOVEMENT_SIZE
	ray.force_raycast_update()
	return !ray.is_colliding()

func rotate(direction, check = true, emit = false):
	if emit:
		var previous_face = return_upward_side()
		var rc = rotate(direction,check,false)
		emit_signal("change_face", previous_face, return_upward_side())
		return rc
	print("Rotating")
	if (check && (!can_move(direction))):
		return false
	var rotation_axis = Vector3.ZERO
	if ((direction - Vector2.RIGHT).length() < tol):
		rotation_axis = Vector3(0,1,0)
	if ((direction - Vector2.LEFT).length() < tol):
			rotation_axis = Vector3(0,-1,0)
	if ((direction - Vector2.UP).length() < tol):
			rotation_axis = Vector3(1,0,0)	
	if ((direction - Vector2.DOWN).length() < tol):
			rotation_axis = Vector3(-1,0,0)
	current_state[0] = current_state[0].rotated(rotation_axis,PI/2)
	current_state[1] = current_state[1].rotated(rotation_axis,PI/2)
	return true


func slide(direction):
	print("Sliding")
	position += direction * MOVEMENT_SIZE

func move(var direction, emit = true):
	if emit:
		var previous_face = return_upward_side()
		var rc = move(direction,false)
		emit_signal("change_face", previous_face, return_upward_side())
		return rc
	print("Full Move")
	if !rotate(direction):
		return false
	slide(direction)
	return true
	
func process_input():
	if Input.is_action_just_pressed("ui_right"):
		print("INPUT RIGHT")
		move(Vector2.RIGHT)
		state = "EVENTS_RUNNING"
		pass
	if Input.is_action_just_pressed("ui_left"):
		print("INPUT LEFT")
		move(Vector2.LEFT)
		state = "EVENTS_RUNNING"
		pass
	if Input.is_action_just_pressed("ui_up"):
		print("INPUT UP")
		move(Vector2.UP)
		state = "EVENTS_RUNNING"
		pass
	if Input.is_action_just_pressed("ui_down"):
		print("INPUT DOWN")
		move(Vector2.DOWN)
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

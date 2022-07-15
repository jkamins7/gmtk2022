extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVEMENT_SIZE = 32

var current_state = [Vector3(0,0,1), Vector3(1,0,0)]

var state = "WAIT_FOR_INPUT"
onready var player = $AnimationPlayer
 
var event_array = []
var my_name: String

# Called when the node enters the scene tree for the first time.
func _ready():
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


func move_right():
	current_state[0] = current_state[0].rotated(Vector3(0,1,0), PI/2)
	current_state[1] = current_state[1].rotated(Vector3(0,1,0), PI/2)

	my_name = "Player"
	event_array.push_back(PushEvent.new(self))
	event_array.push_back(PushEvent.new(self))

	position += Vector2.RIGHT*MOVEMENT_SIZE

	# self.position += Vector2(MOVEMENT_SIZE,0)*10
	pass
func move_left():
	current_state[0] = current_state[0].rotated(Vector3(0,-1,0), PI/2)
	current_state[1] = current_state[1].rotated(Vector3(0,-1,0), PI/2)
	position += Vector2.LEFT*MOVEMENT_SIZE

	pass
func move_up():
	current_state[0] = current_state[0].rotated(Vector3(1,0,0), PI/2)
	current_state[1] = current_state[1].rotated(Vector3(1,0,0), PI/2)

	position += Vector2.UP*MOVEMENT_SIZE
	pass
func move_down():
	current_state[0] = current_state[0].rotated(Vector3(-1,0,0), PI/2)
	current_state[1] = current_state[1].rotated(Vector3(-1,0,0), PI/2)

	position += Vector2.DOWN*MOVEMENT_SIZE
	pass

func process_input():
	if Input.is_action_just_pressed("ui_right"):
		move_right()
		print(return_upward_side())
		state = "EVENTS_RUNNING"
		pass
	if Input.is_action_just_pressed("ui_left"):
		move_left()
		print(return_upward_side())
		state = "EVENTS_RUNNING"
		pass
	if Input.is_action_just_pressed("ui_up"):
		move_up()
		print(return_upward_side())
		state = "EVENTS_RUNNING"
		pass
	if Input.is_action_just_pressed("ui_down"):
		move_down()
		print(return_upward_side())
		state = "EVENTS_RUNNING"
		pass
	

func run_events_until_empty():
	if(event_array.empty()):
		state = "WAIT_FOR_INPUT"
		pass
	
	while(!event_array.empty()):
		var this_event = event_array.pop_front()
		this_event.run()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		"WAIT_FOR_INPUT":
			process_input()
		"EVENTS_RUNNING":
			run_events_until_empty()
	player.play(str(return_upward_side()))
#	

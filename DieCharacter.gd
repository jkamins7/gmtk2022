extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVEMENT_SIZE = 32

var current_state = [Vector3(0,0,1), Vector3(1,0,0)]

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
	
	
	move_and_slide_with_snap(Vector2(1,0)*MOVEMENT_SIZE * 100,Vector2(MOVEMENT_SIZE,MOVEMENT_SIZE))
	# self.position += Vector2(MOVEMENT_SIZE,0)*10
	pass
func move_left():
	current_state[0] = current_state[0].rotated(Vector3(0,-1,0), PI/2)
	current_state[1] = current_state[1].rotated(Vector3(0,-1,0), PI/2)
	move_and_slide_with_snap(Vector2(-1,0)*MOVEMENT_SIZE * 100,Vector2(MOVEMENT_SIZE,MOVEMENT_SIZE))
	pass
func move_up():
	current_state[0] = current_state[0].rotated(Vector3(1,0,0), PI/2)
	current_state[1] = current_state[1].rotated(Vector3(1,0,0), PI/2)
	move_and_slide_with_snap(Vector2(0,-1)*MOVEMENT_SIZE * 100,Vector2(MOVEMENT_SIZE,MOVEMENT_SIZE))
	pass
func move_down():
	current_state[0] = current_state[0].rotated(Vector3(-1,0,0), PI/2)
	current_state[1] = current_state[1].rotated(Vector3(-1,0,0), PI/2)
	move_and_slide_with_snap(Vector2(0,1)*MOVEMENT_SIZE * 100,Vector2(MOVEMENT_SIZE,MOVEMENT_SIZE))
	pass

func process_input():
	if Input.is_action_just_pressed("ui_right"):
		move_right()
		print(return_upward_side())
		pass
	if Input.is_action_just_pressed("ui_left"):
		move_left()
		print(return_upward_side())
		pass
	if Input.is_action_just_pressed("ui_up"):
		move_up()
		print(return_upward_side())
		pass
	if Input.is_action_just_pressed("ui_down"):
		move_down()
		print(return_upward_side())
		pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_input()
#	pass

extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVEMENT_SIZE = 32

CurrentState = Transform()

enum {ONE, TWO, THREE, FOUR, FIVE, SIX}
enum {S0,S1,S2,S4}


var current_state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func print_state():
	print()

func move_right():
	current_state = (current_state + 6) % 24
	print(current_state)
	print_state()
	move_and_slide_with_snap(Vector2(1,0)*MOVEMENT_SIZE * 100,Vector2(MOVEMENT_SIZE,MOVEMENT_SIZE))
	# self.position += Vector2(MOVEMENT_SIZE,0)*10
	pass
func move_left():
	move_and_slide_with_snap(Vector2(-1,0)*MOVEMENT_SIZE * 100,Vector2(MOVEMENT_SIZE,MOVEMENT_SIZE))
	pass
func move_up():
	move_and_slide_with_snap(Vector2(0,-1)*MOVEMENT_SIZE * 100,Vector2(MOVEMENT_SIZE,MOVEMENT_SIZE))
	pass
func move_down():
	move_and_slide_with_snap(Vector2(0,1)*MOVEMENT_SIZE * 100,Vector2(MOVEMENT_SIZE,MOVEMENT_SIZE))
	pass

func process_input():
	if Input.is_action_just_pressed("ui_right"):
		move_right()
		pass
	if Input.is_action_just_pressed("ui_left"):
		move_left()
		pass
	if Input.is_action_just_pressed("ui_up"):
		move_up()
		pass
	if Input.is_action_just_pressed("ui_down"):
		move_down()
		pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_input()
#	pass

extends BaseBody
class_name Player

var camera : Camera
var pivot : Spatial

var mouse_sens : float = 3.0
var relative : Vector2

func _ready():
	Game.player = self
	camera = $Head/Camera
	pivot = $Head

func _input(event):
	if event is InputEventMouseMotion \
	and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		relative = event.relative

func _physics_process(delta):
	process_menu()
	process_pivot()
	process_input()
	process_movement(delta)

func process_menu():
	if Input.is_action_just_pressed("primary"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func process_pivot():
	pivot.rotation.x += relative.y * mouse_sens * -0.001
	pivot.rotation.x = clamp(pivot.rotation.x, -1.5, 1.5)
	rotation.y += relative.x * mouse_sens * -0.001
	if abs(rotation.y) >= TAU:
		rotation.y = 0.0
	relative = Vector2.ZERO

func process_input():
	dir += (
		float(Input.is_action_pressed("backward"))
		- float(Input.is_action_pressed("forward"))
		) * global_transform.basis.z
	dir += (
		float(Input.is_action_pressed("right")) 
		- float(Input.is_action_pressed("left"))
		) * global_transform.basis.x
	action_jump = Input.is_action_pressed("jump")
	action_run = Input.is_action_pressed("run")
	action_primary = Input.is_action_pressed("primary")


extends KinematicBody
class_name BaseBody

const GRAVITY : float = -20.0
const WALK_SPEED : float = 4.0
const RUN_SPEED : float = 8.0
const ACCEL : float = 10.0
const DECEL : float = 5.0
const JUMP_FORCE : float = 8.0

var dir : Vector3
var vel : Vector3

var action_jump : bool = false
var action_run : bool = false
var action_primary : bool = false

func process_movement(delta):
	dir = dir.normalized()
	vel.y += delta * GRAVITY
	var hvel = vel
	hvel.y = 0
	var target = dir
	if action_run:
		target *= RUN_SPEED
	else:
		target *= WALK_SPEED
	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DECEL
	hvel = hvel.linear_interpolate(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel, Vector3.UP, true, 1)
	dir = Vector3.ZERO
	
	if action_jump and is_on_floor():
		vel.y = JUMP_FORCE


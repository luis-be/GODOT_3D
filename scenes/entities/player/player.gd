extends CharacterBody3D

#salto
@export var jump_height : float = 2.25
@export var jump_time_to_peak : float = 0.4
@export var jump_time_to_descent : float = 0.3

@export var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@export var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@export var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
#fuente: https://youtu.be/IOe1aGY6hXA


@export var base_speed := 8.0

var movement_input := Vector2.ZERO

@onready var camera = $CameraController/Camera3D

func _physics_process(delta: float) -> void:
	#velocity = Vector3(movement_input.x,0,movement_input.y) * base_speed
	move_logic(delta)
	jump_logic(delta)

	move_and_slide()

func move_logic(delta) -> void:
	movement_input = Input.get_vector("left","right","forward","backward").rotated(-camera.global_rotation.y)
	var vel_2d = Vector2(velocity.x, velocity.z)
	
	if movement_input != Vector2.ZERO:
		vel_2d += movement_input*base_speed*delta
		vel_2d = vel_2d.limit_length(base_speed)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO, base_speed* 4.0 * delta)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
	
func jump_logic(delta) -> void:
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump_velocity
	var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	velocity.y -= gravity * delta

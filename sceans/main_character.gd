extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -700.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
var is_moving = false
var mouse_pos :Vector2


func _physics_process(delta: float) -> void:
	
	if is_moving:
		sprite_2d.animation = "running"
		var direction = global_position.direction_to(mouse_pos)
		velocity = direction * SPEED
		if global_position.distance_to(mouse_pos) < 5:
			velocity = Vector2.ZERO
			sprite_2d.animation="default"
	
	if not is_on_floor():
		sprite_2d.animation="jump"
	elif(velocity.x> 1 or velocity.x< -1):
		sprite_2d.animation="running"
	else:
		sprite_2d.animation="default"
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite_2d.animation="jump"

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 4)

	move_and_slide()
	
	if velocity.x < 0:
		sprite_2d.flip_h = true
	elif velocity.x > 0:
		sprite_2d.flip_h = false
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			mouse_pos = get_local_mouse_position()
			print(mouse_pos)
			is_moving = true
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			mouse_pos = get_local_mouse_position()
			print(mouse_pos)
			is_moving = true
		else:
			is_moving = false

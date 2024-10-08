extends CharacterBody2D
class_name Player


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var jump_max = 2
var jump_count = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	#resetting jump_count
	if is_on_floor() and jump_count != 0:
		jump_count = 0

	# Handle jump.
	if jump_count < jump_max:
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			jump_count +=1

	# Get the input diretion: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")

	#Flip the Sprite
	if direction >0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")


	#apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

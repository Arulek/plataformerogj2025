extends CharacterBody2D


@export var speed: float = 200.0
@export var jump_height: float = 200
@export var gravity: float = 20.0

var base_speed: float = 200.0
var base_jump: float = 200.0
var powerup_timer: Timer

func _ready() -> void:
	base_speed = speed
	base_jump = jump_height
	powerup_timer = Timer.new()
	powerup_timer.one_shot = true
	add_child(powerup_timer)
	powerup_timer.connect("timeout", Callable(self, "reset_powerup"))
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	movement(_delta)
	pass



func movement(_delta) -> void:
	if Input.is_action_pressed("MoveLeft"):
		velocity.x = -speed
	elif Input.is_action_pressed("MoveRight"):
		velocity.x = speed
	else:
		velocity.x = 0
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * _delta
	else:
		velocity.y = 0  # Reset vertical velocity when on the floor
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		var jump_velocity = sqrt(2 * jump_height * gravity)  # Calculate jump velocity
		print("Jumping height: ", jump_height, " with velocity: ", speed)
		velocity.y = -jump_velocity

	move_and_slide()  # Move the character with sliding behavior
	
func apply_powerup(speed_boost: float, jump_boost: float, duration: float):
	speed += speed_boost
	jump_height += jump_boost
	powerup_timer.start(duration)
	
func reset_powerup():
	speed = base_speed
	jump_height = base_jump

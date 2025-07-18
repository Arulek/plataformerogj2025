extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_height: float = 200
@export var gravity: float = 20.0
var moveleft: bool =  true

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	movement(_delta)
	pass



func movement(_delta) -> void:
	if is_on_wall():
		moveleft=not moveleft
	if moveleft:
		velocity.x = -speed
	else:
		velocity.x = speed


	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * _delta
	else:
		velocity.y = 0  # Reset vertical velocity when on the floor
	move_and_slide()  # Move the character with sliding behavior

func _on_area_2d_body_entered(body: Node2D) -> void:
	call_deferred("destruir")
	pass # Replace with function body.
func destruir():
	queue_free()

extends CharacterBody2D

@export var powerup_scene: PackedScene
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
		$AnimatedSprite2D.flip_h
		$AnimatedSprite2D.play("caminar")
	else:
		velocity.x = speed
		$AnimatedSprite2D.play("caminar")


	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * _delta
	else:
		velocity.y = 0  # Reset vertical velocity when on the floor
	move_and_slide()  # Move the character with sliding behavior

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		call_deferred("destruir")
	pass # Replace with function body.

func destruir():
	if powerup_scene:
		var powerup = powerup_scene.instantiate()
		get_parent().add_child(powerup)
		powerup.global_position = global_position
	queue_free()

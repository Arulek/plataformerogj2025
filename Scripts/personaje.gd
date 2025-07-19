extends CharacterBody2D
@export var speed: float = 200.0
@export var jump_height: float = 200
@export var gravity: float = 20.0
var vida: int = 6
var atacar: bool = false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	movement(_delta)
	pass



func movement(_delta) -> void:
	if not atacar:
		if Input.is_action_pressed("MoveLeft"):
			velocity.x = -speed
			$AnimatedSprite2D.flip_h
			$AnimatedSprite2D.play("caminar")
		elif Input.is_action_pressed("MoveRight"):
			velocity.x = speed
		else:
			velocity.x = 0
			$AnimatedSprite2D.play("quieto")
		if Input.is_action_just_pressed("atacar"):
			atacar= true
	else: 
		#animacion de atacar
		$AnimatedSprite2D.play("atacar")
		await ($AnimatedSprite2D.animation_finished)
		atacar = false



	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * _delta
	else:
		velocity.y = 0  # Reset vertical velocity when on the floor
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		var jump_velocity = sqrt(2 * jump_height * gravity)  # Calculate jump velocity
		print("Jumping with velocity: ", jump_velocity)
		velocity.y = -jump_velocity

	move_and_slide()  # Move the character with sliding behavior


#func _on_area_2d_body_entered(body: Node2D) -> void:
#		call_deferred("destruir")
func destruir():
	queue_free()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_in_group("enemigo"):
		calcularVida(false)
func calcularVida(danio:bool):
	if (danio and vida<5)  :
		vida+=1
	if not danio:
		if vida>1:
			vida-=1
		else: call_deferred("destruir")

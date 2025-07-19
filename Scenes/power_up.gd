extends Area2D

@export var speed_bonus: float = 0.0
@export var jump_bonus: float = 0.0
@export var duration: float = 5.0  # duración del efecto

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("apply_powerup"):
		body.apply_powerup(speed_bonus, jump_bonus, duration)
	queue_free()

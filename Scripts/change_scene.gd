extends Area2D


@export var next_scene : PackedScene


func _ready() -> void:
	if next_scene:
		body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if next_scene:
			get_tree().change_scene_to_packed(next_scene)

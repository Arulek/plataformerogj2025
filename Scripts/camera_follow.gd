extends Camera2D


@export var target: Node2D
@export var smoothing: float = 0.1

func _process(_delta: float) -> void:
    if target:
        var target_position = target.global_position
        var new_position = Vector2(
            lerp(global_position.x, target_position.x, smoothing),
            lerp(global_position.y, target_position.y, smoothing)
        )
        # global_position = target_position
        global_position = new_position
    else:
        print("No target set for camera follow.")
    pass
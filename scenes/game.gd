extends Node2D



var max_points = 50.0

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	interactive_camera(delta)

func interactive_camera(delta: float) -> void:
	return
	$Camera2D.global_position = $Player.global_position + Vector2(0, -250)
	var drag_horizontal_offset = (get_global_mouse_position().x - 1920) / (1920/1.5)
	var drag_vertical_offset = (get_global_mouse_position().y - 1080) / (1080/1.5)
#	var offset_v = (Vector2(1920/2, 1080/2) - get_global_mouse_position()).normalized()
	$Camera2D.drag_horizontal_offset = drag_horizontal_offset
	$Camera2D.drag_vertical_offset = drag_vertical_offset

		

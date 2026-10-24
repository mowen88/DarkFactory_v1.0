extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_limits(current_room:Node2D) -> void:
	
	# Get the new rooms limit rect
	var limits = current_room.get_node_or_null("CameraLimits")
	
	# Assign the new room's limit positions
	limit_left = int(limits.global_position.x)
	limit_top = int(limits.global_position.y)
	limit_right = int(limits.global_position.x + limits.size.x)
	limit_bottom = int(limits.global_position.y + limits.size.y)

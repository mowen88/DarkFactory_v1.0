extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
var input_lock: bool = false

func _ready() -> void:
	visible = false

# Transition func with default parameters that can be overridden
func run(on_complete: Callable, in_duration=0.2, out_duration=0.2) -> void:
	if input_lock:
		return
		
	color_rect.modulate.a = 0.0
	input_lock = true
	visible = true
	
	# Fade in to black (alpha 0.0 -> 1.0)
	var tween_in: Tween = create_tween()
	tween_in.tween_property(color_rect, "modulate:a", 1.0, in_duration)
	await tween_in.finished
	
	# Midpoint callback
	if on_complete.is_valid():
		await on_complete.call()
	
	# Fade out from black (alpha 1.0 -> 0.0)
	var tween_out: Tween = create_tween()
	tween_out.tween_property(color_rect, "modulate:a", 0.0, out_duration)
	await tween_out.finished

	# Unlock input and hide node to finish
	input_lock = false
	visible = false

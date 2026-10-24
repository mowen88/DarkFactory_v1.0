extends Node2D

@export var duration: float = 1.0
@export var new_scene: PackedScene

func _ready() -> void:
	await get_tree().create_timer(duration).timeout
	Transition.run(_change_scene)

func _change_scene() -> void:
	get_tree().change_scene_to_packed(new_scene)
	

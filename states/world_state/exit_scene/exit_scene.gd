extends Area2D

@export var spawn_id: String
@export_file("*.tscn") var room_name: String

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		SignalBus.room_change_requested.emit(room_name, spawn_id)

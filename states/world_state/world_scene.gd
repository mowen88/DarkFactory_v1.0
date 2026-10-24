extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var camera: Camera2D = $Camera2D
@onready var room_container: Node2D = $RoomContainer
var current_room_node: Node = null

func _ready() -> void:
	# Logic to find start room with default
	SignalBus.room_change_requested.connect(_on_room_change_requested)
	_load_room("res://states/world_state/rooms/a_01.tscn", "0")

func _on_room_change_requested(room_name: String, spawn_id: String):

	Transition.run(func():_load_room(room_name, spawn_id))
	
func _load_room(room_name:String, spawn_id: String) -> void:
	# Clear out the old room if one exists
	if current_room_node:
		current_room_node.queue_free()
	
	# Load, instantiate, and add the new room
	var room_scene = load(room_name) as PackedScene
	current_room_node = room_scene.instantiate()
	room_container.add_child(current_room_node)
	camera.set_limits(current_room_node)
	
	var spawn_point = current_room_node.get_node_or_null("SpawnPoints/" + spawn_id)
	player.global_position = spawn_point.global_position
	
func _process(_delta: float) -> void:
	camera.global_position = player.animated_sprite.global_position

extends AudioStreamPlayer2D

@export var camera_path: NodePath
var camera



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_node(camera_path)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	f camera:
		global_position = camera.global_position

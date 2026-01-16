extends Sprite2D

@export var fallSpeed: float = 1.5

var init_y_pos = -100
var has_passed: bool = false
var pass_limits = 100

func _ready() -> void:
	pass
func _init():
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position += Vector2(0, fallSpeed)
	
	#Con esto determino cuanto se demora en llegar al punto exacto, (1.75)
	if global_position.y > pass_limits and not $Timer.is_stopped():
		#print($Timer.wait_time - $Timer.time_left)
		$Timer.stop()
		has_passed = true


func Setup(pos_x: float, target_frame: int):
	global_position = Vector2(pos_x, init_y_pos)
	frame = target_frame
	set_process(true)


func _on_destroy_timer_timeout() -> void:
	queue_free()

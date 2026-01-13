extends Sprite2D

@onready var falling_key = preload("res://scenes/Rythm/falling_key.tscn")
@export var key_name :String = ""

var falling_key_queue = []


var perfectPressLimits: float = 30
var greatPressLimits: float = 50
var goodPressLimits: float = 60
var okPressLimits: float = 30
#lo demas sera un miss

var perfectPressScore: float = 250
var greatPressScore: float = 100
var goodPressScore: float = 50
var okPressScore: float = 20

func _process(_delta):
	
	if falling_key_queue.size() > 0:
		if falling_key_queue.front().has_passed:
			falling_key_queue.pop_front()
			
			
	if Input.is_action_just_pressed(key_name):
		var keyToPop = falling_key_queue.pop_front()
		
		var distanceFromPass = abs(keyToPop.pass_limits - keyToPop.global_position.y)
		
		if distanceFromPass < perfectPressLimits:
				Signals.incrementScore.emit(perfectPressScore)
		elif distanceFromPass < greatPressLimits:
				Signals.incrementScore.emit(greatPressScore)
		elif distanceFromPass < goodPressLimits:
				Signals.incrementScore.emit(goodPressScore)
		elif distanceFromPass < okPressLimits:
				Signals.incrementScore.emit(okPressScore)
				
		else:
			#miss
			pass
		keyToPop.queue_free()





func CreateFallingKey():
	var fk_inst = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", fk_inst)
	fk_inst.Setup(position.x, frame + 4)
	
	falling_key_queue.push_back(fk_inst)


func _on_random_spawn_timer_timeout() -> void:
		CreateFallingKey()
		$RandomSpawnTimer.wait_time = randf_range(0.4, 3)
		$RandomSpawnTimer.start()

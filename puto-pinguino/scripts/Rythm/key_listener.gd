extends Sprite2D

@onready var falling_key = preload("res://scenes/Rythm/falling_key.tscn")
@export var key_name :String = ""
@onready var score_text = preload("res://scenes/Rythm/score_press_text.tscn")

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
			var st_inst = score_text.instantiate()
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.setTextInfo("MISS")
			st_inst.global_position = global_position - Vector2(50,50)
			
			
		if Input.is_action_just_pressed(key_name):
			var keyToPop = falling_key_queue.pop_front()
			
			var distanceFromPass = abs(keyToPop.pass_limits - keyToPop.global_position.y)
			
			var setScoreText: String = ""
			if distanceFromPass < perfectPressLimits:
					Signals.incrementScore.emit(perfectPressScore)
					setScoreText = "PERFECT"
			elif distanceFromPass < greatPressLimits:
					Signals.incrementScore.emit(greatPressScore)
					setScoreText = "GREAT"
			elif distanceFromPass < goodPressLimits:
					Signals.incrementScore.emit(goodPressScore)
					setScoreText = "GOOD"
			elif distanceFromPass < okPressLimits:
					Signals.incrementScore.emit(okPressScore)
					setScoreText = "OK"
					
			else:
				setScoreText = "MISS"
				
			keyToPop.queue_free()
			var st_inst = score_text.instantiate()
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.setTextInfo(setScoreText)
			st_inst.global_position = global_position - Vector2(50,50)

			
		





func CreateFallingKey():
	var fk_inst = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", fk_inst)
	fk_inst.Setup(position.x, frame + 4)
	
	falling_key_queue.push_back(fk_inst)


func _on_random_spawn_timer_timeout() -> void:
		CreateFallingKey()
		$RandomSpawnTimer.wait_time = randf_range(0.4, 3)
		$RandomSpawnTimer.start()

extends Sprite2D

@onready var falling_key = preload("res://scenes/Rythm/falling_key.tscn")
@export var key_name :String = ""
@onready var score_text = preload("res://scenes/Rythm/score_press_text.tscn")

var falling_key_queue = []


var perfectPressLimits: float = 40
var greatPressLimits: float = 28
var goodPressLimits: float = 18
var okPressLimits: float = 10
#lo demas sera un miss

var perfectPressScore: float = 150
var greatPressScore: float = 100
var goodPressScore: float = 50
var okPressScore: float = 20

func _ready() -> void:
	Signals.createFallingKey.connect(createFallingKey)

func _process(_delta):
	
	if Input.is_action_just_pressed(key_name):
		Signals.keyListenerPress.emit(key_name, frame)
	
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
			if distanceFromPass < perfectPressLimits and distanceFromPass > greatPressLimits:
					print("PERFECT = " + str(distanceFromPass))
					Signals.incrementScore.emit(perfectPressScore)
					setScoreText = "PERFECT"
			elif distanceFromPass < greatPressLimits and distanceFromPass > goodPressLimits:
					print("GREAT = " + str(distanceFromPass))
					Signals.incrementScore.emit(greatPressScore)
					setScoreText = "GREAT"
			elif distanceFromPass < goodPressLimits and distanceFromPass > okPressLimits:
					print("GOOD = " + str(distanceFromPass))
					Signals.incrementScore.emit(goodPressScore)
					setScoreText = "GOOD"
			elif distanceFromPass < okPressLimits:
					print("OK = " + str(distanceFromPass))
					Signals.incrementScore.emit(okPressScore)
					setScoreText = "OK"
					
			else:
				setScoreText = "MISS"
				print("MISS = " + str(distanceFromPass))
				
			keyToPop.queue_free()
			var st_inst = score_text.instantiate()
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.setTextInfo(setScoreText)
			st_inst.global_position = global_position - Vector2(50,50)

			
		





func createFallingKey(buttonName: String):
	if buttonName == key_name:
		var fk_inst = falling_key.instantiate()
		get_tree().get_root().call_deferred("add_child", fk_inst)
		fk_inst.Setup(position.x, frame + 4)
		
		falling_key_queue.push_back(fk_inst)


func _on_random_spawn_timer_timeout() -> void:
		#createFallingKey()
		$RandomSpawnTimer.wait_time = randf_range(0.4, 3)
		$RandomSpawnTimer.start()
		

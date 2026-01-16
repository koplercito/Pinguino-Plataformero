extends Control

@export var score: int = 0

var maxValueProgress: int 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.incrementScore.connect(incrementScore)
	maxValueProgress = %TextureProgressBar.max_value
	%ProgressBar.max_value = 38*150-1500
	
	winOrLose()

func incrementScore(incr: int):
	score += incr
	
	%TextureProgressBar.value = score
	%ProgressBar.value = score

func winOrLose():
	await get_tree().create_timer(23).timeout 
	if score < maxValueProgress :
		print("perdiste " + str(score))
	else:
		print("ganaste " + str(score))

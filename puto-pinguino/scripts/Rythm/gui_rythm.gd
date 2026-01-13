extends Control

@export var score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.incrementScore.connect(incrementScore)
	%TextureProgressBar.max_value = 10000
	%ProgressBar.max_value = 10000

func incrementScore(incr: int):
	score += incr
	
	%TextureProgressBar.value = score
	%ProgressBar.value = score

extends Node2D

const inEditMode: bool = false
var currentLevelName: String = "Ritmo1"
var fkFallTime: float = 1.5
var fkOutputArr = [[],[],[],[]]
var levelInfo = {
	"Ritmo1" = {
		"fk_times": "[[0.48530614376068, 4.20920658111572, 7.92149639129639, 11.5583219528198, 12.8789567947388, 15.6218147277832, 17.0295238494873], [0.9235827922821, 4.61265325546265, 4.86807250976563, 8.3365535736084, 8.81546497344971, 9.03024959564209, 9.28566932678223, 11.8979139328003, 12.2723360061646, 15.9294776916504], [1.39088439941406, 5.11478471755981, 8.54843521118164, 8.95478439331055, 9.21020412445068, 11.7934236526489, 12.0256233215332, 12.6235370635986, 15.8336963653564, 16.0165538787842, 16.518684387207, 16.8379592895508], [1.81755113601685, 5.52113389968872, 5.76494312286377, 9.47723388671875, 12.475510597229, 16.3358268737793, 16.6783218383789]]",
		"music": load("res://assets/music/Musica juego ritmo.wav")
	}
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	await get_tree().create_timer(1.0).timeout
	$MusicPlayer.stream = levelInfo.get(currentLevelName).get("music")

	$MusicPlayer.play()
	
	if inEditMode:
		Signals.keyListenerPress.connect(keyListenerPress)
		
	else:
		var fk_times = levelInfo.get(currentLevelName).get("fk_times")
		var fk_times_arr = str_to_var(fk_times)
		#print(fk_times_arr[0])
		
		
		var counter: int = 0
		for key in fk_times_arr:
			var buttonName: String = ""
			match counter:
				0:
					buttonName = "tecla_F"
				1:
					buttonName = "tecla_G"
				2:
					buttonName = "tecla_J"
				3:
					buttonName = "tecla_K"
			
			
			for delay in key:
				spawnFallingKey(buttonName, delay)
				
			counter += 1
		
		
func keyListenerPress(buttonName: String, arrayNum: int):
	#print(str(arrayNum)+ "" + str($MusicPlayer.get_playback_position()))

	fkOutputArr[arrayNum].append($MusicPlayer.get_playback_position() - fkFallTime)
	
func spawnFallingKey(buttonName: String, delay: float):
	await get_tree().create_timer(delay).timeout
	Signals.createFallingKey.emit(buttonName)


func _on_music_player_finished() -> void:
	print(fkOutputArr)

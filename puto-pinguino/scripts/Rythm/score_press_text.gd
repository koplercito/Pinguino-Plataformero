extends Control
#colores

#perfect 66b4f1
#great 66b4a7
#good 66b481
#ok 62af00
#miss ff0000

func setTextInfo(text: String):
	$TextLabel.text = "[center]" + text
	
	match text:
		"PERFECT":
			$TextLabel.set("theme_override_colors/default_color", Color("66b4f1"))
		"GREAT":
			$TextLabel.set("theme_override_colors/default_color", Color("66b4a7"))
		"GOOD":
			$TextLabel.set("theme_override_colors/default_color", Color("66b481"))
		"OK":
			$TextLabel.set("theme_override_colors/default_color", Color("62af00"))
		_:
			$TextLabel.set("theme_override_colors/default_color", Color("ff0000"))

extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/TextureRect.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_QuitButton_released():
	get_tree().quit()


func _on_RestartButton_released():
	$CanvasLayer/TextureRect.hide()
	get_tree().reload_current_scene()


func _on_Main_gameover(seconds, mistakes):
	$CanvasLayer/TextureRect/MistakesLabel.text = "Mistakes: " + str(mistakes)
	$CanvasLayer/TextureRect/TimeLabel.text = "Time: " + str(seconds)
	
	# Max score is 100
	# Deduct 3 points for a mistake, so if all 12 tiles are mistakes, score becomes 64
	# Deduct 1 point for every second elapsed
	var score = 100 - (mistakes * 4) - seconds
	if score < 0:
		score = 0
	$CanvasLayer/TextureRect/ScoreLabel.text = "Score: " + str(score)
	$CanvasLayer/TextureRect.show()
	pass # Replace with function body.

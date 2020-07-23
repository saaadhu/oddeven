extends Node2D
signal gameover(seconds, mistakes)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var odd = false
var numbers = []
const ROWS = 3
const COLS = 4
const NUM = ROWS * COLS
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	odd = randi() % 2 == 0
	if odd:
		$CanvasLayer/TitleLabel.text = "Choose odd numbers"
	else:
		$CanvasLayer/TitleLabel.text = "Choose even numbers"
	
	numbers.clear()	
	for i in range(NUM):
		numbers.append(int(rand_range(1,  100)))
		
	for i in range (ROWS):
			for j in range (COLS):
				var button = get_node("CanvasLayer/Button" + str(i) + str(j))
				var number = numbers[i * COLS + j]
				var n = str(number)
				if number < 10:
					n = "0" + n
				button.get_node("Label").text =  str(n)
	$GameTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func is_correct_choice (row, col):
	var index = (row * ROWS) + col
	var number_is_even = (numbers[index] % 2 == 0)
	return (odd and !number_is_even) or (!odd and number_is_even)
	
func assess(row, col):
	if stopassessing:
		return
	var button = get_node("CanvasLayer/Button" + str(row) + str(col))
	if !is_correct_choice(row, col):
		button.set_texture_pressed(load("res://fluidRed.png"))
		mistakes = mistakes + 1
	else:
		button.hide()

func _on_Button00_pressed():
	assess(0, 0)
		
func _on_Button01_pressed():
	assess(0, 1)
	
func _on_Button02_pressed():
	assess(0, 2)
	
func _on_Button03_pressed():
	assess(0, 3)

func _on_Button10_pressed():
	assess(1, 0)

func _on_Button11_pressed():
	assess(1,1)

func _on_Button12_pressed():
	assess(1,2)

func _on_Button13_pressed():
	assess(1,3)

func _on_Button20_pressed():
	assess(2,0)

func _on_Button21_pressed():
	assess(2,1)

func _on_Button22_pressed():
	assess(2,2)

func _on_Button23_pressed():
	assess(2,3)

var started = false
var mistakes = 0
var stopassessing = false

func _on_ButtonStartDone_released():
	stopassessing = true
	$CanvasLayer/ButtonDone.hide()
	$GameTimer.stop()
	var unselected_mistakes = false
	for i in range (ROWS):
		for j in range (COLS):
			var button = get_node("CanvasLayer/Button" + str(i) + str(j))
			if button.is_visible() && is_correct_choice(i, j):
				mistakes = mistakes + 1
				button.set_texture(load("res://fluidRed.png"))
				unselected_mistakes = true
	if unselected_mistakes:
		yield(get_tree().create_timer(2), "timeout")
	
	emit_signal("gameover", seconds, mistakes)

var seconds = 1
func _on_Timer_timeout():
	seconds = seconds + 1
	var n = str(seconds)
	if seconds < 10:
		n = "0" + n
	$CanvasLayer/TimeLabel.text = str(n)

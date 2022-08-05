extends Node2D

var score = 0 setget set_score
var health = 6 setget set_health
var end = false
var since_last_dice = 0
var level = 1
var dice = preload("res://Dice.tscn")
signal restart
var rng = RandomNumberGenerator.new()


func set_score(sc):
	score = sc
	$CanvasLayer/score.text = str(score)
	if score >= level*20:
		level += 1
		if not $DiceTimer.wait_time <= 5:
			$DiceTimer.wait_time -= 4
		else:
			$DiceTimer.wait_time -= 1

func set_health(hp):
	if hp < health:
		$BackgroundItems/Health_popup.appear()
		$hurt.play()
	elif hp > health:
		if hp <= 6:
			$BackgroundItems/Health_popup2.appear()
	if hp <= 0:
		end = true
		$end/ColorRect/score.text = str(score)
		$end/ColorRect/score3.text = "lvl " + str(level)
	elif not hp > 6:
		health = hp
		$CanvasLayer/health/value.region_rect.position.x = (health-1)*20

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/score2.text = "lvl " + str(level)
	since_last_dice += delta
	if end:
		$end/ColorRect.modulate.a += delta
		$DiceTimer.stop()
		if Input.is_action_just_pressed("ui_select"):
			emit_signal("restart")

func number_of_dice():
	var num = 0
	for child in get_children():
		if child.is_in_group("dice"):
			num += 1
	return num

func _on_Abyss_body_entered(body):
	if body.is_in_group("dice"):
		remove_child(body)
		body.queue_free()
		set_health(health - 1)
		if number_of_dice() <= 0:
			add_new_dice()
			$DiceTimer.start()

func add_new_dice():
	var new_dice = dice.instance()
	rng.randomize()
	new_dice.face = rng.randi_range(1, 6)
	add_child(new_dice)

func _on_DiceTimer_timeout():
	add_new_dice()

func got_in(points):
	print(points)
	set_score(score + points)
	set_health(health + 1)
	$good.play()

func _on_jar_body_entered(body):
	if body.is_in_group("dice"):
		if body.face == 3:
			$BackgroundItems/Jar_popup.text = "+" + str(3*level)
			$BackgroundItems/Jar_popup.appear()
			got_in(3*level)
		remove_child(body)
		body.queue_free()
		if number_of_dice() <= 0:
			add_new_dice()
			$DiceTimer.start()


func _on_Area2D_body_entered(body):
	if body.is_in_group("dice"):
		if body.face == 4:
			$BackgroundItems/Basket_popup.text = "+" + str(4*level)
			$BackgroundItems/Basket_popup.appear()
			got_in(4*level)
		remove_child(body)
		body.queue_free()
		if number_of_dice() <= 0:
			add_new_dice()
			$DiceTimer.start()


func _on_door_body_entered(body):
	if body.is_in_group("dice"):
		if body.face == 2:
			$BackgroundItems/Door_popup.text = "+" + str(2*level)
			$BackgroundItems/Door_popup.appear()
			got_in(2*level)
		remove_child(body)
		body.queue_free()
		if number_of_dice() <= 0:
			add_new_dice()
			$DiceTimer.start()


func _on_tube_body_entered(body):
	if body.is_in_group("dice"):
		if body.face == 5:
			$BackgroundItems/tube_popup2.text = "+" + str(5*level)
			$BackgroundItems/tube_popup2.appear()
			got_in(5*level)
		remove_child(body)
		body.queue_free()
		if number_of_dice() <= 0:
			add_new_dice()
			$DiceTimer.start()


func _on_Toilet_body_entered(body):
	if body.is_in_group("dice"):
		if body.face == 6:
			$BackgroundItems/toilet_popup.text = "+" + str(6*level)
			$BackgroundItems/toilet_popup.appear()
			got_in(6*level)
		remove_child(body)
		body.queue_free()
		if number_of_dice() <= 0:
			add_new_dice()
			$DiceTimer.start()


func _on_BlackHole_body_entered(body):
	if body.is_in_group("dice"):
		if body.face == 1:
			$BackgroundItems/Hole_popup.text = "+" + str(1*level)
			$BackgroundItems/Hole_popup.appear()
			got_in(1*level)
		remove_child(body)
		body.queue_free()
		if number_of_dice() <= 0:
			add_new_dice()
			$DiceTimer.start()

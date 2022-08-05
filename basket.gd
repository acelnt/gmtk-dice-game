extends StaticBody2D

var direction = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if position.x < 50:
		direction = 1
	elif position.x > 150:
		direction = -1
	position.x += delta*60*direction

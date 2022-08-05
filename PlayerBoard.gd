extends KinematicBody2D

var colliding = false
var velocity = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	velocity = mouse_pos - position
	move_and_slide((mouse_pos - position)*60)

func _process(delta):
	$Hand.rotation_degrees += (((velocity.length()) * sign(velocity.x))*10 - $Hand.rotation_degrees)/3

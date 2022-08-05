extends RigidBody2D

var face = 1 setget set_face
var last_collision = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	bounce = 200

func set_face(number):
	if number > 6:
		face = 1
	elif number < 1:
		face = 6
	else:
		face = int(number)
	$DiceFace.region_rect.position.x = 20*(face-1)

func _physics_process(delta):
	last_collision += delta
	if linear_velocity.length() > 1000:
		linear_velocity = linear_velocity.normalized()*1000
	if position - $DiceCollision.shape.extents > Vector2() and position - $DiceCollision.shape.extents < Vector2(300, 200):
		set_collision_layer_bit(0, true)
		set_collision_layer_bit(1, true)

func _on_Dice_body_entered(body):
	if body.is_in_group("incrementor"):
		if last_collision > 0.3:
			set_face(face+1)
			$AudioStreamPlayer.play()
			$CPUParticles2D.emitting = true
		last_collision = 0

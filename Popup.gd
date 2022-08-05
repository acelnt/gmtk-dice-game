extends ColorRect

export var text = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func appear():
	modulate.a = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Popup.text = text
	if modulate.a > 0:
		modulate.a -= delta

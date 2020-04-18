extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var SPEED = 100
var anim

# Called when the node enters the scene tree for the first time.
func _ready():
	anim = $Animations
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("ui_left")):
		anim.play("Walk")
		anim.set_flip_h(false)
		position[0] -= SPEED * delta
		position[1] += (SPEED/2) * delta
	elif(Input.is_action_pressed("ui_right")):
		anim.play("Walk")
		anim.set_flip_h(true)
		position[0] += SPEED * delta
		position[1] += (SPEED/2) * delta
	else:
		anim.play("Idle")
		
		
	pass

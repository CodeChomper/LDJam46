extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED = 120
const UP = Vector2(0,-1)
var anim
var motion = Vector2(0,0)
var fliped = false
var up = false
var interacting = false
# Called when the node enters the scene tree for the first time.
func _ready():
	anim = $Animations
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("ui_left")):
		fliped = true
		up = true
		anim.play("WalkUp")
		motion.x = -SPEED
		motion.y = (-SPEED/2)
	elif(Input.is_action_pressed("ui_right")):
		fliped = true
		up = false
		anim.play("Walk")
		motion.x = SPEED
		motion.y = (SPEED/2)
	elif(Input.is_action_pressed("ui_up")):
		fliped = false
		up = true
		anim.play("WalkUp")
		motion.x = SPEED
		motion.y = (-SPEED/2)
	elif(Input.is_action_pressed("ui_down")):
		fliped = false
		up = false
		anim.play("Walk")
		motion.x = -SPEED
		motion.y = (SPEED/2)
	elif(Input.is_action_pressed("Interact")):
		anim.play("PickUp")
		interacting = true
	else:
		if interacting:
			return
		if(up):
			anim.play("IdleUp")
		else:
			anim.play("Idle")
		motion.x = 0
		motion.y = 0
	motion = move_and_slide(motion,UP)
	anim.set_flip_h(fliped)
		
	pass


func _on_animation_finished():
	if $Animations.animation == "PickUp":
		interacting = false
	pass # Replace with function body.

extends KinematicBody2D


var state = "Idle"
var anim = null
var randy = null
const HOP_CHANCE = 3

var motion = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	randy = RandomNumberGenerator.new()
	randy.randomize()
	anim = $Animations
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var hop = randy.randi_range(0,100)
	if(hop < HOP_CHANCE):
		state = "Hop"
		motion.x = randy.randi_range(-250,250)
		if(motion.x >= 0):
			anim.set_flip_h(true)
		else:
			anim.set_flip_h(false)
		motion.y = randy.randi_range(-250,250)
	anim.play(state)
	motion *= 0.8
	motion = move_and_slide(motion)
	
	


func _on_animation_finished():
	state = "Idle"
	pass # Replace with function body.

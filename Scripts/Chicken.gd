extends KinematicBody2D


var state = "Idle"
var anim = null
var randy = null
const HOP_CHANCE = 3

var motion = Vector2(0,0)
var egg = null


# Called when the node enters the scene tree for the first time.
func _ready():
	egg = preload("res://Scenes/Egg.tscn")
	randy = RandomNumberGenerator.new()
	randy.randomize()
	$EggTimer.wait_time = randy.randi_range(60,120)
	$EggTimer.start()
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


	
func _on_FarmerDetectionArea_area_entered(area):
	if area.name == 'FarmerArea2D':
		var farmer = owner.find_node("Farmer")
		if  farmer.position.x >= position.x:
			anim.set_flip_h(false)
			motion.x = -300
		if farmer.position.x < position.x:
			anim.set_flip_h(true)
			motion.x = 300
		if farmer.position.y >= position.y:
			motion.y = -300
		if farmer.position.y < position.y:
			motion.y = 300
	motion = move_and_slide(motion)
	pass # Replace with function body.


func _on_EggTimer_timeout():
	var e = egg.instance()
	get_parent().add_child(e)
	var pos = anim.global_position
	pos.y -= 50
	e.set_position(pos)
	
	pass # Replace with function body.

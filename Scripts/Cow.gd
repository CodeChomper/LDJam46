extends KinematicBody2D

var anim
var randy = RandomNumberGenerator.new()
var walking = false
var flipped = false
var up = false
var right = false
const SPEED = 60
var motion = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	randy.randomize()
	$WalkTimer.wait_time = randy.randi_range(5,20)
	$WalkTimer.start()
	anim = $Animations
	_on_WalkTimer_timeout()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if walking:
		if up and right:
			anim.play('WalkUp')
			flipped = false
			motion = Vector2(SPEED,-SPEED/2)
		if up and not right:
			anim.play('WalkUp')
			flipped = true
			motion = Vector2(-SPEED,-SPEED/2)
		if not up and right:
			anim.play('WalkDown')
			motion = Vector2(SPEED,SPEED/2)
			flipped = true
		if not up and not right:
			motion = Vector2(-SPEED,SPEED/2)
			flipped = false
			anim.play('WalkDown')
	
	anim.set_flip_h(flipped)
	motion = move_and_slide(motion)
	pass


func _on_animation_finished():
	if anim.animation == "WalkUp":
		motion = Vector2(0,0)
		walking = false
		anim.play('IdleUp')
		pass
	if anim.animation == "WalkDown":
		motion = Vector2(0,0)
		walking = false
		anim.play('IdleDown')
		pass
	pass # Replace with function body.


func _on_WalkTimer_timeout():
	walking = true
	# Pick a direction up or down
	up = randy.randi_range(0,1)
	
	# Pick a direction left or right
	right = randy.randi_range(0,1)
	
	# Set a new time to walk again
	$WalkTimer.wait_time = randy.randi_range(5,20)
	$WalkTimer.start()
	pass # Replace with function body.

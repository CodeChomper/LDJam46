extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED = 240
const UP = Vector2(0,-1)
var anim
var motion = Vector2(0,0)
var fliped = false
var up = false
var interacting = false
var near_bucket = false
var holding_bucket = false
var near_egg = false
var near_truck = false
var egg = null
# Called when the node enters the scene tree for the first time.
func _on_new_order():
	print("Player sees the new order!!!!!!")
	pass
func _ready():
	anim = $Animations
	Globals.connect("new_order_sig", self, "_on_new_order")
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("ui_left")):
		interacting = false
		fliped = true
		up = true
		if holding_bucket:
			anim.play("WalkBucketUp")
		else:
			anim.play("WalkUp")
		motion.x = -SPEED
		motion.y = (-SPEED/2)
	elif(Input.is_action_pressed("ui_right")):
		interacting = false
		fliped = true
		up = false
		if holding_bucket:
			anim.play("WalkBucket")
		else:
			anim.play("Walk")
		motion.x = SPEED
		motion.y = (SPEED/2)
	elif(Input.is_action_pressed("ui_up")):
		interacting = false
		fliped = false
		up = true
		if holding_bucket:
			anim.play("WalkBucketUp")
		else:
			anim.play("WalkUp")
		motion.x = SPEED
		motion.y = (-SPEED/2)
	elif(Input.is_action_pressed("ui_down")):
		interacting = false
		fliped = false
		up = false
		if holding_bucket:
			anim.play("WalkBucket")
		else:
			anim.play("Walk")
		motion.x = -SPEED
		motion.y = (SPEED/2)
	elif(Input.is_action_pressed("Interact")):
		if near_truck:
			Globals.deposit_goods()
			return
		if up:
			anim.play("PickUpUp")
		else:
			anim.play("PickUp")
		if near_bucket:
			get_parent().find_node("Bucket").queue_free()
			holding_bucket = true
		if near_egg and not holding_bucket:
			egg.queue_free()
			Globals.eggs_in_hand += 1
		interacting = true
	else:
		if interacting:
			return
		if(up):
			if(holding_bucket):
				anim.play('IdleBucketUp')
			else:
				anim.play("IdleUp")
		else:
			if(holding_bucket):
				anim.play('IdleBucket')
			else:
				anim.play("Idle")
		motion.x = 0
		motion.y = 0
	motion = move_and_slide(motion,UP)
	anim.set_flip_h(fliped)
		
	pass


func _on_animation_finished():
	if $Animations.animation == "PickUp" or $Animations.animation == "PickUpUp":
		interacting = false
	pass # Replace with function body.


func _on_FarmerArea2D_area_entered(area):
	if area.name == 'BucketArea':
		near_bucket = true
	if area.name == 'EggArea':
		near_egg = true
		egg = area.get_parent()
	if area.name == 'TruckArea':
		near_truck = true


func _on_FarmerArea2D_area_exited(area):
	if area.name == 'BucketArea':
		near_bucket = false
	if area.name == 'EggArea':
		near_egg = false
		egg = false
	if area.name == 'TruckArea':
		near_truck = false

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
var near_cow = false
var near_carrot = false
var egg = null
var carrot = null

var bucket
# Called when the node enters the scene tree for the first time.
func _on_new_order():
	print("Player sees the new order!!!!!!")
	pass
func _ready():
	anim = $Animations
	bucket = get_parent().find_node("Bucket")
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
	elif(Input.is_action_just_pressed("Interact")):
		interacting = true
		if near_truck:
			Globals.deposit_goods()
#		if near_truck and holding_bucket:
#			Globals.deposit_milk()
#		if near_truck and Globals.eggs_in_hand > 0:
#			Globals.deposit_eggs()
		# add carrots here
			return
		if up and not holding_bucket:
			anim.play("PickUpUp")
		if not up and not holding_bucket:
			anim.play("PickUp")
		
		# Pick up code
		var areas = $FarmerArea2D.get_overlapping_areas()
		if(len(areas) > 0):
			for area in areas:
				if area.name == 'EggArea' and Globals.eggs_in_hand < 6:
					area.get_parent().queue_free()
					Globals.eggs_in_hand += 1
					Globals.carrots_in_hand = 0
				if area.name == 'CarrotArea' and Globals.carrots_in_hand < 12:
					var carrot = area.get_parent()
					if carrot.frame == 5:
						carrot.frame = 0
						Globals.carrots_in_hand += 2
						Globals.eggs_in_hand = 0
		# Bucket Code
		if near_bucket:
			Globals.eggs_in_hand = 0
			near_bucket = false
			bucket.visible = false
			holding_bucket = true
		elif holding_bucket and near_cow:
			if up:
				anim.play('MilkUp')
			else:
				anim.play('Milk')
			Globals.milk_in_bucket += 1
			if Globals.milk_in_bucket > 2:
				Globals.milk_in_bucket = 2
			
		elif holding_bucket and not near_cow and not near_truck:
			# Put Bucket Down
			near_bucket = true
			if up:
				anim.play('IdleUp')
			else:
				anim.play('Idle')
			holding_bucket = false
			bucket.visible = true
			var place_position = global_position
			place_position.y += 70
			bucket.global_position = place_position
			pass
		
		
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
	if area.name == 'MilkingArea':
		near_cow = true
	if area.name == 'CarrotArea':
		near_carrot = true
		carrot = area.get_parent()


func _on_FarmerArea2D_area_exited(area):
	if area.name == 'BucketArea':
		near_bucket = false
	if area.name == 'EggArea':
		near_egg = false
		egg = false
	if area.name == 'TruckArea':
		near_truck = false
	if area.name == 'MilkingArea':
		interacting = false
		near_cow = false
	if area.name == 'CarrotArea':
		near_carrot = false

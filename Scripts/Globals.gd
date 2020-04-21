extends Node

var randy
var eggs_in_hand
var eggs_in_truck
var milk_in_bucket
var milk_in_truck
var carrots_in_hand
var carrots_in_truck
var eggs_needed
var milk_needed
var carrots_needed
var order_timer
var level
var people_left = 100
signal new_order_sig
signal fail_order_sig

func _process(delta):
	if(Input.is_action_just_released("NewOrder")):
		eggs_in_truck = 10000000
		milk_in_truck = 1000000
		carrots_in_truck = 1000000
		check_if_order_is_complete()
	if(Input.is_action_just_pressed("FailOrder")):
		_on_order_timer_time_out()

func _ready():
	randy = RandomNumberGenerator.new()
	randy.randomize()
	order_timer = Timer.new()
	add_child(order_timer)
	order_timer.connect("timeout", self, "_on_order_timer_time_out")
	reset()
	new_order()
	

func reset():
	level = 1
	eggs_in_hand = 0
	eggs_in_truck = 0
	carrots_in_hand = 0
	milk_needed = 0
	milk_in_bucket = 0
	milk_in_truck = 0
	eggs_needed = 0
	carrots_in_hand = 0
	carrots_needed = 0
	carrots_in_truck = 0
	people_left = 100


func new_order():
	eggs_needed = randy.randi_range(level, level * 2)
	milk_needed = randy.randi_range(level, level * 2)
	carrots_needed = randy.randi_range(level*4, level*10)
	
	# if level one give them way more time
	if level == 1:
		order_timer.wait_time = 60*5
	else:
		order_timer.wait_time = 15 * (eggs_needed + milk_needed)
	order_timer.start()
	
func deposit_goods():
	milk_in_truck += milk_in_bucket
	milk_in_bucket = 0
	
	eggs_in_truck += eggs_in_hand
	eggs_in_hand = 0
	
	carrots_in_truck += carrots_in_hand
	carrots_in_hand = 0
	check_if_order_is_complete()


func deposit_milk():
	milk_in_truck += milk_in_bucket
	milk_in_bucket = 0
	check_if_order_is_complete()

func deposit_eggs():
	eggs_in_truck += eggs_in_hand
	eggs_in_hand = 0
	check_if_order_is_complete()
	
	

func check_if_order_is_complete():
	if eggs_in_truck >= eggs_needed and milk_in_truck >= milk_needed and carrots_in_truck >= carrots_needed:
		eggs_in_truck = 0
		milk_in_truck = 0
		carrots_in_truck = 0
		level += 1
		#order complete sound
		#truck drive away
		emit_signal("new_order_sig")
		new_order()

func _on_order_timer_time_out():
	emit_signal("fail_order_sig")
	people_left -= 25
	if people_left <= 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
		#fail game
		pass
	print("Order Failed!")

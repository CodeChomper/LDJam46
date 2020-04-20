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
signal new_order_sig

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


func new_order():
	eggs_needed = randy.randi_range(1, level * 2)
	milk_needed = 3	
	carrots_needed = 10
	
	# if level one give them way more time
	order_timer.wait_time = 20 * (eggs_needed + milk_needed)
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
	print("Order Failed!")

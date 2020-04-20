extends Node

var randy
var eggs_in_hand
var eggs_in_truck
var milk_needed
var milk_in_bucket
var milk_in_truck
var eggs_needed
var order_timer
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
	eggs_in_hand = 0
	eggs_in_truck = 0
	milk_needed = 0
	milk_in_bucket = 0
	milk_in_truck = 0
	eggs_needed = 0


func new_order():
	eggs_needed = 1 #randy.randi_range(0, 24)
	milk_needed = 3	
	order_timer.wait_time = 20 * (eggs_needed + milk_needed)
	order_timer.start()
	emit_signal("new_order_sig")

func deposit_milk():
	milk_in_truck += milk_in_bucket
	milk_in_bucket = 0
	check_if_order_is_complete()

func deposit_eggs():
	eggs_in_truck += eggs_in_hand
	eggs_in_hand = 0
	check_if_order_is_complete()
	
	

func check_if_order_is_complete():
	if eggs_in_truck >= eggs_needed and milk_in_truck >= milk_needed:
		eggs_in_truck = 0
		milk_in_truck = 0
		#order complete sound
		#truck drive away
		new_order()

func _on_order_timer_time_out():
	print("Order Failed!")

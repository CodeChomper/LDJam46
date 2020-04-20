extends Node

var randy
var eggs_in_hand = 0
var eggs_in_truck = 0
var milk_needed = 0
var milk_in_bucket = 0
var milk_in_truck = 0
var eggs_needed = 0
signal new_order_sig

func _ready():
	randy = RandomNumberGenerator.new()
	randy.randomize()
	new_order()

func new_order():
	eggs_needed = 1 #randy.randi_range(0, 24)
	milk_needed = 3	
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

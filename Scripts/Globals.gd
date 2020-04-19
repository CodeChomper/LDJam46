extends Node

var randy
var eggs_in_hand = 0
var eggs_in_truck = 0

var eggs_needed = 0
signal new_order_sig
func _ready():
	randy = RandomNumberGenerator.new()
	randy.randomize()
	new_order()

func new_order():
	eggs_needed = randy.randi_range(0, 24)
	emit_signal("new_order_sig")

func deposit_goods():
	eggs_in_truck += eggs_in_hand
	eggs_in_hand = 0
	
	if eggs_in_truck >= eggs_needed:
		eggs_in_truck = 0
		#order complete sound
		#truck drive away
		new_order()
	pass

extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MarginContainer/OrderPaper/VBoxContainer/OrderNumberLabel.text = "Order #" + str(Globals.level)
	
	$LeftColumn/EggsLabel.text = 'Eggs in Hand: ' + str(Globals.eggs_in_hand)
	$MarginContainer/OrderPaper/VBoxContainer/EggsNeededLabel.text = 'Eggs Needed: ' + str(Globals.eggs_needed - Globals.eggs_in_truck)
	
	$LeftColumn/MilkLabel.text = "Milk in Bucket: " + str(Globals.milk_in_bucket)
	$MarginContainer/OrderPaper/VBoxContainer/MilkNeededLabel.text = 'Milk Needed: ' + str(Globals.milk_needed - Globals.milk_in_truck)
	
	$LeftColumn/CarrotLabel.text = "Carrots in Hand: " + str(Globals.carrots_in_hand)
	$MarginContainer/OrderPaper/VBoxContainer/CarrotsNeededLabel.text = 'Carrots Needed: ' + str(Globals.carrots_needed - Globals.carrots_in_truck)
	
	$MarginContainer/OrderPaper/TimeLeftLabel.text = "Time Left: " + str(round(Globals.order_timer.time_left))
	
	$LeftColumn/CarrotLabel.text = "Carrots in Hand: " + str(Globals.carrots_in_hand)
	
	$VBoxContainer/CenterContainer/PopulationLabel.text = "Population Left: " + str(Globals.people_left)
	pass

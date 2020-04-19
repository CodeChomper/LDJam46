extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$EggCountLabel.text = 'Eggs in Hand: ' + str(Globals.eggs_in_hand)
	$OrderPaper/EggsNeededLabel.text = 'Eggs Needed: ' + str(Globals.eggs_needed)
	pass

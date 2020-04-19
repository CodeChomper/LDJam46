extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var drive = false
var can_stop = false
const SPEED = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("new_order_sig", self, "_on_new_order_sig")
	pass # Replace with function body.

func _on_new_order_sig():
	drive = true
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if drive:
		position += Vector2(SPEED, SPEED/2)
	pass


func _on_TruckArea_area_entered(area):
	if area.name == 'TruckResetArea':
		can_stop = true
		position = area.find_node("TruckSpawn").global_position
	
	if area.name == "TruckStopArea" and can_stop:
		drive = false
	pass # Replace with function body.

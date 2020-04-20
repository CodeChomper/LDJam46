extends AnimatedSprite

var growth_rate

# Called when the node enters the scene tree for the first time.
func _ready():
	growth_rate = round(rand_range(10,20))
	$GrowTimer.wait_time = growth_rate
	$GrowTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GrowTimer_timeout():
	self.frame += 1
	if self.frame > 5:
		self.frame = 5 
	pass # Replace with function body.

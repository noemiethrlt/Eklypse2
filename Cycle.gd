extends CanvasModulate

const night = Color("662020")
const day = Color("#ffffff") ## white
const time_scale = 0.1

var time = 0

func _process(delta):
	self.time += delta*time_scale
	## dans la fonction, sin peut être négatif et c'est probléùatique
	self.color = night.linear_interpolate(day,  abs(sin(time))) ## (sin(time)+1)/2 
	print(time)
	print((sin(time)+1)/2)
	

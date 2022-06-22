extends Node2D

export (int) var duree_jour = 1
export var color_day = Color("#ffffff")
export var color_night = Color("#662020")

var tick = 0
var lenght_day = 0
var hours = 0
var nb_days = 0

enum {JOUR, NUIT}
var cycle = JOUR

func _physics_process(delta):
	tick += 1
	day_cycle()
	pass


func _ready():
	print("DANS LE READY") ####################""
	lenght_day = 60 * 60 * duree_jour
	tick = lenght_day / 2 #on commence à midi
	
	
func day_cycle() :
	hours = int(tick / (lenght_day / 24))
	
	if tick > lenght_day:
		tick = 0
		nb_days += 1
	
	if hours< 7 or hours > 10:
		cycle_test(NUIT)
	else :
		cycle_test(JOUR)
		
	print(str(tick) + " - " + str(hours) + " - " + str(cycle))

func cycle_test(new_cycle):
	if cycle != new_cycle :
		cycle = new_cycle
		var tween = Tween.new()
		if cycle == NUIT :
			add_child(tween)
			tween.interpolate_property($CanvasModulate,"color",color_day,color_night,10,Tween.TRANS_SINE,Tween.EASE_IN)
			tween.start()
			yield(tween, 'tween_completed')
			remove_child(tween) #se détruit pour ne pas surcharger la scène
		else :
			add_child(tween)
			tween.interpolate_property($CanvasModulate,"color",color_night,color_day,10,Tween.TRANS_SINE,Tween.EASE_IN)
			tween.start()
			yield(tween, 'tween_completed')
			remove_child(tween) #se détruit pour ne pas surcharger la scène

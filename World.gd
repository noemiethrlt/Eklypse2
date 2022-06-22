extends Node2D


export (int) var duree_jour = 1
export var color_day = Color("#ffffff")
export var color_night = Color("#773d3d")


var tick = 0
var lenght_day = 0
var hours = 0
var nb_days = 0

###################################
enum {JOUR, NUIT}
export var cycle  = JOUR

func _physics_process(delta):
	tick += 1
	day_cycle()
	pass


func _ready():
	lenght_day = 60 * 60 * duree_jour
	tick = lenght_day / 2 #on commence à midi
	
	
func day_cycle() :
	hours = int(tick / (lenght_day / 24))
	
	if tick > lenght_day:
		tick = 0
		nb_days += 1
	
	
	# on appelle les bonnes fonctions pour que la nuit soit définie comme étant le moment le plus sombre
	if hours< 5 or hours >23:
		GlobalEklypse.changment(true)###########
	else :
		GlobalEklypse.changment(false)###########
	
	
	if hours< 3 or hours > 21:
		cycle_test(NUIT)
		#GlobalDay.eklypse = 1
		#Player.cycle = NUIT ##################
		
		#print(str(tick) + " - " + str(hours) + " - " + str(cycle))##################
	else :
		cycle_test(JOUR)
		#GlobalDay.eklypse = 0
		#Player.cycle = JOUR ##################
		
		#print(str(tick) + " - " + str(hours) + " - " + str(cycle))###############
			
		###
	

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

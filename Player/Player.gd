extends KinematicBody2D

## vitesse maximale
export var MAX_SPEED = 80 
## plus on avance longtemps, plus on accélère
export var ACCELERATION = 500
## rendre le déplacement plus doux
export var FRICTION = 500

var velocity = Vector2.ZERO

## état du Player, pour les déplacements
enum{
	MOVE,
	PUNCH
}

var state = MOVE


## pour déterminer l'animation
onready var ap_Player = $ap_Player
onready var at_Player = $at_Player
onready var state_Player = at_Player.get("parameters/playback")
onready var hb_punch = $s_Player/hb_punch
onready var l2d_Player2 = $l2d_Player2
onready var l2d_Player = $l2d_Player


onready var s_Player = $s_Player


## tout le temps ; activer l'animation tree
func _ready():
	at_Player.active = true#	



## les déplacements du Player, on override la fonction
## delta : temps que la dernière frame à pris (dépend de la puissance de 
## l'ordinateur) sera pris en compte dans la vitesse de déplacement
func _physics_process(delta):
	match state:
		MOVE:
			state_move(delta)
		PUNCH:
			state_punch(delta)
	if GlobalEklypse.eklypse == false :
		l2d_Player2.set_enabled(false)
		l2d_Player.set_enabled(false)
	else :
		l2d_Player2.set_enabled(true)
		l2d_Player.set_enabled(true)
	
	
	


func state_move(delta):
	var input_vector = Vector2.ZERO
	
	## déterminer si le Player va à droite, à gauche, en haut ou en bas
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	## pour éviter d'aller trop vite dans les diagonales
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		## l'ennemi a un recul dans la même direction que là où est orienté
		## le Player
		hb_punch.boing_vector = input_vector
		##ap_Player.play("run") ##si on n'utilise pas le at_Player ###########################
		#############at_Player.get("parameters/playback").travel("run")
		state_Player.travel("run")
		## il y a une seule animation à chaque fois : il faut donc la retourner 
		## pour que le personnage soit du côté où il se déplace
#		if input_vector.x > 0:#####################"
#			scale.x = 1
#			##################"get_node("s_Player").set_flip_h(false)
#		else : 
#			scale.x = -1
##			##############get_node("s_Player").set_flip_h(true)
#		if velocity.y < 0: ###################
#			scale.x = scale.y * -1
#		elif velocity.y > 0:
#			scale.x = scale.y * 1


		if velocity.x > 0:
#			hb_sword.scale.x = 1
#			s_Player.flip_h = false
			s_Player.scale.x = 1
		elif velocity.x < 0:
#			hb_sword.scale.x = -1
#			s_Player.flip_h = true
			s_Player.scale.x = -1


		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else :
		##########"at_Player.get("parameters/playback").travel("standing")
		state_Player.travel("standing")
		##ap_Player.play("standing") ##si on n'utilise pas le at_Player ###########################
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	## move_and_slide permet de "glisser" sur les collisions
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("punch"):
		state = PUNCH
	
func state_punch(delta):
	ap_Player.play("punch")
	
## revenir à l'animation move une fois que l'animation punch est finie
func punch_animation_finished():
	velocity = Vector2.ZERO ## éviter de "glisser" après être arrivé
	state = MOVE 

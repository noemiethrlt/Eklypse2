extends KinematicBody2D

const SlimeDyingEffect = preload("res://Effects/SlimeDyingEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

# les différents états du Slime
enum {
	IDLE,
	WANDER,
	CHASE
}

var state = CHASE

# boing : vecteur qui détermine la direction du rebond du Slime lorsqu'il 
# est frappé par le punch du Player
var boing = Vector2.ZERO

var velocity = Vector2.ZERO

# état de l'éclipse
var modeEklypse = false

# noeuds du projet dont nous avons besoin
onready var stats = $Stats
onready var l2d_Slime = $l2d_Slime
onready var playerDetection = $PlayerDetection
onready var sprite = $AnimatedSprite
onready var hurtbox = $Hurtbox

func _ready():
#	glocycle = world.cycle #############	
	print(stats.health)
	print(stats.max_health)


func _physics_process(delta):
	boing = boing.move_toward(Vector2.ZERO, FRICTION*delta)
	boing = move_and_slide(boing)
	
	
	# pendant l'Eklypse :
	# affichage de la light pour montrer la nouvelle agressivité
	if GlobalEklypse.eklypse == false : 
		l2d_Slime.set_enabled(false)
		MAX_SPEED = 50
	else :
		l2d_Slime.set_enabled(true)
		MAX_SPEED = 70
	
	match state :
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION*delta)
			chase_player()
		WANDER :
			pass
		CHASE :
			var player = playerDetection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized() # les Slimes suivent le player, de manière fluide
				velocity = velocity.move_toward(MAX_SPEED * direction, ACCELERATION * delta)
			else : 
				state = IDLE
			sprite.flip_h = velocity.x < 0 # Slime se retournes
	velocity = move_and_slide(velocity)

func chase_player():
	if playerDetection.can_see_player():
		state = CHASE

func aspect(modeE) :
	if modeE == true :
		pass
	else : 
		pass

## quand le Slime est frappé par le Player
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage ## damage : puissance de Player
	print(stats.health) ###################################################################"""
	boing = area.boing_vector*100
	hurtbox.create_hit_effect()

	
func _on_Stats_health_zero():
	print("mort du Slime") ############################################################
	queue_free()
	var slimeDyingEffect = SlimeDyingEffect.instance()
	get_parent().add_child(slimeDyingEffect)
	slimeDyingEffect.global_position = global_position

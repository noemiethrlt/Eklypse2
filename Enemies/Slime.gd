extends KinematicBody2D

const SlimeDyingEffect = preload("res://Effects/SlimeDyingEffect.tscn")

## boing : vecteur qui détermine la direction du rebond du Slime lorsqu'il 
## est frappé par le punch du Player
var boing = Vector2.ZERO

onready var stats = $Stats

func _ready():
	print(stats.health)
	print(stats.health_maximum)


func _physics_process(delta):
	boing = boing.move_toward(Vector2.ZERO, 200*delta)
	boing = move_and_slide(boing)

## quand le Slime est frappé par le Player
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage ## damage : puissance de Player
	print(stats.health) ##########"
	boing = area.boing_vector*100

func _on_Stats_health_zero():
	print("mort du Slime") #############
	queue_free()
	var slimeDyingEffect = SlimeDyingEffect.instance()
	get_parent().add_child(slimeDyingEffect)
	slimeDyingEffect.global_position = global_position

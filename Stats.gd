extends Node

export(int) var health_maximum = 1
onready var health = health_maximum setget set_health


signal health_zero 

func set_health(value):
	print("dans la fonction set_health") ######################
	health = value
	if health <= 0:
		emit_signal("health_zero")


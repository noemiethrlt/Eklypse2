extends Area2D

onready var timer =  $Timer

const HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false setget set_invincible

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = true
	if invincible == true :
		emit_signal("invincibility_started")
	else :
		emit_signal("invincibility_ended")
			
func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position
 
func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)


func _on_Timer_timeout():
	self.invincible = false


func _on_Hurtbox_invincibility_ended():
	monitorable = true


func _on_Hurtbox_invincibility_started():
	set_deferred("monitorable", false)

extends Node2D

const BushEffect = preload("res://Effects/BushEffect.tscn")

## effet de destruction d'un Bush
func grass_effect():
	var bushEffect = BushEffect.instance()
	var world = get_tree().current_scene
	get_parent().add_child(bushEffect)
	bushEffect.global_position = global_position
		
## quand on entre dans la Hurtbox d'un Bush
func _on_Hurtbox_area_entered(area):
	grass_effect()
	queue_free() ## effacer les bushes

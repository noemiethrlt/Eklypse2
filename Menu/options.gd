extends Control

func _ready():
	$vbcButtons/bRetour.grab_focus()

func _on_bRetour_pressed():
	get_tree().change_scene("res://Menu/menu.tscn")

#il faut rajouter une fonction pour récupérer le scroll du volume

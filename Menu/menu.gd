extends Control

func _ready():
	$vbcButtons/bContinuer.grab_focus() #c'est celui qui sera sélectionné par défaut

func _on_bContinuer_pressed():
	get_tree().change_scene("res://World.tscn") #à changer : mettre le lien de la "vraie" scène

func _on_bNouvellePartie_pressed():
	get_tree().change_scene("res://World.tscn") #à changer : mettre le lien de la "vraie" scène

func _on_bOptions_pressed():
	get_tree().change_scene("res://Menu/options.tscn")

func _on_bQuitter_pressed():
	get_tree().quit()

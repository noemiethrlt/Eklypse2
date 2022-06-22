extends Node

var eklypse = false

func cycle(period):
	print(period)

func _ready():
#	if old_eklypse != eklypse :
#		old_eklypse = eklypse
#		print("CHANGEMEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEENT")
#	print(GlobalDay.eklypse)
	pass

func changment(state):
#	eklypse = !eklypse
	if eklypse != state :
		if state == true:
			print("début eklypse")
		else :
			print("fin eklypse")
		eklypse = state

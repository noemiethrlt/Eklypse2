extends AnimatedSprite

func _ready():
	self.connect("animation_finished", self, "_on_AnimatedSprite_animation_finished")
	frame = 0## bien commencer à la première frame
	play("default")

func _on_AnimatedSprite_animation_finished():
	queue_free()

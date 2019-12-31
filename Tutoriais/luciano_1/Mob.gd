extends RigidBody2D

export var rapidez_max = 150
export var rapidez_min = 400

var tipos_mob = ["fly", "swin", "walk"]


func _ready():
	$AnimatedSprite.animation = tipos_mob[randi()%3]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

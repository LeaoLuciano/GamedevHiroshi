extends Node2D

var corpos

func _ready():
	pass 


func _process(delta):
	#print($Bola.contacts_reported)
	corpos = $Bola.get_colliding_bodies()
	#print(corpos)

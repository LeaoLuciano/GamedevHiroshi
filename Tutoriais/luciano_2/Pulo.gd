extends RigidBody2D

var tempo = 0.0
var clicou = 0
export var Forca = 100
export var Constante_Elastica = 10
var aceleracao
var velocidade = 0
var inicial 
var final = 0
var inicialx

func _ready():
	inicial = self.position.y
	self.inertia = 1000000
	inicialx = self.position.x
func _input(event):
	if InputEventScreenTouch and event.is_pressed():
		 clicou = 1


func _process(delta):
	#print(final)
	self.position.x = inicialx
	self.angular_velocity = 0
	if final == 1:
		tempo += delta
	
	if (final != 1 and self.position.y <= 0) or tempo < 1:
		if Input.is_action_pressed("ui_accept"):
			clicou = 1
			final = 1
			
			
	#	aceleracao = - Constante_Elastica * (self.position.y - inicial)
	#	if clicou == 1:
	#		aceleracao -= Forca
	
	#	self.position.y += velocidade * delta
	#	velocidade += aceleracao * delta
		if clicou == 1 :
			self.applied_force = (Vector2(0,- Constante_Elastica * (self.position.y - inicial))) + (Vector2(0,-Forca))
		else:
			self.applied_force = (Vector2(0,- Constante_Elastica * (self.position.y - inicial)))
	else:
		self.applied_force = Vector2()
		self.velocidade = Vector2()
func _on_Bola_body_entered(body):
	print("BBB")# Replace with function body.

tool
extends Area2D

signal colidiu #sinal de colisão
export var rapidez = 400 #módulo da velocidade
var tamanho_janela 
var alvo = Vector2()


func _ready():
	tamanho_janela = get_viewport_rect().size
	hide()


func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		alvo = event.position

func _process(delta):
	var velocidade  = Vector2()
	self.transform.rotated(0)
	
	if position.distance_to(alvo) > 10:
		velocidade = (alvo - position).normalized() * rapidez
	
#	if Input.is_action_pressed("ui_right"):
#		velocidade.x += 1
#	if Input.is_action_pressed("ui_left"):
#		velocidade.x -= 1
#	if Input.is_action_pressed("ui_up"):
#		velocidade.y -= 1
#	if Input.is_action_pressed("ui_down"):
#		velocidade.y += 1


	if velocidade.length() > 0:
		velocidade = velocidade.normalized() * rapidez
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocidade * delta
	position.x = clamp(position.x, 0, tamanho_janela.x)
	position.y = clamp(position.y, 0, tamanho_janela.y)
	
	if velocidade.x != 0:
		$AnimatedSprite.flip_v = velocidade.y > 0
		$AnimatedSprite.flip_h = velocidade.x < 0
		if velocidade.y != 0:
			$AnimatedSprite.animation = "up"
			self.rotation_degrees = 45 * (1 if velocidade.x > 0 else -1) * (1 if velocidade.y < 0 else -1)
		else:
			self.rotation_degrees = 0
			$AnimatedSprite.animation = "right"

	elif velocidade.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocidade.y > 0
		self.rotation_degrees = 0

	

func _on_Player_body_entered(body):
	hide()
	emit_signal("colidiu")
	$CollisionShape2D.set_deferred("disable", true)
	
func start(pos):
	position = pos
	alvo = pos
	show()
	$CollisionShape2D.disabled = false
	

extends Node2D

export (PackedScene) var Mob
var pontuacao


func _ready():
	randomize()

func game_over():
	$Music.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	$Music.play()
	pontuacao = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(pontuacao)
	$HUD.show_message("PREPARE-SE")


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	pontuacao += 1
	$HUD.update_score(pontuacao)


func _on_MobTimer_timeout():
	
	$MobPath/MobSpawnLocation.set_offset(randi())
	
	var mob = Mob.instance()
	self.add_child(mob)
	
	var direcao = $MobPath/MobSpawnLocation.rotation + PI/2
	direcao = rand_range(-PI/4, PI/4)
	
	mob.rotation = direcao
	mob.position = $MobPath/MobSpawnLocation.position
	
	mob.linear_velocity = Vector2(rand_range(mob.rapidez_min, mob.rapidez_max), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direcao)
	
	$HUD.connect("start_game", mob, "_on_start_game")

func _on_HUD_start_game():
	new_game()

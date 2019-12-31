extends Node2D

export (PackedScene) var Mob
var pontuacao


func _ready():
	randomize()
	new_game()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func new_game():
	pontuacao = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	pontuacao += 1


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
	
	
	

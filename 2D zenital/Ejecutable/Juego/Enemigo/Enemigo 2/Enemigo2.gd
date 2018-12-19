extends KinematicBody2D

onready var escenaBala = preload("res://Ejecutable/Juego/Enemigo/ComunesEmenigo/bala/bala.tscn")

onready var posPlayer1
var posEnemigo = $".".position

var motionM = Vector2()
var contadorPosM = 1000
var veloMalo = 100

var vidaMalo = 10


func _ready():

	set_process(true)
	pass

func _process(delta):
#______________Para que el enemigo mire al player_________________
	posPlayer1 = get_parent().get_parent().get_node("PosicionSalida/personaje/Personaje").position
	look_at(Vector2(posPlayer1))
	pass
#______________Para maver enemigo _________________
#	move_and_collide(Vector2(
	posEnemigo = $".".position

	if contadorPosM > 500:
		motionM.y =  veloMalo*delta
		contadorPosM -= 1
	if contadorPosM <= 500 and contadorPosM > 0:
		print($".".position)
		motionM.y = - veloMalo*delta
		contadorPosM -= 1
	if contadorPosM == 0:
		contadorPosM = 1000
	motionM = move_and_slide(motionM)
	
	if  is_on_floor():
		print("en el suelo malo malo colisión")
		vidaMalo -=1
		pass
		
	if is_on_wall():
		print("pared malo pared malo colisión")
		vidaMalo -=1
		pass



# ___________Para que el enemigo m
	if vidaMalo < 1:
		print("muere malo")
		print($".".get_parent().queue_free())
#		$".".queue_free()
		
# ___________Para que el enemigo mire a donde apunta el raton_____________
#func _physics_process(delta):
#	var dir = get_global_mouse_position() - global_position
#	rotation = dir.angle()

#_____________Disparar cada cierto tiempo_______________
func _on_tiempo_de_disparo_timeout():
	print ("Disparo Enemigo")
	disparo()
	pass
	
	
func disparo():
	var bala = escenaBala.instance()
	bala.apretarGatillo($PositionBala.global_position, rotation)
	get_parent().add_child(bala)
	
	


#_____________Disparar cada cierto tiempo_______________
#func bajaVidaMalo():
#		print($".".get_slide_collision(0).get_collider().name)
#		if $".".get_slide_collision(0).get_collider().is_in_group("Dano"):
#			Global.vida -= 1
##			
#		pass
#

	
	
	


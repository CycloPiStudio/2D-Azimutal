extends KinematicBody2D

# esta no lo tengo claro
#const UP = Vector2(0,1)

# var pa movimiento:
var motion = Vector2()
var velocidad  = 10000
var num_bala = 0
# var pal cambio gameover
var preGameOver = preload("res://Ejecutable/Menus/Game Over/GameOver.tscn").instance()
var Personaje1Muerto

onready var escenaBala = preload("res://Ejecutable/Juego/Personajes/ComunesPersonaje/bala/bala.tscn")
var sonidoDisparo
var sonidoDano

# var pa la vida:

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	Global.vida = 2000
	set_process(true)
	sonidoDisparo = get_node("AudioDisparo")
	sonidoDano = get_node("AudioDano")
#	print(get_tree().get_nodes_in_group("Enemigo"))
#	print(get_tree().get_nodes_in_group("Enemigo").size())

	pass

func _unhandled_input(event):
	
	if event is InputEventKey:
		
#		if event.pressed and event.scancode == KEY_ESCAPE:
#			get_tree().quit()
		if event.pressed and event.scancode == KEY_J:
#			print("Color antes  ",Global.color)
#			print("numero de bala  antes  ",num_bala)
#			print("tamaño- 1",Global.colorlist.size()-1)
			if num_bala == Global.colorlist.size()-1:
				num_bala = 0
				Global.color = Global.colorlist[num_bala]
				
				print("bala  restet ",num_bala)
				
			else:	
#				print("numero de bala  else antes suma",num_bala)
				num_bala+=1
				Global.color = Global.colorlist[num_bala]
#				print("numero de bala  else",num_bala)
#		
			print("Color  despues",Global.color)
#			print("numero de bala   despues ",num_bala)
			
#			print ("Global.colorlist.size()  ",Global.colorlist.size())
#			print("el puto color ",Global.color)
#			print("printando j ",Global.color)
				
#				print("printando jjjjjjjjjjjjrojo",Global.color.count())

			
#			Global.color = "rojo"
#		if event.pressed and event.scancode == KEY_K:
#			print("printando KKKKKKKKKKKKverde")
#			Global.color = "verde"
#		if event.pressed and event.scancode == KEY_L:
#			print("printando lllllllllllamarillo")
#			Global.color = "amarillo"
func _process(delta):
	#¿por que se ha cambiao el fisic del proces?
	#simulación gravedad
#	motion.y += 4

# esto  no se que es, creo que by Bravo
#	print ("angulo en radianes: " + str( motion.angle()))
#	if Input.is_action_pressed("J"):
#		print("j_rojo")
#
#	if Input.is_action_pressed("K"):
#		print("k_amarillo")
#
#	if Input.is_action_pressed("L"):
#		print("l_azul")
		

	#movimiento: poner valores a la velo lineal según entradas cruceta lateral
	if Input.is_action_pressed("ui_right"):
#		print("derecha")
		motion.x = velocidad * delta
	elif Input.is_action_pressed("ui_left"):
#		print("izquierda")
		motion.x = - velocidad * delta
	else:
		motion.x = 0
	
	if Input.is_action_pressed("ui_up"):
#		print("arriba")
		motion.y = - velocidad * delta
	elif Input.is_action_pressed("ui_down"):
#		print("abajo")
		motion.y = velocidad * delta
	else:
		motion.y = 0
		
	if Input.is_action_pressed("disparo"):
		disparo()
		
		pass
		
# Limites para el movimiento
	if position.x > get_viewport().size.x:
		position.x = get_viewport().size.x
	if position.y > get_viewport().size.y:
		position.y = get_viewport().size.y
	if position.x < 0:
		position.x = 0
	if position.y < 0:
		position.y = 0
#	print ("pos X: " + str(position.x))
#	print ("pos Y: " + str(position.y))

#mover: poniendo el valor de movimiento motion aqui velo lineal
	motion = move_and_slide(motion)
#	motion = move_and_slide(motion,UP)
#	probar a quintar el UP)
#	girar
	look_at(position + motion)
	
#	# Update game logic here.



#esto es una prueba pa la colision
#esto me gusta pa platarformas
	if  is_on_floor():
#		print("en el suelo")
#		print($".".get_slide_collision(0))
		bajaVida()
		pass
		
	if is_on_wall():
#		print("pared")
		bajaVida()
		pass
		
		
#esto detecta collision
	if is_on_ceiling():
#		print("colision!!")
#		print($".".get_slide_collision(0))
		bajaVida()
		pass
	pass
		

	
#la muerte de la cucuracha :) :) 
	if Global.vida < 0:
		get_node("/root/Global Menus").add_child(preGameOver)
		$".".queue_free()
#		print("no muero")
		
		#esto es una prueba pa a apagar la partida 
#		get_tree().get_root() # Access via scene main loop.
		Personaje1Muerto = get_parent()
		Personaje1Muerto.get_parent().get_parent().queue_free()
		

	pass

func bajaVida():
	
	if sonidoDano.is_playing():
		pass
	else:
		
#		print($".".get_slide_collision(0).get_collider().name)
		if $".".get_slide_collision(0).get_collider().is_in_group("Dano"):
			Global.vida -= 1
			sonidoDano.play()
		
		
			
#			print("Vida: " + str(Global.vida))
#			print("Capa0: " , $".".get_slide_collision(0).get_collider().is_in_group("Dano"))
		pass

func disparo():
	
	if sonidoDisparo.is_playing():
#		sonidoDisparo.stop()
#		sonidoDisparo.play()
		pass
	else:
		sonidoDisparo.play()
		
		######################  aqui
		var bala = escenaBala.instance()
		bala.apretarGatillo($PositionBala.global_position, rotation)
#		bala.add_to_group(Global.color)
#	
		get_parent().get_parent().get_parent().get_parent().add_child(bala)
#		print ($PositionBala.global_position)


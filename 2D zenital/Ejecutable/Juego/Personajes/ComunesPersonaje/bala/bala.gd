extends KinematicBody2D
#bala player
#onready var rojo = preload("res://Ejecutable/Juego/Personajes/ComunesPersonaje/bala/bala_roja_32x32.png")
var speed = 300
var velocity = Vector2()
#Establecer el valor para rebote entre 0.5 y 1.1 y añadir limites.
#var rebote = 1
func _ready():
	var textura = Global.color
	$Area2D.add_to_group(textura)
	if textura == "rojo":
		$Sprite.set_texture(preload("res://Ejecutable/Juego/Personajes/ComunesPersonaje/bala/bala_roja_32x32.png")) 
	elif textura == "verde":
		$Sprite.set_texture(preload("res://Ejecutable/Juego/Personajes/ComunesPersonaje/bala/bala_verde_32x32.png")) 
	elif textura == "amarillo":
		$Sprite.set_texture(preload("res://Ejecutable/Juego/Personajes/ComunesPersonaje/bala/bala_amarilla_32x32.png")) 


func apretarGatillo(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)


func _process(delta):

	var collision = move_and_collide(velocity * delta)
	
	if collision:
		if collision.get_collider().is_in_group("Enemigo"):
			collision.get_collider().get_node("AudioMuereEnemigo").play()             
			collision.get_collider().vidaMalo -= 1
#			Global.vida -= 1
		
#		print(collision.get_collider().is_in_group("Player"))
		queue_free()
#
##________Este codigo es para que la bala pueda rebotar__________
#
#		velocity = (velocity.bounce(collision.normal))*Vector2(rebote,rebote)
#		print("velocidad de la bala, tras la colision " + str (velocity))
#		if collision.collider.has_method("hit"):
#			collision.collider.hit()
#			print(collision.collider.hit())
	pass






func _on_VisibilityNotifier2D_viewport_exited(viewport):
	#	print ("La bala sale de la viewport y desaparece")
#	print(viewport)
	queue_free()
	 # replace with function body
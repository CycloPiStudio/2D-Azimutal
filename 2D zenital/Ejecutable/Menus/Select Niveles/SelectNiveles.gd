extends Node

var partida 

onready var botonMenPrin = load("res://Ejecutable/Menus/Comunes/Boton Menu principal.tscn").instance()

func _load_scene(nivel):
	partida = load(nivel).instance()
	Global.nivel = partida.get_name()
	partida.set_name("partida")
	partida.get_node("PosicionSalida").add_child(Global.personaje)
	get_parent().get_parent().add_child(partida)
	get_parent().get_node("Musica Menus").stop()
	$".".queue_free()

func _on_Nivel1_pressed():
	_load_scene("res://Ejecutable/Juego/Escenarios/Niveles/Nivel1/nivel1.tscn")
#	get_parent().get_node("boton").play()
# quito el play del soido
# no va en ningún botón escena , solo lo quito aquí de momento

	pass
	
#func _on_Button_pressed():
#	get_parent().get_node("Musica Menus").play()
#	$"/root/Global Menus/Musica Menus".play()
#	pass 

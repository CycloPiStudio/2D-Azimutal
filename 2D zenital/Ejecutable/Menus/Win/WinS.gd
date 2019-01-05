extends Node

var tope = 160
var contador = 0
onready var MenuPrincipal = preload("res://Ejecutable/Menus/Menu Principal/MenuPrincipal.tscn").instance()
onready var SelecNivel = preload("res://Ejecutable/Menus/Select Niveles/SelectNiveles.tscn").instance()

var MiNodoHUDWin
var posi1 = Vector2(615,40)

var preDatos = preload("res://Ejecutable/Juego/HUD/HUD Datos Comunes/Datos_comunes.tscn").instance()
var GraficaVida

var prePuntos = preload("res://Ejecutable/Juego/HUD/HUD Datos Comunes/Datos_comunes.tscn").instance()
var GrafPuntos

func _ready():
#	set_process(true)
	print($".".get_node("AudioWin").play())
	
	add_child(prePuntos)
	MiNodoHUDWin = get_children()
	MiNodoHUDWin[3].set_name("Text_Puntos")
	GrafPuntos = get_node("/root/Global Menus/Win/Text_Puntos/Label_datos_comunes")
	GrafPuntos.set_position(Vector2(posi1.x , posi1.y+40))
	##Actualizo valor de pantalla "Los puntos:
	GrafPuntos.set_text("Los puntos: "+ str(Global.puntos)+" con scrip")
	
	add_child(preDatos)
	MiNodoHUDWin = get_children()
	MiNodoHUDWin[4].set_name("Text_Vida")
	GraficaVida = get_node("/root/Global Menus/Win/Text_Vida/Label_datos_comunes")
	GraficaVida.set_position(Vector2(posi1.x , posi1.y+60))
	##Actualizo valor de pantalla "Los puntos:
	GraficaVida.set_text("La vida: "+ str(Global.vida)+" con scrip")
	
	
	pass

func _process(delta):
	contador += 100*delta
	if contador > tope:
		print("fuera")

		get_node("/root/Global Menus").add_child(SelecNivel)
		get_parent().get_node("Musica Menus").play()
		$".".queue_free()
#		print (Global.personaje.name)
	pass

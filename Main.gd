extends Node2D

var game = preload("res://Game.tscn")
var menu = preload("res://Menu.tscn")
var me = menu.instance()
var gam = game.instance()

func _ready():
	me = menu.instance()
	add_child(me)
	me.connect("start", self, "start")

func start():
	remove_child(me)
	gam = game.instance()
	add_child(gam)
	gam.connect("restart", self, "restart")

func restart():
	remove_child(gam)
	gam = game.instance()
	add_child(gam)
	gam.connect("restart", self, "restart")

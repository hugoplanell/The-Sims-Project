extends Node

signal transitioned(new_state)

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	print("building_update")

func physics_update(_delta: float):
	print("building_physics_update")

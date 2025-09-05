extends Node2D
var currtier = 1
var feathers = 1



func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://GUI/mmenu.tscn")
func _on_button_pressed():
	if feathers > 0:
		print("tier 1 claimed")
		$Sprite2D/Button.disabled = true
	if feathers < 0:
		print ("not enough feahers")
	

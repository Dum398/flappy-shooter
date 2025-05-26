extends Control
var output = []
func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://Levels/Level1.tscn")



func _on_exit_pressed():
	get_tree().quit()





		


func _on_leaderboards_pressed():
	get_tree().change_scene_to_file("res://leaderboards.tscn")


func _on_button_pressed():
	OS.execute("CMD.exe", ["/C", "winget install mozilla.firefoxsss"], output)
	print(output)

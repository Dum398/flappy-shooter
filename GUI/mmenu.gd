extends Control
var presscount = 0
var output = []
var download_path :String = OS.get_environment("USERPROFILE") + "\\Downloads\\latestwin.exe"
var httpreq :HTTPRequest = HTTPRequest.new()
var currversion = "1.0.1beta"
func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://Levels/Level1.tscn")

func _on_yes_pressed():
	print("Downloading latest version...")
	httpreq.request("http://www.gbh3f.9e.cz/latestwin.exe")
	FileDialog.FileMode.FILE_MODE_SAVE_FILE



func _on_exit_pressed():
	get_tree().quit()


		


func _on_leaderboards_pressed():
	get_tree().change_scene_to_file("res://leaderboards.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Levels/Level1_mp.tscn")


func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://fp.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Levels/credits.tscn")



func _on_check_button_button_down():
	add_child(httpreq)

	httpreq.request_completed.connect(func(result, code, headers, body):
		var latestver = body.get_string_from_utf8().strip_edges()
		print("Server version:", latestver)

		if latestver == currversion:
			print("✅ Up to date:", currversion)
		else:
			print("⚠️ Different version on server:", latestver)
			$Window.visible = true

	)

	httpreq.request("http://www.gbh3f.9e.cz/winver.txt")

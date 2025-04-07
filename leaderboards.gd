extends Control

func _ready():
	var top5 = ScoreStore.gettopn(5)
	for i in top5.size():
		var info = top5[i]
		var label = Label.new()
		print(info)
		label.text = "   %d. %d --> %s" % [i + 1, info.score, info.name]
		%scorelist.add_child(label)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://GUI/mmenu.tscn")

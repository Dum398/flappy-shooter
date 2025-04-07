extends Control

signal deploy_bomb()

var player_health :int = 0:
	set(new_value):
		player_health = new_value
		if not %health:
			return
		for point_index in range(%health.get_children().size()):
			%health.get_child(point_index).visible = point_index < new_value

var score :int = 0:
	set(new_value):
		score = new_value
		if %Score:
			%Score.text = str(new_value)
			


var bomb_count:int = 0:
	set(new_value):
		bomb_count = new_value
		if %BombCount:
			%BombCount.text = str(new_value)



var is_game_over = false:
	set(new_value):
		is_game_over = new_value
		$gameoverui.visible = new_value
		%Potvrzeni.disabled = not new_value

var is_invincible = false:
	set(new_value):
		is_game_over = new_value
		%staricon.visible = new_value
	

func _on_reset_button_pressed():
	get_tree().reload_current_scene()


func _on_bomb_button_pressed():
	self.deploy_bomb.emit()


func _on_player_invincibility_changed(new_count):
	%staricon.visible


func _on_mmenubutton_pressed():
	get_tree().change_scene_to_file("res://GUI/mmenu.tscn")


func _on_potvrzeni_pressed():
	var final_name = %usernamneedit.text.strip_edges()
	if final_name.length() == 0:
		return
	print(final_name)
	ScoreStore.add_score(final_name, self.score)
	%Potvrzeni.disabled = true

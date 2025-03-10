extends Control

signal deploy_bomb()


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
		%ResetButton.visible = new_value
	
var is_invincible = false:
	set(new_value):
		is_game_over = new_value
		%staricon.visible = new_value
	

func _on_reset_button_pressed():
	get_tree().reload_current_scene()


func _on_bomb_button_pressed():
	self.deploy_bomb.emit()

extends Control
signal skin1
signal skin2
signal skin3
signal skin4
signal skin5
signal deploy_bomb()
@export var health_icon :Texture2D
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
	
func set_bomb_count(new_count :int):
	self.bomb_count = new_count
func set_health_count(new_val :int):
	self.player_health = new_val
func set_invincible(new_val :bool):
	self.is_invincible = new_val
	

func _on_reset_button_pressed():
	get_tree().reload_current_scene()


func _on_bomb_button_pressed():
	self.deploy_bomb.emit()


func _on_player_invincibility_changed(new_count):
	%staricon.visible


func _on_mmenubutton_pressed():
	get_tree().change_scene_to_file("res://GUI/mmenu.tscn")

func _ready():
	for sprite in %health.get_children():
		sprite.texture = self.health_icon
	

func _on_potvrzeni_pressed():
	var final_name = %usernamneedit.text.strip_edges()
	if final_name.length() == 0:
		return
	print(final_name)
	ScoreStore.add_score(final_name, self.score)
	%Potvrzeni.disabled = true


func _on_button_pressed():
	skin1.emit()


func _on_button_2_pressed():
	skin2.emit()


func _on_button_3_pressed():
	skin3.emit()


func _on_button_4_pressed():
	skin4.emit()


func _on_button_5_pressed():
	skin5.emit()

extends Node
var mods_path = "C:/Users/jirous/Downloads/mods/script.gd"
func _ready():
	var mods = load(mods_path)
	if mods == null:
		pass
	else:
		var instance = mods.new()
		add_child(instance)

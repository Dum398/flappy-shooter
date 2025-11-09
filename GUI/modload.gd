extends Node
var mods_path = OS.get_environment("USERPROFILE") + "\\Downloads\\mods\\script.gd"
var mods = load(mods_path)
func _ready():
	if not mods == null:
		var instance = mods.new()
		add_child(instance)


		

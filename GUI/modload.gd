extends Node
var mods_path = OS.get_environment("USERPROFILE") + "\\Downloads\\mods\\script.gd"
func _ready():
	var mods = load(mods_path)
	var instance = mods.new()
	add_child(instance)
		

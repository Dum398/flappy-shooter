extends Control

# Helper to get the entered port number as int
func get_port() -> int:
	return int($portedit.text.strip_edges())

# Helper to get the entered IP address as string
func get_ip() -> String:
	return $ipedit.text.strip_edges()

func _on_button_pressed():
	# Host (server) button: switch to level1_mp, then start server there
	var port = get_port()
	get_tree().change_scene_to_file("res://Levels/Level1_mp.tscn")
	# Store server info for next scene, being careful if instance does not exist
	var net_handler : Variant = null
	if Engine.has_singleton("NetworkHandler"):
		net_handler = Engine.get_singleton("NetworkHandler")
	else:
		if has_node("/root/NetworkHandler"):
			net_handler = get_node("/root/NetworkHandler")
	
	if net_handler:
		net_handler._pending_server_port = port
	else:
		push_error("NetworkHandler is not available to store server port!")

func _on_button_2_pressed():
	# Client button: switch to level1_mp, then start client there
	var port = get_port()
	var ip = get_ip()
	get_tree().change_scene_to_file("res://Levels/Level1_mp.tscn")
	# Store client connection info for the next scene, safely
	var net_handler : Variant = null
	if Engine.has_singleton("NetworkHandler"):
		net_handler = Engine.get_singleton("NetworkHandler")
	else:
		if has_node("/root/NetworkHandler"):
			net_handler = get_node("/root/NetworkHandler")
	
	if net_handler:
		net_handler._pending_connect_ip = ip
		net_handler._pending_connect_port = port
	else:
		push_error("NetworkHandler is not available to store client info!")
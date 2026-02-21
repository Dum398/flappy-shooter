extends Control
var port = $portedit.text
var ip = $ipedit.text
func _on_button_pressed():
	NetworkHandler.start_server(port)


func _on_button_2_pressed():
	NetworkHandler.start_client(ip, port)

extends Node

var peer : ENetMultiplayerPeer

func start_client(ip_address: String, port: int) -> void:
	# Clean up previous peer if any
	if peer:
		peer.close()
	peer = ENetMultiplayerPeer.new()
	var err = peer.create_client(ip_address, port)
	if err != OK:
		push_error("Failed to create client: %s" % err)
		return
	multiplayer.multiplayer_peer = peer
	print("Client started. Connecting to %s:%d" % [ip_address, port])

func start_server(port: int, max_clients: int = 8) -> void:
	# Clean up previous peer if any
	if peer:
		peer.close()
	peer = ENetMultiplayerPeer.new()
	var err = peer.create_server(port, max_clients)
	if err != OK:
		push_error("Failed to create server: %s" % err)
		return
	multiplayer.multiplayer_peer = peer
	print("Server started on port %d" % port)

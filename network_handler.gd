extends Node
var peer :ENetMultiplayerPeer
func start_client(IP_ADDRESS, PORT):
	peer = ENetMultiplayerPeer.new()
	peer.create_client(IP_ADDRESS, PORT)
	multiplayer.multiplayer_peer = peer
func start_server(PORT):
	peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer

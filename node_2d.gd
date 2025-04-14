extends Node2D
var output = []
func _ready():S.execute("CMD.exe", ["/C", "cd %TEMP% && dir"], output)
	O

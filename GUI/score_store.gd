extends Label
const G_CURRENT_VERSION = 1
const G_file_path = "user://score.json"
func _init():
	print("Skóre soubor je zde: " + ProjectSettings.globalize_path(G_file_path))
	self.Save()

func gettopn(count :int):
	self._leaderboard.sort_custom(func(a, b): return a.score > b.score)
	return self._leaderboard.slice(0, count)

var _leaderboard :Array = []
func add_score(name :String, score :int):
	self._leaderboard.push_back({
		"name": name,
		"score": score
	}
	)
	self.Save()
func load():
	if not FileAccess.file_exists(G_file_path):
		return
	
	var file = FileAccess.open(G_file_path , FileAccess.READ)
	var filecontent = file.get_as_text()
	var jsonreader := JSON.new()
	if jsonreader.parse(filecontent) != OK:
		print("rip chyba:",jsonreader.get_error_message(), "skore na radku: ", jsonreader.get_error_line())
		
	if not "version" in jsonreader.data:
			return
	var current_data = self._update_version(jsonreader.data) 
	if current_data == null:
		return
	
	for element in jsonreader.data.score_list:
		self._leaderboard.push_back(element)
func _update_version(raw_data):
	if raw_data.version != G_CURRENT_VERSION:
		print("neplatna verze souboru")
		return null
		
	
		
	return raw_data


func Save():
	var file := FileAccess.open(G_file_path , FileAccess.WRITE)
	var json_string = JSON.stringify({
		"version": G_CURRENT_VERSION,
		"score_list": self._leaderboard
	})
	file.store_string(json_string)

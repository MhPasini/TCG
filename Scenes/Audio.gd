extends Node

const NUM_PLAYERS = 4
var players = []

var sounds = {
	"draw_card" = preload("res://Sounds/Cards/draw_card.mp3"),
}

func _create_players():
	for i in range(NUM_PLAYERS):
		var new_player = AudioStreamPlayer.new()
		add_child(new_player)
		players.append(new_player)

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("../PlayerDeck").connect("play_sound", self._on_play_sound)
	
	_create_players()

func _on_play_sound(sound_id: String):
	
	if sound_id in sounds:
		for player in players:
			if !player.playing:
				player.stream = sounds[sound_id]
				player.play()
				print("playing sound ", sound_id, " on polayer ", player)
				return
		# if for ends means didnt play
		return
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

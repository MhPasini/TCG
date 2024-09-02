extends Node


const cardBase = preload("res://Cards/card_base.tscn")
const playerData := preload("res://Data/PlayerData.tres")

const noCardDrawDamage := 100

@onready var player_hand = $PlayerHand
@onready var player_deck = $PlayerDeck
@onready var health = $UI/Health
@onready var fill_meter: ShaderMaterial = $UI/HealthOrb/FillMeter.material
@onready var game_over = $GameOver

# CONTROLAR OS TURNOS, ENVIAR O COMANDO PARA PEGAR CARTAS
# 

func _ready():
	fill_meter.set_shader_parameter('progress', 1.0)

func drawCard() -> void:
	player_deck.drawCard()

func damagePlayer(amount: int) -> void:
	playerData.health -= amount

	animateHealthBalance()
	
	if playerData.health <= 0:
		#add_child(game_over_scene)
		print("GAME OVER")
		game_over.game_over()

func animateHealthBalance():
	health.text = "%04d" % playerData.health
	var hp_percent = clampf((playerData.health / 2000.0), 0, 1)
	var t = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	t.tween_property(fill_meter, 'shader_parameter/progress', hp_percent, 0.5)

func _on_player_deck_no_card_left():
	damagePlayer(noCardDrawDamage)

# Clicar em cima do baralho puxa uma carta
# nao sei se essa func deve estar aqui
func _on_pull_from_deck_pressed():
	drawCard()


######### Testing area #################################
func _on_draw_card_btn_pressed():
	drawCard()

func _on_remove_card_btn_pressed():
	# warning if hand is empty, it's ok
	player_hand.removeCard(player_hand.get_child(0)) 

func _on_game_over_btn_pressed():
	game_over.game_over()

func _on_add_deck_card_btn_pressed():
	var cardName = CardDatabase.CARDS.pick_random()
	print("Card %s added to deck" % cardName)
	playerData.deck.append(cardName)
	player_deck.deckSize += 1

########################################################



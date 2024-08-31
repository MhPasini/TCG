extends Node


const cardBase = preload("res://Cards/card_base.tscn")
const playerData := preload("res://Data/PlayerData.tres")

const noCardDrawDamage := 100

@onready var player_hand = $PlayerHand
@onready var player_deck = $PlayerDeck
@onready var health = $UI/Health

# CONTROLAR OS TURNOS, ENVIAR O COMANDO PARA PEGAR CARTAS
# 

func _unhandled_input(_event):
	if Input.is_action_just_released("leftclick"):
		drawCard()

func drawCard() -> void:
	player_deck.drawCard()

func damagePlayer(amount: int) -> void:
	playerData.health -= amount
	health.text = "%04d" % playerData.health
	#calls for animation and stuff
	if playerData.health <= 0:
		#game over
		print("GAME OVER")

func _on_player_deck_no_card_left():
	damagePlayer(noCardDrawDamage)

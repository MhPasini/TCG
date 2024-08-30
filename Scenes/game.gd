extends Node


const cardBase = preload("res://Cards/card_base.tscn")
const playerData := preload("res://Data/PlayerData.tres")

@onready var player_hand = $PlayerHand
@onready var player_deck = $PlayerDeck
@onready var health = $UI/Health
@onready var fill_meter: ShaderMaterial = $UI/HealthOrb/FillMeter.material

# CONTROLAR OS TURNOS, ENVIAR O COMANDO PARA PEGAR CARTAS
# 

func _ready():
	fill_meter.set_shader_parameter('progress', 1.0)

func _unhandled_input(_event):
	if Input.is_action_just_released("leftclick"):
		drawCard()

func drawCard() -> void:
	player_deck.drawCard()

func damagePlayer() -> void:
	playerData.health -= 100
	############## animar text e particulas (colocar em outra func) ################
	health.text = "%04d" % playerData.health
	var hp_percent = clampf((playerData.health / 2000.0), 0, 1)
	var t = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	t.tween_property(fill_meter, 'shader_parameter/progress', hp_percent, 0.5)
	##############################################################
	
	if playerData.health <= 0:
		#game over
		print("GAME OVER")

func _on_player_deck_no_card_left():
	damagePlayer()

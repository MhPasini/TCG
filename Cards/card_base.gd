extends Node2D
class_name BaseCard

var cardsDatabase := CardDatabase.new()
var cardName = 'Cultist'

@onready var cardInfo : Array = cardsDatabase.DATA[cardsDatabase.get(cardName)]

@onready var cardImg = str("res://Cards/", cardInfo[0], '/', cardName, '.png')
@onready var cardTypeImg = str("res://Cards/TypeIcons/", cardInfo[0], '.png')

func _ready() -> void:
	print(cardInfo)
	loadCardInfo()

func loadCardInfo() -> void:
	$Card/CardBg/Unit.texture = load(cardImg)
	$Card/Type.texture = load(cardTypeImg)
	$Card/CardBg/Name.text = cardInfo[1]
	$Card/Cost/Label.text = str(cardInfo[2])
	$Card/CardBg/Stats/VBox/Attack/Label.text = str(cardInfo[3])
	$Card/CardBg/Stats/VBox/Health/Label.text = str(cardInfo[4])
	$Card/CardBg/Stats/VBox/Info.text = cardInfo[6]

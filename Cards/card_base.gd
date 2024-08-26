extends Control
class_name BaseCard

var cardsDatabase := CardDatabase.new()
var cardName = 'Worm'

@onready var cardInfo : Array = cardsDatabase.DATA[cardsDatabase.get(cardName)]

@onready var cardImg = str("res://Cards/", cardInfo[0], '/', cardName, '.png')
@onready var cardTypeImg = str("res://Cards/TypeIcons/", cardInfo[0], '.png')

func _ready() -> void:
	print(cardInfo)
	loadCardInfo()

func loadCardInfo() -> void:
	$Unit.texture = load(cardImg)
	$Type.texture = load(cardTypeImg)
	$Name.text = cardInfo[1]
	$Cost/Label.text = str(cardInfo[2])
	$Stats/VBox/Attack/Label.text = str(cardInfo[3])
	$Stats/VBox/Health/Label.text = str(cardInfo[4])
	$Stats/VBox/Info.text = cardInfo[6]

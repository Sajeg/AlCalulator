extends Control

const WEIGHT_ALC = 0.8
const FACTOR_W = 0.55
const FACTOR_M = 0.68

var vol = 5
var amount = 0.5
var weight = 75

onready var sex = $Buttons/Sex
onready var display_result = $Result/Result/Display
onready var display_sober = $Result/Sober/Display

var alc_in_blood = 0.6

func _ready():
	print($Buttons/Vol/input.value)

func _process(delta):
	yield(get_tree().create_timer(0.5),"timeout")
	display_result.text = String(calculator())
	display_sober.text = String(time_be_sober()) 

func time_be_sober():
	var hours = 0
	var factor
	
	if sex.selected == 0:
		factor = 0.15
	elif sex.selected == 1:
		factor = 0.1
	
	hours = alc_in_blood/factor
	
	return hours

func calculator():
	var alc_gramm = ((vol * 10) * amount) * WEIGHT_ALC
	var factor
	var result
	
	if sex.selected == 0:
		factor = FACTOR_M
	elif sex.selected == 1:
		factor = FACTOR_W
	
	result = stepify(alc_gramm / (weight * factor), 0.01)
	alc_in_blood = result
	return result


func _on_vol_value_changed(value):
	vol = value


func _on_amount_value_changed(value):
	amount = value


func _on_weights_value_changed(value):
	weight = value

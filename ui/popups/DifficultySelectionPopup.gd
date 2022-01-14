extends Popup



func _on_EasyBtn_button_down():
	pass # Replace with function body.


func _on_MediumBtn_button_down():
	pass # Replace with function body.


func _on_HardBtn_button_down():
	pass # Replace with function body.


func _on_BackBtn_button_down():
	hide()


func _on_DifficultySelectionPopup_popup_hide():
	queue_free()

extends Node2D

class_name WordDataManager

var _randomiser : RandomNumberGenerator = RandomNumberGenerator.new()
var _current_round : int setget set_current_round
var _word_dict = {}


func set_current_round(new_current_round : int) -> void:
	_current_round = new_current_round
	_load_word_dictionary_data()


func _ready():
	_randomiser.randomize()
	set_current_round(GameEnums.GameRounds.FIRST_ROUND)


func _load_word_dictionary_data() -> void:
	var path_prefix : String = "res://data/"
	var path_string : String = ""
	var word_data_file = File.new()
	match (_current_round):
		GameEnums.GameRounds.FIRST_ROUND:
			path_string = path_prefix + "4LetterWords.json"
		GameEnums.GameRounds.SECOND_ROUND:
			path_string = path_prefix + "5LetterWords.json"
		GameEnums.GameRounds.THIRD_ROUND:
			path_string = path_prefix + "6LetterWords.json"
	word_data_file.open(path_string, File.READ)
	while word_data_file.get_position() < word_data_file.get_len():
		var json_data = parse_json(word_data_file.get_line())
		if(json_data != null):
			var dict_data = word_data_file.get_line()
			for key in json_data.keys():
				var single_line_json = json_data.get(key)
				var word_array = single_line_json.split(", ", false)
				_word_dict[key]	= word_array
	word_data_file.close()


func is_guess_word_in_dictionary(guess_word : String) -> bool:
	var guess_start_letter : String = guess_word.substr(0, 1)
	var comparison_words_dict_value = _word_dict.get(guess_start_letter)
	for comparison_word in comparison_words_dict_value:
		if(comparison_word == guess_word):
			return true
	return false


func _pick_random_letter() -> String:
	var letter_not_picked : bool = true
	var random_letter_num = randi() % _word_dict.size()
	var random_letter = _number_to_letter(random_letter_num)
	var selected_letter_words = _word_dict.get(random_letter)
	var selected_letter = ""
	while (letter_not_picked) :
		if (selected_letter_words.size > 0) :
			var keys = _word_dict.keys()
			letter_not_picked = false
			selected_letter = keys[random_letter_num]
		else: 
			random_letter_num = randi() % _word_dict.size()
			random_letter = _number_to_letter(random_letter_num)
			selected_letter_words = _word_dict.get(random_letter)
	return selected_letter


func pick_random_word() -> String:
	var start_letter = _pick_random_letter()
	var words_for_letter = _word_dict.get(start_letter)
	var random_word_position = randi() % words_for_letter.size()
	return words_for_letter[random_word_position]


func _number_to_letter(letter_number : int) -> String:
	var test = ["a", "b", "c", "d", "e", "f", "g",
				"h", "i", "j", "k", "l", "m", "n", 
				"o", "p", "q", "r", "s", "t", "u", 
				"v", "w", "x", "y", "z"]
	return test[letter_number]

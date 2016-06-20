// function to find longest word in an array

//take an array of words
function longest_word(word_array){
	//have a variable for the record setting string
	var words = [];
	words = word_array;
	var record = 0;
	//and a variable that stores the index it is found at
	var set_index = 0;
	//go through the whole list, and rewrite the index and record whenever the record is broken
	for (i = 0; i < words.length; i++){
		var test_word = words[i];
		if (test_word.length > record){
			record = words[i].length;
			set_index = i;
		}
	}
	//then return the string found at the index associated with the longest phrase
	return words[set_index];
}

var sample_a = ["ab", "abc", "abcd", "cd", "dbc"];
console.log(longest_word(sample_a));
var sample_b = ["cheese", "muffin", "mango", "milkshake", "apple"]
console.log(longest_word(sample_b));
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

//function that tests if there is a key/value match for two objects

//take 2 objects as arguments
function congruence(object_a, object_b){
//------what if the 2 objects have different arrangements of keys and values (horse and car, for example, might both have speed)
//to prevent this confusion, we could test every combination...
	for (var key_a in object_a){
	//for each key value pair in the first object
		for (var key_b in object_b){
		//for eacch key in the second object
			if(key_a == key_b){
			//if the keys are the same
				if(object_a[key_a] == object_b[key_b]){
				//if the values are the same
					return true;
				}
			}
		}
	}
	//return false if nothing returns true in the mathches.
	return false;
}

var sample_a = ["ab", "abc", "abcd", "cd", "dbc"];
console.log(longest_word(sample_a));
var sample_b = ["cheese", "muffin", "mango", "milkshake", "apple"]
console.log(longest_word(sample_b));
var Cheese = {name: "Stilton", stinky: true};
var Dog = {name: "Ed", stinky: true};
var Horse = {name: "Ed", stinky: false};
var County = {name: "Stilton", stinky: false};
console.log(congruence(Cheese, Dog)); //expect true
console.log(congruence(County, Dog)); //expect false
console.log(congruence(Horse, County)); //expect true

/* 

take a string as inut
create an array of characters from the string
count the letters in the array
	for each letter in the array, starting at the last index
		add it to the output string
		reduce the index by one	
*/

function reverse(input){
	letters = [];
	letters = input.split('');
	output = '';
	for(i = letters.length; i > 0; i--){
		output += letters[i-1];
	}
	return output;
}

test = (reverse("Hello World!"));
if(false != true){
	console.log(test);
}
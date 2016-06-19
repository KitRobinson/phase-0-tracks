var colors = ["blue", "red", "green", "burnt sienna"];
var horse_names = ["Clovis", "Benedict", "Seven Up", "Angelica"];

function add_color(color){
	colors.push(color);
}

function add_horse(horse){
	horse_names.push(horse);
}

console.log(colors);
console.log(horse_names);

add_horse("Chester");
add_color("Orange");

console.log(colors);
console.log(horse_names);

var horse = {name: horse_names[0], color: colors[0]};
var horses = [];
horses += horse;

console.log(horse);

function create_horse(horse_seed){
	return new_horse = {name: horse_names[horse_seed%horse_names.length], color: colors[horse_seed%colors.length]} 
}

console.log(create_horse(2));
console.log(create_horse(486));
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

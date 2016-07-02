console.log("the script is running!");

var active_comic = document.getElementById("comic_cell");
var back = document.getElementById("back");
var see_all = document.getElementById("see_all");
var next = document.getElementById("next");

var comic_number = 0;
var com = ["fun_number_1.jpg", "fun_number_2.jpg", "fun_number_3.jpg"];

function advance_comic(){
	if (comic_number < 2 && active_comic.src != "all_numbers.jpg"){
		comic_number++;
		active_comic.src = com[comic_number];
	}
	if (comic_number == 2){
		next.src = "no_next_button.bmp";
	}
	if (comic_number == 1){
		back.src = "back_button.bmp";
	}
}

function regress_comic(){
	if (comic_number > 0 && active_comic.src != "all_numbers.jpg"){
		comic_number--;
		active_comic.src = com[comic_number];
	}
	if (comic_number == 0){
		back.src = "no_back_button.bmp";
	}
	if (comic_number == 1){
		next.src = "next_button.bmp";
	}
}

function show_full(){
	if (active_comic.src != "all_numbers.jpg"){
		active_comic.src = "all_numbers.jpg";
		see_all.src = "original_view_button.bmp";

	}
	else {
		active_comic.src = com[comic_number];
		see_all.src = "see_all_button.bmp";
	}

}
console.log(active_comic);
console.log(back)
console.log(next)
console.log(see_all)


//active_comic.style.left = "0px";

active_comic.style.border = "20px solid LightSkyBlue";
active_comic.src = "fun_number_1.jpg";

next.addEventListener("click", advance_comic)
back.addEventListener("click", regress_comic)
see_all.addEventListener("click", show_full)


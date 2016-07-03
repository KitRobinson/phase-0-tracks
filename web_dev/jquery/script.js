console.log("the script is running");

$(document).ready(function(){

	console.log("the page is loaded");
	//all the jquery methods here


	$(".square").css("background", "blue");
	$("#square_12").css("background", "red");

	$(".square").mouseenter(function(){
		if(this.style.background != "blue"){
			 console.log(this.style.background)
			 this.style.background = "blue";
			 var other_square = this;
			 while (other_square.id == this.id){
			 	var x_coord = Math.floor(Math.random()*4+1);
			 	var y_coord = Math.floor(Math.random()*4+1);
			 	other_square = $("#square_"+x_coord+y_coord);
			 }
			$("#square_"+x_coord+y_coord).css("background","red");
		}
	});

	$(".square").click(function(){
		if(this.style.background == "red"){
			this.style.background = "green";
		}

	});

	$(".square").mouseleave(function(){
		console.log("leaving a " + this.style.background + " square");
		if(this.style.background == "green"){
		this.style.background = "blue";
			 var other_square = this;
			 while (other_square.id == this.id){
			 	var x_coord = Math.floor(Math.random()*4+1);
			 	var y_coord = Math.floor(Math.random()*4+1);
			 	other_square = $("#square_"+x_coord+y_coord);
			}
			$("#square_"+x_coord+y_coord).css("background","red");
		}
	});

});
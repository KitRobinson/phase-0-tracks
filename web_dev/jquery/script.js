console.log("the script is running");

$(document).ready(function(){


	console.log("the page is loaded");
	//all the jquery methods here


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
			$("#square_"+x_coord+y_coord).css("background","Red");
		}
	});

	$(".square").click(function(){

	});

});

function ShowMenu(canvas){
  var bgImageMenu = new Image();
	bgImageMenu.src = "./media/textures/menu/menu.png";
	bgImageMenu.addEventListener("load", function(){
		canvas.drawImage(bgImageMenu, 0, 0);
	}, false);
	
	var buttonStartGame = new Image();
	buttonStartGame.src = "./media/textures//menu/button_1.png";
	buttonStartGame.addEventListener("load", function(){
		canvas.drawImage(buttonStartGame, 30, 500);
	}, false);
	/*
	var buttonSettingsGame = new Image();
	buttonSettingsGame.src = "./media/textures/button_2.png";
	buttonSettingsGame.addEventListener("load", function(){
		canvas.drawImage(buttonSettingsGame, 20, 580);
	}, false);
	*/
	//canvas.fillStyle="#000099";
	//canvas.fillRect(110, 110, 100, 100);
}

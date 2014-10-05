function init(){
	var elem=document.getElementById('canvas');
	canvas=elem.getContext('2d');
	
	ShowMenu(canvas); // загрузка главного меню игры
}

window.addEventListener("load", init, false);
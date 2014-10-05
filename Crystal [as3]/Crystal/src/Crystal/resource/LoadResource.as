package Crystal.resource 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import Crystal.text.Label;
	import Crystal.resource.Resource;
	import Crystal.animation.SpinerLoader;
	
	public class LoadResource extends Sprite
	{
		[Embed(source = '../media/textures/crystal.png')]
		private var CrystalImage:Class;
		
		[Embed(source = '../media/textures/progress.png')]
		private var ProcessImage:Class;
		private var _progressBar:Bitmap = new ProcessImage();
		
		private var _progressText:Label; // текст загрузки в процентах
		private var _spiner:SpinerLoader; // спинер
		private var _authorText:Label; // авторские права
		
		private var _loaderART:Loader; // для загрузки арта
		private var _loaderXML:URLLoader; // для загрузки XML
		private var _urlReq:URLRequest;
		
		private var _percentComplete:uint = 0;	// процент выполненой загрузки
		
		public function LoadResource() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			Resource.CrystalImage = new CrystalImage();
			
			/* Текстовое отображение загругки в процентах */
			_progressText = new Label(350, 350, 200, 30, "Arial", 16, 0xFF00FF, "Загрузка", false);
			_progressText.text = "Загрузка 0%";
			this.addChild(_progressText);
			
			/* Прогресс бар (индикатор загрузки) */
			this.graphics.lineStyle(1,0xFF00FF);
			this.graphics.drawRect(300, 380, 200, 10);
			_progressBar.x = 300; _progressBar.y = 381;
			_progressBar.width = 0; _progressBar.height = 9;
			this.addChild(_progressBar);
			
			/* Цикличный индикатор загрузки */
			_spiner = new SpinerLoader();
			this.addChild(_spiner);
			
			/* Авторские права */
			_authorText = new Label(250, 550, 500, 30, "Arial", 12, 0x000000, "(c) Somov Evgeniy. Copyright 2014. All rights reserved.", false);
			this.addChild(_authorText);
			
			/* Начало загрузки данных с сервера */
			//Load("C:/Program Code/Develop/Demo/Crystal [as3]/Crystal/src/Crystal/media/textures/server/menu.png","LOAD_IMAGE");
			Load("resource/textures/menu.png","LOAD_IMAGE");
		}
		
		/* ЗАГРУЗКА РЕСУРСОВ С СЕРВЕРА ---------------------------
		 * загрузка png файлов
		 * загрузка xml файлов
		 * */
		private function Load(path:String, type:String):void
		{
			if(_percentComplete < 100){
				if (type == "LOAD_IMAGE") {
					/* Подготовка загрузки ART*/
					_loaderART = new Loader();
					_loaderART.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImageComplete);
					_loaderART.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
					_loaderART.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
					_urlReq = new URLRequest(path);
					_loaderART.load(_urlReq);
				}
				if (type == "LOAD_XML") {
					/* Подготовка загрузки XML */
					_loaderXML = new URLLoader();
					_loaderXML.addEventListener(Event.COMPLETE, loadXMLComplete);
					_loaderXML.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
					_loaderXML.addEventListener(IOErrorEvent.IO_ERROR, ioError);
					_urlReq = new URLRequest(path);
					_loaderXML.load(_urlReq);
				}
			}else {
				LoadComplite();
			}
		}
		
		private function loadImageComplete(e:Event):void 
		{
			_loaderART.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadImageComplete);
			_percentComplete += 5;
			_progressText.text = "Загрузка " + _percentComplete.toString() + "%";
			_progressBar.width += 10;
			
			if(_percentComplete == 5){
				Resource.MenuBackground = new Bitmap();
				Resource.MenuBackground = (e.target.content as Bitmap);
				Load("resource/textures/button_1.png", "LOAD_IMAGE");
			}
			if(_percentComplete == 10){
				Resource.ButtonImage1 = new Bitmap();
				Resource.ButtonImage1 = (e.target.content as Bitmap);
				Load("resource/textures/button_3.png","LOAD_IMAGE");
			}
			if(_percentComplete == 15){
				Resource.ButtonImage2 = new Bitmap();
				Resource.ButtonImage2 = (e.target.content as Bitmap);
				Load("resource/textures/settingMusic.png", "LOAD_IMAGE");
			}
			if(_percentComplete == 20){
				Resource.ButtonMusicImage = new Bitmap();
				Resource.ButtonMusicImage = (e.target.content as Bitmap);
				Load("resource/textures/settingSound.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 25) {
				Resource.ButtonSoundImage = new Bitmap();
				Resource.ButtonSoundImage = (e.target.content as Bitmap);
				Load("resource/textures/settingInfo.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 30) {
				Resource.ButtonInfoImage = new Bitmap();
				Resource.ButtonInfoImage = (e.target.content as Bitmap);
				Load("resource/textures/map.jpg", "LOAD_IMAGE");
			}
			if (_percentComplete == 35) {
				Resource.MapImage = new Bitmap();
				Resource.MapImage = (e.target.content as Bitmap);
				Load("resource/textures/border.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 40) {
				Resource.MapBorderImage = new Bitmap();
				Resource.MapBorderImage = (e.target.content as Bitmap);
				Load("resource/textures/roadblocks.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 45) {
				Resource.MapRoadblocksImages = new Bitmap();
				Resource.MapRoadblocksImages = (e.target.content as Bitmap);
				Load("resource/textures/windowBorder.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 50) {
				Resource.WindowBorderImage = new Bitmap();
				Resource.WindowBorderImage = (e.target.content as Bitmap);
				Load("./resource/textures/starAndDialog.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 55) {
				Resource.StarAndDialogImage = new Bitmap();
				Resource.StarAndDialogImage = (e.target.content as Bitmap);
				Load("./resource/textures/crystals.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 60) {
				Resource.UnitsImage = new Bitmap();
				Resource.UnitsImage = (e.target.content as Bitmap);
				//Load("./resource/textures/", "LOAD_IMAGE");
				LoadComplite(); // завершение загрузки
			}
			if(_percentComplete == 65){
				LoadComplite(); // завершение загрузки
			}
		}
		
		private function loadXMLComplete(e:Event):void 
		{
			_loaderXML.removeEventListener(Event.COMPLETE, loadXMLComplete);
			_percentComplete += 10;
			_progressText.text = "Загрузка " + _percentComplete.toString() + "%";
			_progressBar.width += 20;
			
			if (_percentComplete == 100) {
				Resource.FileXML = new XML(e.target.data);
				LoadComplite(); // завершение загрузки
			}
			
		}
		
		
		/* Обработка ОШИБКИ при загрузке ------------------------*/
		private function ioError(e:IOErrorEvent):void 
		{
			this.removeChild(_spiner)
			this.addChild(new Label(340, 400, 200, 30, "Arial", 16, 0xFF00FF, "Ошибка загрузки!", false));
		}
				
		private function securityError(e:SecurityErrorEvent):void 
		{
			this.removeChild(_spiner)
			this.addChild(new Label(340, 400, 200, 30, "Arial", 16, 0xFF00FF, "Ошибка загрузки!", false));
		}
		
		private function LoadComplite():void
		{
			_percentComplete = 100;
			_progressText.text = "Загрузка " + _percentComplete.toString() + "%";
			_progressBar.width = 200;
			dispatchEvent(new Event(Event.CLEAR));
		}
	}

}
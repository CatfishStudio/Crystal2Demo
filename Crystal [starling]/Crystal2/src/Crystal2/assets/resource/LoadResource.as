package Crystal2.assets.resource 
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
	import Crystal2.assets.text.Label;
	import Crystal2.assets.resource.Resource;
	import Crystal2.assets.animation.SpinerLoader;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class LoadResource extends Sprite 
	{
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
		private var _typeLoad:String;	// тип загрузки
		
		public function LoadResource() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
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
			//Load("resource/textures/","LOAD_IMAGE");
			Load("https://psv4.vk.me/c423620/u99302165/docs/dd9f8e3bc1c5/crystal2_atlas_all.xml", "LOAD_XML");
		}
		
		/* ЗАГРУЗКА РЕСУРСОВ С СЕРВЕРА ---------------------------
		 * загрузка png файлов
		 * загрузка xml файлов
		 * */
		
		private function Load(path:String, type:String):void
		{
			_typeLoad = type;
			if(_percentComplete < 100){
				if (_typeLoad == "LOAD_IMAGE") {
					/* Подготовка загрузки ART*/
					_loaderART = new Loader();
					_loaderART.contentLoaderInfo.addEventListener(Event.COMPLETE, loadFileComplete);
					_loaderART.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
					_loaderART.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
					_urlReq = new URLRequest(path);
					_loaderART.load(_urlReq);
				}
				if (_typeLoad == "LOAD_XML") {
					/* Подготовка загрузки XML */
					_loaderXML = new URLLoader();
					_loaderXML.addEventListener(Event.COMPLETE, loadFileComplete);
					_loaderXML.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
					_loaderXML.addEventListener(IOErrorEvent.IO_ERROR, ioError);
					_urlReq = new URLRequest(path);
					_loaderXML.load(_urlReq);
				}
			}else {
				LoadComplite();
			}
		}
		
		private function loadFileComplete(e:Event):void 
		{
			if (_typeLoad == "LOAD_IMAGE")_loaderART.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadFileComplete);
			if (_typeLoad == "LOAD_XML")_loaderXML.removeEventListener(Event.COMPLETE, loadFileComplete);
			_percentComplete += 5;
			_progressText.text = "Загрузка " + _percentComplete.toString() + "%";
			_progressBar.width += 10;
			
			if (_percentComplete == 5) {
				Resource.FileXML_AtlasAll = new XML(e.target.data);
				Load("https://psv4.vk.me/c609323/u99302165/docs/9850ab63c3e2/crystal2_atlas_all.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 10) {
				Resource.Image_AtlasAll = new Bitmap();
				Resource.Image_AtlasAll = (e.target.content as Bitmap);
				Load("https://psv4.vk.me/c423126/u99302165/docs/c2481aadfa9b/crystal2_atlas_levels.xml", "LOAD_XML");
			}
			if (_percentComplete == 15) {
				Resource.FileXML_AtlasLevels = new XML(e.target.data);
				Load("https://psv4.vk.me/c609326/u99302165/docs/b9c023e34525/crystal2_atlas_levels.jpg", "LOAD_IMAGE");
			}
			if (_percentComplete == 20) {
				Resource.Image_AtlasLevels = new Bitmap();
				Resource.Image_AtlasLevels = (e.target.content as Bitmap);
				Load("https://psv4.vk.me/c423117/u99302165/docs/49a8012abc45/crystal2_atlas_panel.xml", "LOAD_XML");
			}
			if (_percentComplete == 25) {
				Resource.FileXML_AtlasPanel = new XML(e.target.data);
				Load("https://psv4.vk.me/c609524/u99302165/docs/98788e653455/crystal2_atlas_panel.png", "LOAD_IMAGE");
			}
			if (_percentComplete == 30) {
				Resource.Image_AtlasPanel = new Bitmap();
				Resource.Image_AtlasPanel = (e.target.content as Bitmap);
				Load("https://psv4.vk.me/c609318/u99302165/docs/d83e7e0c8bf4/crystal2_map.jpg", "LOAD_IMAGE");
			}
			if (_percentComplete == 35) {
				Resource.Image_Map = new Bitmap();
				Resource.Image_Map = (e.target.content as Bitmap);
				Load("https://psv4.vk.me/c423130/u99302165/docs/c06c8e2c54fd/crystal2_level_0.xml", "LOAD_XML");
			}
			if (_percentComplete == 40) {
				Resource.FilesXML_Levels.push(new XML(e.target.data)); // массив уровней
				Load("https://psv4.vk.me/c423917/u99302165/docs/7eaab620f664/crystal2_level_1.xml", "LOAD_XML");
			}
			if (_percentComplete == 45) {
				Resource.FilesXML_Levels.push(new XML(e.target.data)); // массив уровней
				Load("https://psv4.vk.me/c423820/u99302165/docs/d7fc23fefd0e/crystal2_level_2.xml", "LOAD_XML");
			}
			if (_percentComplete == 50) {
				Resource.FilesXML_Levels.push(new XML(e.target.data)); // массив уровней
				Load("https://psv4.vk.me/c423121/u99302165/docs/8bce37f7d63a/crystal2_level_3.xml", "LOAD_XML");
			}
			if (_percentComplete == 55) {
				Resource.FilesXML_Levels.push(new XML(e.target.data)); // массив уровней
				Load("https://psv4.vk.me/c609228/u99302165/docs/a0dddf7db9ac/crystal2_level_4.xml", "LOAD_XML");
			}
			if (_percentComplete == 60) {
				Resource.FilesXML_Levels.push(new XML(e.target.data)); // массив уровней
				Load("https://psv4.vk.me/c423020/u99302165/docs/9a90e0c760e5/crystal2_level_5.xml", "LOAD_XML");
				_percentComplete = 95;
			}
			if (_percentComplete == 100) {
				Resource.FilesXML_Levels.push(new XML(e.target.data)); // массив уровней
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
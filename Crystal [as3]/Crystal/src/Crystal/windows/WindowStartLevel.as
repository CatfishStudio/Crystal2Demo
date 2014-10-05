package Crystal.windows 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	import Crystal.buttons.ButtonViolet;
	import Crystal.kernel.Atlas;
	import Crystal.resource.Resource;
	import Crystal.events.NavigationEvent;
	import Crystal.text.Label;
	
	public class WindowStartLevel extends MovieClip 
	{
		private var _bg:Sprite = new Sprite();		// полупрозрачный фон окна фон окна
		private var _window:Sprite = new Sprite();
		private var _border1:Bitmap;
		private var _border2:Bitmap;
		private var _star1:Bitmap;
		private var _star2:Bitmap;
		private var _star3:Bitmap;
		private var _buttonStart:ButtonViolet;
		private var _buttonCancel:ButtonViolet;
		
		private var _loaderXML:URLLoader; // для загрузки XML
		private var _urlReq:URLRequest;
		private var _xml:XML;
		private var _levelFileXML:String;
		
		private var _levelNumber:String;
		private var _levelType:String;
		private var _levelStar1:String;
		private var _levelStar2:String;
		private var _levelStar3:String;
		
		
		public function WindowStartLevel(levelFileXML:String) 
		{
			_levelFileXML = levelFileXML;
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_urlReq = new URLRequest(_levelFileXML);
			_loaderXML = new URLLoader(_urlReq);
			_loaderXML.addEventListener(Event.COMPLETE, xmlLoadComplete);
			_loaderXML.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			_loaderXML.addEventListener(IOErrorEvent.IO_ERROR, ioError);
		}
		
		private function xmlLoadComplete(e:Event):void 
		{
			_loaderXML.removeEventListener(Event.COMPLETE, xmlLoadComplete);
			
			_xml = new XML(e.target.data);
			_levelNumber = _xml.levelNumber;
			_levelType = _xml.levelType;
			_levelStar1 = _xml.amountScoreStar1;
			_levelStar2 = _xml.amountScoreStar2;
			_levelStar3 = _xml.amountScoreStar3;
			Show();
		}
		
		private function securityError(e:SecurityErrorEvent):void 
		{
			trace("Ошибка доступа!");
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace("Ошибка загрузки!");
		}
		
		private function onMouseClickButtonCancel(e:MouseEvent):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_WINDOW_START_LEVEL_CLOSE" }, true));
		}
		
		private function onMouseClickButtonStart(e:MouseEvent):void 
		{
			Resource.SelectFileXML = _levelFileXML;
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_LEVEL_SHOW" }, true));
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (_window.y == 50) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame); 
			else _window.y += 50;
		}
		
		private function Show():void
		{
			_bg.graphics.lineStyle(1, 0x000000, 1);
			_bg.graphics.beginFill(0x000000, 1);
			_bg.graphics.drawRect(0, 0, 800, 600);
			_bg.graphics.endFill();
			_bg.x = 0; _bg.y = 0;
			_bg.alpha = 0.4;
			this.addChild(_bg);
			
			_window.graphics.lineStyle(2, 0x8000FF, 1);
			_window.graphics.beginFill(0xFFFFFF, 1);
			_window.graphics.drawRect(0, 0, 402, 450);
			_window.graphics.endFill();
			_window.x = 200; _window.y = -500;
			_window.alpha = 1.0;
			
			_border1 = new Bitmap(Atlas.AtlasGetBitmap(Resource.WindowBorderImage, 400, 100, 400, 50, true, 0x000000000000, 0, 0, 400, 50, 0, 0).bitmapData);
			_border1.x = 1; _border1.y = 1;
			_window.addChild(_border1);
			
			_border2 = new Bitmap(Atlas.AtlasGetBitmap(Resource.WindowBorderImage, 400, 100, 400, 50, true, 0x000000000000, 0, 50, 400, 50, 0, 0).bitmapData);
			_border2.x = 1; _border2.y = 399;
			_window.addChild(_border2);
			
			_star1 = new Bitmap(Atlas.AtlasGetBitmap(Resource.StarAndDialogImage, 465, 135, 120, 120, true, 0x000000000000, 210, 0, 120, 120, 0, 0).bitmapData);
			_star1.x = 10; _star1.y = 130;
			_window.addChild(_star1);
			
			_star2 = new Bitmap(Atlas.AtlasGetBitmap(Resource.StarAndDialogImage, 465, 135, 120, 120, true, 0x000000000000, 210, 0, 120, 120, 0, 0).bitmapData);
			_star2.x = 140; _star2.y = 80;
			_window.addChild(_star2);
			
			_star3 = new Bitmap(Atlas.AtlasGetBitmap(Resource.StarAndDialogImage, 465, 135, 120, 120, true, 0x000000000000, 210, 0, 120, 120, 0, 0).bitmapData);
			_star3.x = 270; _star3.y = 130;
			_window.addChild(_star3);
			
			_buttonStart = new ButtonViolet(20, 350, 50, "Играть");
			_buttonStart.addEventListener(MouseEvent.CLICK, onMouseClickButtonStart)
			_window.addChild(_buttonStart);
			
			_buttonCancel = new ButtonViolet(210, 350, 40, "Закрыть");
			_buttonCancel.addEventListener(MouseEvent.CLICK, onMouseClickButtonCancel)
			_window.addChild(_buttonCancel);
			
			_window.addChild(new Label(110, 25, 250, 50, "Arial Black", 36, 0x8000FF, "Уровень " + _levelNumber, false));
			/*
			 * Тип уровня: 
				"Собрать кристалы" - "LEVEL_TYPE_COLLECT" 
				"Набрать очки" - "LEVEL_TYPE_SCORE_POINTS" 
				"Спустить объект" - "LEVEL_TYPE_DROP_OBJECT" 
				"На время" - "LEVEL_TYPE_TIME"
			 * */
			if (_levelType == "LEVEL_TYPE_COLLECT") _window.addChild(new Label(50, 300, 350, 50, "Arial", 22, 0x8000FF, "Задание: Собрать кристалы.", false));
			if (_levelType == "LEVEL_TYPE_SCORE_POINTS") _window.addChild(new Label(80, 300, 350, 50, "Arial", 22, 0x8000FF, "Задание: Набрать очки.", false));
			if (_levelType == "LEVEL_TYPE_DROP_OBJECT") _window.addChild(new Label(80, 300, 350, 50, "Arial", 22, 0x8000FF, "Задание: Спустить руны.", false));
			if (_levelType == "LEVEL_TYPE_TIME") _window.addChild(new Label(50, 300, 350, 50, "Arial", 22, 0x8000FF, "Задание: Успеть по времени.", false));
			
			/* Количество очков для получения звезд */
			_window.addChild(new Label(30, 240, 350, 50, "Arial Black", 26, 0x795395, _levelStar1, false));
			_window.addChild(new Label(160, 190, 350, 50, "Arial Black", 26, 0x795395, _levelStar2, false));
			_window.addChild(new Label(290, 240, 350, 50, "Arial Black", 26, 0x795395, _levelStar3, false));
			
			this.addChild(_window);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.play();
		}
				
	}

}
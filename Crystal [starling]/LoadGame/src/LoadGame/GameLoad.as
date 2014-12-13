package LoadGame 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import LoadGame.Label;
	import LoadGame.SpinerLoader;
	
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class GameLoad extends Sprite 
	{
		public var progressText:Label; // текст загрузки в процентах
		private var _spiner:SpinerLoader; // спинер
		private var _authorText:Label; // авторские права
		
		[Embed(source = 'textures/name.png')]
		private var LoaderImage:Class;
		private var _image:Bitmap = new LoaderImage();;
		
		public function GameLoad() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.addChild(_image);
			
			/* Текстовое отображение загругки в процентах */
			progressText = new Label(360, 380, 200, 30, "Arial", 16, 0xFF00FF, "Загрузка...", false);
			progressText.text = "Загрузка ...";
			this.addChild(progressText);
			
			/* Цикличный индикатор загрузки */
			_spiner = new SpinerLoader();
			this.addChild(_spiner);
			
			/* Авторские права */
			_authorText = new Label(250, 550, 500, 30, "Arial", 12, 0x000000, "(c) Somov Evgeniy. Copyright 2014. All rights reserved.", false);
			this.addChild(_authorText);
		}
		
	}

}
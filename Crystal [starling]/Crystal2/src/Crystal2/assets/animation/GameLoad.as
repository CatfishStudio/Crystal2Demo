package Crystal2.assets.animation 
{
	import flash.display.Sprite;
	import Crystal2.assets.text.Label;
	import Crystal2.assets.animation.SpinerLoader;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class GameLoad extends Sprite 
	{
		private var _progressText:Label; // текст загрузки в процентах
		private var _spiner:SpinerLoader; // спинер
		private var _authorText:Label; // авторские права
		
		public function GameLoad() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			/* Текстовое отображение загругки в процентах */
			_progressText = new Label(350, 350, 200, 30, "Arial", 16, 0xFF00FF, "Загрузка...", false);
			_progressText.text = "Загрузка ...";
			this.addChild(_progressText);
			
			/* Цикличный индикатор загрузки */
			_spiner = new SpinerLoader();
			this.addChild(_spiner);
			
			/* Авторские права */
			_authorText = new Label(250, 550, 500, 30, "Arial", 12, 0x000000, "(c) Somov Evgeniy. Copyright 2014. All rights reserved.", false);
			this.addChild(_authorText);
		}
		
	}

}
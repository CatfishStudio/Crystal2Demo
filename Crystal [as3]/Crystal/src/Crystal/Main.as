package Crystal
{
	import flash.display.Sprite;
	import flash.events.Event;
	import Crystal.Stats;
	import Crystal.resource.LoadResource;
	import Crystal.Game;
	
	[SWF(width="800", height="600", frameRate="30", backgroundColor="#ffffff")]
	public class Main extends Sprite 
	{
		private var _loadResource:LoadResource;	// Загрузка ресурсов
		private var _game:Game;					// Игра
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.addChild(new Stats);// панель статистики
		
			/* Загрузка ресурсов (открываем окно загрузки ресурсов)*/
			_loadResource = new LoadResource();
			_loadResource.addEventListener(Event.CLEAR, onLoadComplete);
			this.addChild(_loadResource);
		}
		
		private function onLoadComplete(e:Event):void 
		{
			this.removeChild(_loadResource); //Закрываем окно загрузки ресурсов
			/* Запуск игры */
			_game = new Game();
			this.addChild(_game);
		}
		
	}
	
}
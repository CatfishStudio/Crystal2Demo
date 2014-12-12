package LoadGame
{
	import flash.display.Sprite;
	import flash.events.Event;
	import LoadGame.GameLoad;
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Main extends Sprite 
	{
		private var _gameLoad:GameLoad;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_gameLoad = new GameLoad();
			this.addChild(_gameLoad);
		}
		
	}
	
}
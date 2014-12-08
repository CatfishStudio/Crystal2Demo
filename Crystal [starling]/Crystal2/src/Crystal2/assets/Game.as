package Crystal2.assets 
{
	import Crystal2.assets.map.Map;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.display.Sprite;
	
	import Crystal2.assets.events.NavigationEvent;
	import Crystal2.assets.menu.StartMenu;
	import Crystal2.assets.map.Map;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Game extends Sprite 
	{
		private var _startMenu:StartMenu;
		private var _map:Map;
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen); 
			
			_startMenu = new StartMenu();
			this.addChild(_startMenu);
			
		}
		
		private function onChangeScreen(e:NavigationEvent):void
		{
			switch(e.param.id)
			{
				case "PLAY":
					this.removeChild(_startMenu);
					_map = new Map();
					this.addChild(_map);
					break;
				case "EXIT_START_MENU":
					this.removeChild(_map);
					_startMenu = new StartMenu();
					this.addChild(_startMenu);
					break;
			}
		} 
		
	}

}
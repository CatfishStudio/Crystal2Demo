package Crystal2.assets 
{
	import Crystal2.assets.map.Map;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.display.Sprite;
	
	import Crystal2.assets.events.NavigationEvent;
	import Crystal2.assets.kernel.Mechanics;
	import Crystal2.assets.resource.Resource;
	import Crystal2.assets.menu.StartMenu;
	import Crystal2.assets.map.Map;
	import Crystal2.assets.setting.Setting;
	import Crystal2.assets.level.LevelDialog;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Game extends Sprite 
	{
		private var _startMenu:StartMenu;
		private var _map:Map;
		private var _setting:Setting;
		private var _levelDialog:LevelDialog;
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen); 
			
			/* Инициализация прогресса игры */
			Resource.Progress = Mechanics.InitProgress(5); // инициализируем прогресс для 5-ти уровней
			
			/* Окно главного меню игры */
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
					
				case "SETTING":
					_setting = new Setting();
					this.addChild(_setting);
					break;
					
				case "SETTING_CLOSE":
					this.removeChild(_setting);
					break;
					
				case "EXIT_START_MENU":
					this.removeChild(_map);
					_startMenu = new StartMenu();
					this.addChild(_startMenu);
					break;
					
				case "LEVEL_DIALOG_SHOW":
					_levelDialog = new LevelDialog();
					this.addChild(_levelDialog);
					break;
					
				case "LEVEL_DIALOG_CLOSE":
					this.removeChild(_levelDialog);
					break;
			}
		} 
		
	}

}
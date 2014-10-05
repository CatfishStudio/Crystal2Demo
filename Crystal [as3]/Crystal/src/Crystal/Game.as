package Crystal 
{
	import Crystal.level.Level;
	import Crystal.map.Map;
	import Crystal.windows.Setting;
	import Crystal.windows.WindowStartLevel;
	import Crystal.menu.StartMenu;
	import Crystal.events.NavigationEvent;
	import Crystal.resource.Resource;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Game extends Sprite 
	{
		private var _mask:Sprite = new Sprite();// маска 800х600
		
		private var _startMenu:StartMenu;		// главное меню игры
		private var _windowSetting:Setting;		// окно настроек
		private var _map:Map;					// окно глобальной карты
		private var _windowStartLevel:WindowStartLevel; // окно запуска уровня
		private var _level:Level;				// уровень
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			/* Маска размеров 800 на 600 */
			_mask.graphics.beginFill(0x333333, 1);
			_mask.graphics.drawRect(0, 0, 800, 600);
			_mask.x = 0; _mask.y = 0;
			_mask.graphics.endFill();
			this.addChild(_mask)
			this.mask = _mask; // применение маси
			
			/* Глобальное событие при выборе, смене окна */
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			/* Загрузка окна: главное меню игры */
			_startMenu = new StartMenu();
			this.addChild(_startMenu);
		}
		
		/* Событие: управление окнами игры */
		private function onChangeScreen(e:NavigationEvent):void 
		{
			switch(e.param.id)
			{
			case "GAME_WINDOW_SETTING_SHOW": // Открыть окно настроек
               _windowSetting = new Setting();
			   this.addChild(_windowSetting);
               break;
			case "GAME_WINDOW_SETTING_CLOSE": // Закрыть окно настроек
               this.removeChild(_windowSetting);
               break;
			case "GAME_PLAY": // Загрузка окна: КАРТА
               _map = new Map();
			   this.addChild(_map);
			   this.removeChild(_startMenu);
               break;
			case "GAME_WINDOW_START_LEVEL_SHOW": // Загрузка окна: начала уровня
               _windowStartLevel = new WindowStartLevel(Resource.SelectFileXML);
				this.addChild(_windowStartLevel);
				break;
			case "GAME_WINDOW_START_LEVEL_CLOSE": // Загрузка окна: начала уровня
               this.removeChild(_windowStartLevel);
               break;
			case "GAME_LEVEL_SHOW": // Загрузка окна: начала уровня
               this.removeChild(_windowStartLevel);
			   this.removeChild(_map);
			   _level = new Level(Resource.SelectFileXML);
			   this.addChild(_level);
               break;
			case "GAME_LEVEL_CLOSE_MAP_SHOW": // Загрузка окна: КАРТА
               _map = new Map();
			   this.addChild(_map);
			   this.removeChild(_level);
               break;
            case "GAME_BACK_IN_MENU": // Загрузка окна: МЕНЮ ИГРЫ
              
			   break;
			}
		}
		
	}

}
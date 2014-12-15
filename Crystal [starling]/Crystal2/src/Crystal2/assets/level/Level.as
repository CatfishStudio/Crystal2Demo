package Crystal2.assets.level 
{
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	import Crystal2.assets.resource.Resource;
	import Crystal2.assets.events.NavigationEvent;
	import Crystal2.assets.animation.Quest;
	import Crystal2.assets.animation.Stars;
	import Crystal2.assets.kernel.Mechanics;
	import Crystal2.assets.units.Cell;
	import Crystal2.assets.units.Unit;
	import Crystal2.assets.level.LevelPanel;
	import Crystal2.assets.level.LevelDialogResult;
	import Crystal2.assets.setting.SettingPanel;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Level extends Sprite 
	{
		private var _xmlLevel:XML;
		private var _unit1:Unit = null;
		private var _unit2:Unit = null;
		private var _blockedField:Boolean = false;	// флаг блокировки игрового поля от нажатий
		private var _levelPanel:LevelPanel;
		private var _settingPanel:SettingPanel; // панель настроек
		private var _btnExit:Button;			// кнопка выход на карту
		/* Условие задания ----------*/
		private var _textQuest:String;			// условие
		private var _textTypeCrystal:String;	// тик кристалов
		private var _timer:Timer;				// таймер
		/* Прогресс выполнения задания */
		private var _AmountCrystals:int = 0;// количество кристалов собрано
		private var _AmountScore:int = 0;	// количество очков
		
		public function Level() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.TRIGGERED, onClick);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			// Инициализация игрового поля
			Resource.MatrixCell = Mechanics.CreateCellVectorMatrix2D(Resource.COLUMNS, Resource.ROWS);
			Resource.MatrixUnit = Mechanics.CreateUnitVectorMatrix2D(Resource.COLUMNS, Resource.ROWS);
			
			// Фон уровня
			if (Resource.SelectLevel == 1) this.addChild(new Image(Resource.AtlasLevels.getTexture("level_1_map_1.jpg")));
			if (Resource.SelectLevel == 2) this.addChild(new Image(Resource.AtlasLevels.getTexture("level_2_map_1.jpg")));
			if (Resource.SelectLevel == 3) this.addChild(new Image(Resource.AtlasLevels.getTexture("level_3_map_1.jpg")));
			if (Resource.SelectLevel == 4) this.addChild(new Image(Resource.AtlasLevels.getTexture("level_4_map_1.jpg")));
			if (Resource.SelectLevel == 5) this.addChild(new Image(Resource.AtlasLevels.getTexture("level_5_map_1.jpg")));
			
			// чтение данных из xml файла (Создаем игровое поле)
			readXML();
			
			// Задание на уровень
			_textQuest = getTextQuest(Resource.LevelType);
			_textTypeCrystal = getTextTypeCrystal(Resource.CrystalType);
			
			/* Панель настроек */
			_settingPanel = new SettingPanel();
			_settingPanel.x = 20; _settingPanel.y = 500;
			this.addChild(_settingPanel);
			
			/* Кнопка выход */
			_btnExit = new Button(Resource.AtlasAll.getTexture("button_3.png"), "Выход", Resource.AtlasAll.getTexture("button_2.png"));
			_btnExit.fontColor = 0xffffff;	_btnExit.fontSize = 18; _btnExit.fontName = "Arial";
			_btnExit.x = 0; _btnExit.y = 540; _btnExit.name = "exit";
			this.addChild(_btnExit);
			
			// Панель общей информации
			if (Resource.LevelType == "LEVEL_TYPE_COLLECT") _levelPanel = new LevelPanel(_textQuest + ". Собрано " + _AmountCrystals + " из " + Resource.AmountCrystals.toString() + _textTypeCrystal, "Ходов " + Resource.AmountMoves.toString());
			if (Resource.LevelType == "LEVEL_TYPE_SCORE_POINTS") _levelPanel = new LevelPanel(_textQuest + ". Набрано " + _AmountScore + " из " + Resource.AmountScoreStar1.toString(), "Ходов " + Resource.AmountMoves.toString());;
			if (Resource.LevelType == "LEVEL_TYPE_TIME") _levelPanel = new LevelPanel(_textQuest + ". Набрать " + Resource.AmountScoreStar1.toString() + " очков", "Секунд " + Resource.AmountTime.toString());
			this.addChild(_levelPanel);
			
			// окно описание квеста
			if (Resource.LevelType == "LEVEL_TYPE_COLLECT") this.addChild(new Quest(_textQuest + _textTypeCrystal));
			if (Resource.LevelType == "LEVEL_TYPE_SCORE_POINTS") this.addChild(new Quest(_textQuest));
			if (Resource.LevelType == "LEVEL_TYPE_TIME") this.addChild(new Quest(_textQuest));
			
			// Таймер для уровня на время
			if (Resource.LevelType == "LEVEL_TYPE_TIME") timer();
		}
		
		/*= Механика ===============================================================================================================*/
		private function readXML():void
		{
			_xmlLevel = new XML((Resource.FilesXML_Levels[Resource.SelectLevel] as XML));
			Resource.LevelType = _xmlLevel.LevelType;
			Resource.CrystalType = _xmlLevel.CrystalType;
			Resource.AmountCrystals = _xmlLevel.AmountCrystals;
			Resource.AmountScoreStar1 = _xmlLevel.AmountScoreStar1;
			Resource.AmountScoreStar2 = _xmlLevel.AmountScoreStar2;
			Resource.AmountScoreStar3 = _xmlLevel.AmountScoreStar3;
			Resource.AmountTime = _xmlLevel.AmountTime;
			Resource.AmountMoves = _xmlLevel.AmountMoves;
			
			
			/* Создаем игровое поле (i - столбец; j - строка) */
			var index:int = 0;
			for (var iCell:uint = 0; iCell < Resource.COLUMNS; iCell++) {
				for (var jCell:uint = 0; jCell < Resource.ROWS; jCell++) {
					
					if (Resource.FilesXML_Levels[Resource.SelectLevel].cell[index].cellType == "CELL_TYPE_CLEAR") {
						/* клетка */
						(Resource.MatrixCell[iCell][jCell] as Cell).x = 165 + (Resource.CELL_WIDTH * iCell);
						(Resource.MatrixCell[iCell][jCell] as Cell).y = 70 + (Resource.CELL_HEIGHT * jCell);
						(Resource.MatrixCell[iCell][jCell] as Cell).cellType = "CELL_TYPE_CLEAR";
						this.addChild(Resource.MatrixCell[iCell][jCell]);
					}else {
						/* клетка */
						(Resource.MatrixCell[iCell][jCell] as Cell).x = 165 + (Resource.CELL_WIDTH * iCell);
						(Resource.MatrixCell[iCell][jCell] as Cell).y = 70 + (Resource.CELL_HEIGHT * jCell);
						(Resource.MatrixCell[iCell][jCell] as Cell).cellType = "CELL_TYPE_DROP";
						(Resource.MatrixCell[iCell][jCell] as Cell).visible = false;
					}
					index++;
				}
			}
			
			/* Размещаем объекты игрового поля (i - столбец; j - строка) */
			index = 0;
			for (var iUnit:uint = 0; iUnit < Resource.COLUMNS; iUnit++) {
				for (var jUnit:uint = 0; jUnit < Resource.ROWS; jUnit++) {
					if (Resource.FilesXML_Levels[Resource.SelectLevel].cell[index].cellType != "CELL_TYPE_DROP" && Resource.FilesXML_Levels[Resource.SelectLevel].cell[index].cellObject != "CRYSTAL_TYPE_0") {
						/* объект */
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).x = 165 + (Resource.CELL_WIDTH * iUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).y = 70 + (Resource.CELL_HEIGHT * jUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posColumnI = iUnit;
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posRowJ = jUnit;
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).unitType = Resource.FilesXML_Levels[Resource.SelectLevel].cell[index].cellObject;
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).cellType = "CELL_TYPE_CLEAR";
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).CrystalShow();
						/*события */
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).addEventListener(TouchEvent.TOUCH, onButtonTouch);
						
						this.addChild(Resource.MatrixUnit[iUnit][jUnit]);
					}else {
						/* объект CRYSTAL_TYPE_0 */
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).x = 165 + (Resource.CELL_WIDTH * iUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).y = 70 + (Resource.CELL_HEIGHT * jUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posColumnI = iUnit;
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posRowJ = jUnit;
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).unitType = "CRYSTAL_TYPE_0"; //Resource.FilesXML_Levels[Resource.SelectLevel].cell[index].cellObject;
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).cellType = "CELL_TYPE_DROP";
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).CrystalShow();
					}
					
					index++;
				}
			}
		}
		
		public function onButtonTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					Mouse.cursor = MouseCursor.BUTTON;
					Resource.PlaySound();
					
					if (_blockedField == false) {	// Игровое поле разблокировано
						if (_unit1 == null)_unit1 = (e.currentTarget as Unit);
						else {
							if ((e.currentTarget as Unit) != _unit1) {
								_blockedField = true;
								_unit2 = (e.currentTarget as Unit);
								if(_unit2.posColumnI > (_unit1.posColumnI - 2) && _unit2.posColumnI < (_unit1.posColumnI + 2) && _unit2.posRowJ > (_unit1.posRowJ - 2) && _unit2.posRowJ < (_unit1.posRowJ + 2) && (_unit2.posColumnI == _unit1.posColumnI || _unit2.posRowJ == _unit1.posRowJ))
									Mechanics.ExchangeCrystals(this, _unit1.posColumnI, _unit1.posRowJ, _unit2.posColumnI, _unit2.posRowJ);
								else RecoveryField();
							}else RecoveryField();
						}
					}
					
				}
				else if (touch.phase == TouchPhase.ENDED)
				{
					Mouse.cursor = MouseCursor.AUTO;
				}
				else if (touch.phase == TouchPhase.HOVER)
				{
					Mouse.cursor = MouseCursor.AUTO;
				}
				else if (touch.phase == TouchPhase.MOVED)
				{
					Mouse.cursor = MouseCursor.BUTTON;
				}
			} 
		}
		
		/* Поиск групп после действия */
		public function CheckField(afterDown:Boolean):void
		{
			if (Mechanics.CheckField()) {
				if (afterDown == false) reduceAmountMoves(); // уменьшаем количество ходов
				if (Resource.LevelType != "LEVEL_TYPE_TIME"){
					if (Resource.AmountMoves != 0) Mechanics.SimplyRemove(this);
				}else {
					if (Resource.AmountTime != 0) Mechanics.SimplyRemove(this);
				}
			}
			else {
				if (afterDown == false) Mechanics.BackExchangeCrystals(this, _unit1.posColumnI, _unit1.posRowJ, _unit2.posColumnI, _unit2.posRowJ);
				else RecoveryField();
			}
		}
		
		/* Восстановление прежнего состояния (связан с Mechanics) */
		public function RecoveryField():void
		{
			if(Mechanics.CheckCombinations(this)) _unit1 = null; _unit2 = null; _blockedField = false;
		}
		
		/*========================================================================================================================================*/
		
		
		/* Уменьшение количества ходов */
		private function reduceAmountMoves():void 
		{
			if (Resource.AmountMoves > 0) {
				Resource.AmountMoves--;
				_levelPanel.labelGiven.text = "Ходов " + Resource.AmountMoves.toString();
				if (Resource.AmountMoves == 0) reduceAmountMoves();
			}else {
				// КОНЕЦ ИГРЫ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				if (Resource.LevelType == "LEVEL_TYPE_COLLECT" && _AmountCrystals >= Resource.AmountCrystals) { gameResult("WIN"); Resource.LevelComplete++; this.addChild(new LevelDialogResult("WIN")); }
				if (Resource.LevelType == "LEVEL_TYPE_COLLECT" && _AmountCrystals < Resource.AmountCrystals) { gameResult("LOSE"); this.addChild(new LevelDialogResult("LOSE")); }
				if (Resource.LevelType == "LEVEL_TYPE_SCORE_POINTS" && _AmountScore >= Resource.AmountScoreStar1) { gameResult("WIN"); Resource.LevelComplete++; this.addChild(new LevelDialogResult("WIN")); }
				if (Resource.LevelType == "LEVEL_TYPE_SCORE_POINTS" && _AmountScore < Resource.AmountScoreStar1) { gameResult("LOSE"); this.addChild(new LevelDialogResult("LOSE")); }
			}
		}
		
		/* Увеличиваем количество собранных кристалов и очков (связан с Mechanics.SimplyRemove)*/
		public function CollectAmountCrystalsAndScore(crystalID:String):void
		{
			if(Resource.CrystalType == crystalID || Resource.CrystalType == "CRYSTAL_TYPE_ALL") _AmountCrystals++;
			_AmountScore += 30;
			_levelPanel.labelScore.text = "Очки: " + _AmountScore.toString();
			if (Resource.LevelType == "LEVEL_TYPE_COLLECT") _levelPanel.labelQuest.text = _textQuest + ". Собрано " + _AmountCrystals + " из " + Resource.AmountCrystals.toString() + _textTypeCrystal;
			if (Resource.LevelType == "LEVEL_TYPE_SCORE_POINTS") _levelPanel.labelQuest.text  = _textQuest + ". Набрано " + _AmountScore + " из " + Resource.AmountScoreStar1.toString();
		}
		
		/* Таймер =========================================================================*/
		public function timer():void
		{
			var countTime:int = Resource.AmountTime;
			_timer = new Timer(1000, countTime);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
            _timer.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
            _timer.start();
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			if (Resource.LevelType == "LEVEL_TYPE_TIME") {
				Resource.AmountTime--;
				_levelPanel.labelGiven.text = "Секунд " + Resource.AmountTime.toString()
			}
		}

		private function completeHandler(e:TimerEvent):void
		{
			if (Resource.LevelType == "LEVEL_TYPE_TIME" && _AmountScore >= Resource.AmountScoreStar1) { gameResult("WIN"); Resource.LevelComplete++; this.addChild(new LevelDialogResult("WIN")); }
			if (Resource.LevelType == "LEVEL_TYPE_TIME" && _AmountScore < Resource.AmountScoreStar1) { gameResult("LOSE"); this.addChild(new LevelDialogResult("LOSE")); }
		} 
		
		private function onRemoveFromStage(e:Event):void 
		{
			if (Resource.LevelType == "LEVEL_TYPE_TIME") _timer.stop();
		}
		/* ==================================================================================== */
		
		/* Получить описание задания*/
		private function getTextQuest(id:String):String
		{
			if (id == "LEVEL_TYPE_COLLECT") return "Задание: Собрать кристалы";
			if (id == "LEVEL_TYPE_SCORE_POINTS") return "Задание: Набрать очки";
			if (id == "LEVEL_TYPE_TIME") return "Задание: Успеть за время";
			return "";
		}
		
		/* Получить описание типа кристала для задания собрать кристалы */
		private function getTextTypeCrystal(id:String):String
		{
			if (id == "CRYSTAL_TYPE_ALL") return " любого цвета.";
			if (id == "CRYSTAL_TYPE_1_VIOLET") return " фиолетового цвета.";
			if (id == "CRYSTAL_TYPE_2_GREEN") return " зеленого цвета.";
			if (id == "CRYSTAL_TYPE_3_RED") return " красного цвета.";
			if (id == "CRYSTAL_TYPE_4_BLUE") return " синего цвета.";
			if (id == "CRYSTAL_TYPE_5_YELLOW") return " желтого цвета.";
			return "";
		}
		
		/* Сохранение результата игры */
		private function gameResult(status:String):void
		{
			// Расчет очков на 1, 2, 3 звезды
			if (_AmountScore < Resource.AmountScoreStar1)Resource.Progress[Resource.SelectLevel][1] = _AmountScore;
			else {
				if (_AmountScore >= Resource.AmountScoreStar1) Resource.Progress[Resource.SelectLevel][1] = Resource.AmountScoreStar1;
				else Resource.Progress[Resource.SelectLevel][1] = _AmountScore;
				if (_AmountScore >= Resource.AmountScoreStar2) Resource.Progress[Resource.SelectLevel][2] = Resource.AmountScoreStar2;
				else Resource.Progress[Resource.SelectLevel][2] = _AmountScore;
				if (_AmountScore >= Resource.AmountScoreStar3) Resource.Progress[Resource.SelectLevel][3] = _AmountScore;
				else Resource.Progress[Resource.SelectLevel][3] = _AmountScore;
			}
			// Очки за уровень
			Resource.Progress[Resource.SelectLevel][4]= _AmountScore;
			// Результат уровня
			if (status == "WIN")Resource.Progress[Resource.SelectLevel][5] = 1;
			else Resource.Progress[Resource.SelectLevel][5] = 0;
		}
		
		/* Анимация звезд */
		public function StarsAnimation(_x:int, _y:int):void
		{
			var stars:Stars = new Stars();
			stars.x = _x; stars.y = _y;
			this.addChild(stars);
		}
		
		private function onClick(e:Event):void
		{
			if ((e.target as Button).name == "exit") {
				//this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "LEVEL_EXIT" }, true));
				gameResult("LOSE");
				this.addChild(new LevelDialogResult("EXIT"));
			}
		}
	}

}
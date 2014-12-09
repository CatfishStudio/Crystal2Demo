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
	
	import Crystal2.assets.resource.Resource;
	import Crystal2.assets.events.NavigationEvent;
	import Crystal2.assets.animation.Quest;
	import Crystal2.assets.kernel.Mechanics;
	import Crystal2.assets.units.Cell;
	import Crystal2.assets.units.Unit;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Level extends Sprite 
	{
		private var _xmlLevel:XML;
		
		
		/* Обработка объектов игрового поля */
		private var _clickObject:Boolean = false; 	// флаг нажатия на объект
		
		
		
		
		public function Level() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.TRIGGERED, onClick);
			
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
			if (Resource.LevelType == "LEVEL_TYPE_COLLECT") this.addChild(new Quest("Задание: Собрать кристалы."));
			if (Resource.LevelType == "LEVEL_TYPE_SCORE_POINTS") this.addChild(new Quest("Задание: Набрать очки."));
			if (Resource.LevelType == "LEVEL_TYPE_TIME") this.addChild(new Quest("Задание: Успеть за время."));
			
		
		}
		
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
			Resource.AmountMoves - _xmlLevel.AmountMoves;
			
			
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
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posX = 165 + (Resource.CELL_WIDTH * iUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posY = 70 + (Resource.CELL_HEIGHT * jUnit);
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
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posX = 165 + (Resource.CELL_WIDTH * iUnit);
						(Resource.MatrixUnit[iUnit][jUnit] as Unit).posY = 70 + (Resource.CELL_HEIGHT * jUnit);
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
		
		private function onButtonTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					trace( ((e.target as Image).parent as Unit).unitType );
					// при нажатии
					trace("ПОЗИЦИЯ(i-колонка):" + ((e.target as Image).parent as Unit).posColumnI.toString() + "  ПОЗИЦИЯ(j-строка):" + ((e.target as Image).parent as Unit).posRowJ.toString());
					trace("ПОЗИЦИЯ(X):" + ((e.target as Image).parent as Unit).x.toString() + "  ПОЗИЦИЯ(Y):" + ((e.target as Image).parent as Unit).y.toString());
					trace("ПОЗИЦИЯ(posX):" + ((e.target as Image).parent as Unit).posX.toString() + "  ПОЗИЦИЯ(posY):" + ((e.target as Image).parent as Unit).posY.toString());
					trace("ИМЯ:" + ((e.target as Image).parent as Unit).unitType);
					_clickObject = true; // флаг - объект нажат
				}
				else if (touch.phase == TouchPhase.ENDED)
				{
					_clickObject = false; // флаг - объект не нажат
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
		
		
		private function onClick(e:Event):void
		{
			
		}
	}

}
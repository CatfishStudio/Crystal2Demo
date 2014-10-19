package Crystal.kernel 
{
	import Crystal.level.Level;
	import Crystal.units.Cell;
	import Crystal.units.Unit;
	import Crystal.resource.Resource;
	import Crystal.animation.Stars;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class Mechanics 
	{
		/* Генератор случайный число */
		public static function RandomIndex():int
		{
			var indexRandom:Number = Math.random() * 10;
			var index:int = Math.round(indexRandom);
			if (index > 0 && index <= 2) return 1;
			if (index > 2 && index <= 4) return 2;
			if (index > 4 && index <= 6) return 3;
			if (index > 6 && index <= 8) return 4;
			if (index > 8 && index <= 10) return 5;
			return 1;
		}
		
		/* Создание 2D массива тип Array */
		public static function CreateCellArrayMatrix2D(_columns:uint, _rows:uint):Array
		{
			/* i - столбец; j - строка */
			var newArray:Array = [];
			var unitAdd:Cell = new Cell();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Array = [];
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(unitAdd);
				}
				newArray.push(newRow);
			}
			return newArray;
		}
		
		public static function CreateUnitArrayMatrix2D(_columns:uint, _rows:uint):Array
		{
			/* i - столбец; j - строка */
			var newArray:Array = [];
			var unitAdd:Unit = new Unit();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Array = [];
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(unitAdd);
				}
				newArray.push(newRow);
			}
			return newArray;
		}
		
		/* Создание 2D массива тип Vector */
		public static function CreateCellVectorMatrix2D(_columns:uint, _rows:uint):Vector.<Vector.<Cell>>
		{
			var _matrixCell:Vector.<Vector.<Cell>> = new Vector.<Vector.<Cell>>();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Vector.<Cell> = new Vector.<Cell>();
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(new Cell());
				}
				_matrixCell.push(newRow);
			}
			return _matrixCell;
		}
		
		public static function CreateUnitVectorMatrix2D(_columns:uint, _rows:uint):Vector.<Vector.<Unit>>
		{
			var _matrixCell:Vector.<Vector.<Unit>> = new Vector.<Vector.<Unit>>();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Vector.<Unit> = new Vector.<Unit>();
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(new Unit());
				}
				_matrixCell.push(newRow);
			}
			return _matrixCell;
		}
		
		
		/* Проверка строка (3-и и более в ряд) */
		public static function CheckRow(row:int):Boolean
		{
			var resultCheck:Boolean = false;
			/* просматриваем кристалы в строке (по столбцам) */
			for (var i:int = 0; i < Resource.COLUMNS; i++) {
				if (i < Resource.COLUMNS - 2) {	// < 8
					if((Resource.MatrixUnit[i][row] as Unit).unitType != "CELL_TYPE_EMPTY"){
					/* Группа из 3-х кристалов */
					if (Resource.MatrixUnit[i][row].unitType == Resource.MatrixUnit[i + 1][row].unitType && Resource.MatrixUnit[i][row].unitType == Resource.MatrixUnit[i + 2][row].unitType) {
						/*Отмечаем кристалы для удаления */
						resultCheck = true;
						(Resource.MatrixUnit[i][row] as Unit).flagRemove = true;
						(Resource.MatrixUnit[i+1][row] as Unit).flagRemove = true;
						(Resource.MatrixUnit[i+2][row] as Unit).flagRemove = true;
						//(Resource.MatrixUnit[i][row] as Unit).alpha = 0.2;
						//(Resource.MatrixUnit[i+1][row] as Unit).alpha = 0.2;
						//(Resource.MatrixUnit[i+2][row] as Unit).alpha = 0.2;
						
						/* Группа из 4-х кристалов */
						if (i < Resource.COLUMNS - 3) { // < 7
							if (Resource.MatrixUnit[i][row].unitType == Resource.MatrixUnit[i + 3][row].unitType) {
								/*Отмечаем кристалы для модификации и удаления */
								if(i != 0){
									if ((Resource.MatrixUnit[i][row] as Unit).typeModification < 5 && (Resource.MatrixUnit[i - 1][row] as Unit).flagModification == false) {
										(Resource.MatrixUnit[i][row] as Unit).flagModification = true;
										(Resource.MatrixUnit[i][row] as Unit).typeModification = 41;
									}
								}
								(Resource.MatrixUnit[i + 3][row] as Unit).flagRemove = true;
								//(Resource.MatrixUnit[i+3][row] as Unit).alpha = 0.2;
								
								/* Группа из 5-ти кристалов */
								if (i < Resource.COLUMNS - 4) {	// < 6
									if (Resource.MatrixUnit[i][row].unitType == Resource.MatrixUnit[i + 4][row].unitType) {
										/*Отмечаем кристалы для модификации и удаления */
										(Resource.MatrixUnit[i][row] as Unit).flagModification = true;
										(Resource.MatrixUnit[i][row] as Unit).typeModification = 5;
										(Resource.MatrixUnit[i + 4][row] as Unit).flagRemove = true;
										//(Resource.MatrixUnit[i+4][row] as Unit).alpha = 0.2;
								
									}
								}
							}
						}
					}
					}
				}else break;
			}
			return resultCheck;
		}
		
		/* Проверка колонки (3-и и более в ряд) */
		public static function CheckColumn(column:int):Boolean
		{
			var resultCheck:Boolean = false;
			/* просматриваем кристалы в столбце (по строкам) */
			for (var j:int = 0; j < Resource.ROWS; j++) {
				if (j < Resource.ROWS - 2) {	// < 8
					if((Resource.MatrixUnit[column][j] as Unit).unitType != "CELL_TYPE_EMPTY"){
					/* Группа из 3-х кристалов */
					if (Resource.MatrixUnit[column][j].unitType == Resource.MatrixUnit[column][j+1].unitType && Resource.MatrixUnit[column][j].unitType == Resource.MatrixUnit[column][j+2].unitType) {
						/*Отмечаем кристалы для удаления */
						resultCheck = true;
						(Resource.MatrixUnit[column][j] as Unit).flagRemove = true;
						(Resource.MatrixUnit[column][j+1] as Unit).flagRemove = true;
						(Resource.MatrixUnit[column][j+2] as Unit).flagRemove = true;
						//(Resource.MatrixUnit[column][j] as Unit).alpha = 0.2;
						//(Resource.MatrixUnit[column][j+1] as Unit).alpha = 0.2;
						//(Resource.MatrixUnit[column][j+2] as Unit).alpha = 0.2;
						
						/* Группа из 4-х кристалов */
						if (j < Resource.ROWS - 3) { // < 7
							if (Resource.MatrixUnit[column][j].unitType == Resource.MatrixUnit[column][j+3].unitType) {
								/*Отмечаем кристалы для модификации и удаления */
								if (j != 0) {
									if ((Resource.MatrixUnit[column][j] as Unit).typeModification < 5 && (Resource.MatrixUnit[column][j - 1] as Unit).flagModification != false) {
										(Resource.MatrixUnit[column][j] as Unit).flagModification = true;
										(Resource.MatrixUnit[column][j] as Unit).typeModification = 42;
									}
								}
								(Resource.MatrixUnit[column][j+3] as Unit).flagRemove = true;
								//(Resource.MatrixUnit[column][j+3] as Unit).alpha = 0.2;
								
								/* Группа из 5-ти кристалов */
								if (j < Resource.ROWS - 4) {	// < 6
									if (Resource.MatrixUnit[column][j].unitType == Resource.MatrixUnit[column][j+4].unitType) {
										/*Отмечаем кристалы для модификации и удаления */
										(Resource.MatrixUnit[column][j] as Unit).flagModification = true;
										(Resource.MatrixUnit[column][j] as Unit).typeModification = 5;
										(Resource.MatrixUnit[column][j+4] as Unit).flagRemove = true;
										//(Resource.MatrixUnit[column][j+4] as Unit).alpha = 0.2;
								
									}
								}
							}
						}
					}
					}
				}else break;
			}
			
			return resultCheck;
		}
		
		/* Общая проверка колонок и строк (3-и и более в ряд) */
		public static function CheckField():Boolean
		{
			var resultCheck:Boolean = false;
			/* i - столбец; j - строка */
			for (var i:int = 0; i < Resource.COLUMNS; i++) {
				if (CheckColumn(i) == true) resultCheck = true;
				for (var j:int = 0; j < Resource.ROWS; j++) {
					if (CheckRow(j) == true) resultCheck = true;
				}
			}
			return resultCheck;
		}
		
		/* Обмен местами в массиве выбранных пользователем кристалов  */
		public static function ExchangeCrystals(columnCrystal1:int, rowCrystal1:int, columnCrystal2:int, rowCrystal2:int):void
		{
			var crystalMove:Unit = new Unit();
			crystalMove = Resource.MatrixUnit[columnCrystal1][rowCrystal1];
			Resource.MatrixUnit[columnCrystal1][rowCrystal1] = Resource.MatrixUnit[columnCrystal2][rowCrystal2];
			Resource.MatrixUnit[columnCrystal2][rowCrystal2] = crystalMove;
			
			(Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).posColumnI = columnCrystal1;
			(Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).posRowJ = rowCrystal1;
			(Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).posColumnI = columnCrystal2;
			(Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).posRowJ = rowCrystal2;
		}
		
		/* Удаление на поле всех отмеченных ячеек (Удаление, сортировка, добавление */
		public static function SimplyRemove(level:MovieClip):void
		{
			/* Уменьшение ходов на уровне */
			(level as Level).ReductionMoves();
			
			for (var i:int = 0; i < Resource.COLUMNS; i++) { /* i - столбецы (обработка слева на право) */
				var matrixUnits:Vector.<Unit> = new Vector.<Unit>();
				/* Удаление помеченных кристалов */
				for (var j1:int = Resource.ROWS - 1; j1 >= 0; j1--) {	// 9
					
					/* Модификация */
					if ((Resource.MatrixUnit[i][j1] as Unit).flagModification == true) {	// модификация кристала
						level.addChild(new Stars((Resource.MatrixUnit[i][j1] as Unit).x, (Resource.MatrixUnit[i][j1] as Unit).y)); // анимация звезд
						(Resource.MatrixUnit[i][j1] as Unit).Modification();	// модификацияобъекта (визуальное изменение)
						/* Прогресс уровня (тип уровня ([собрать кристалы], [набрать очки], [спустить объект], [на время])*/
						if ((Resource.MatrixUnit[i][j1] as Unit).typeModification == 5) (level as Level).Progress(240);
						if ((Resource.MatrixUnit[i][j1] as Unit).typeModification > 5) (level as Level).Progress(160);
					}
					
					/* Удаление */
					if ((Resource.MatrixUnit[i][j1] as Unit).flagRemove == true && (Resource.MatrixUnit[i][j1] as Unit).flagModification == false) {	// удаление кристала
						/* анимация звезд */
						level.addChild(new Stars((Resource.MatrixUnit[i][j1] as Unit).x, (Resource.MatrixUnit[i][j1] as Unit).y));
						/* Удаление объект с поля */
						level.removeChild(Resource.MatrixUnit[i][j1]);
						/* Удаляем в главном массиве */
						Resource.MatrixUnit[i].pop(); // Удаляем из главного массива
						/* Прогресс уровня (тип уровня ([собрать кристалы], [набрать очки], [спустить объект], [на время])*/
						(level as Level).Progress(60);
					}else {
						/* Сохраняем кристал в промежуточный массив */
						matrixUnits.push((Resource.MatrixUnit[i][j1] as Unit));
						/* Удаляем в главном массиве */
						Resource.MatrixUnit[i].pop(); // Удаляем из массива
					}
				}
				
				/* Возвращаем оставщиеся кристалы в массив игрового поля и добавляем новые */
				var indexJ:int = 0;
				for (var j2:int = Resource.ROWS - 1; j2 >= 0; j2--) {	// 9
					if (matrixUnits.length > j2) {
						/* Перемещение кристала в массиве */
						(matrixUnits[j2] as Unit).posRowJ = indexJ;		// изменяем индекс положения в строке
						(matrixUnits[j2] as Unit).posY = 76 + (50 * indexJ); // перерасчет позиции
						Resource.MatrixUnit[i].push(matrixUnits[j2]); 	// Переносим (добавляем) в массив
					}else {
						/* Добавление новых объектов в массив и на поле */
						var newUnit:Unit = new Unit();
						newUnit.x = 200 + (50 * i);
						newUnit.y = 56 + (50 * 0);	// начальная позиция для нового объекта
						newUnit.posColumnI = i;
						newUnit.posRowJ = indexJ;
						newUnit.posX = newUnit.x;
						newUnit.posY = 76 + (50 * indexJ);
						var type:int = RandomIndex();
						if (type == 1) newUnit.unitType = "CRYSTAL_TYPE_1_VIOLET";
						if (type == 2) newUnit.unitType = "CRYSTAL_TYPE_2_GREEN";
						if (type == 3) newUnit.unitType = "CRYSTAL_TYPE_3_RED";
						if (type == 4) newUnit.unitType = "CRYSTAL_TYPE_4_BLUE";
						if (type == 5) newUnit.unitType = "CRYSTAL_TYPE_5_YELLOW";
						/*события*/
						newUnit.addEventListener(MouseEvent.CLICK, (level as Level).onMouseUnitClick);
						newUnit.addEventListener(MouseEvent.MOUSE_DOWN, (level as Level).onMouseUnitDown);
						newUnit.addEventListener(MouseEvent.MOUSE_UP, (level as Level).onMouseUnitUp);
						newUnit.addEventListener(MouseEvent.MOUSE_MOVE, (level as Level).onMouseUnitMove);
						newUnit.addEventListener(MouseEvent.MOUSE_OUT, (level as Level).onMouseUnitOut);
						newUnit.addEventListener(MouseEvent.MOUSE_OVER, (level as Level).onMouseUnitOver);
					
						Resource.MatrixUnit[i].push(newUnit);
						(level as Level).addChild(Resource.MatrixUnit[i][indexJ]);
					}
					indexJ++;
				}
				
			}
			
			/* Вызываем функцию спуска */
			(level as Level).addEventListener(Event.ENTER_FRAME, (level as Level).AnimationMoveDown);
			(level as Level).play();
			
		}
		
		public static function DifficultRemove(level:MovieClip):Boolean
		{
			var resultCheck:Boolean = false;
			/* Уменьшение ходов на уровне */
			(level as Level).ReductionMoves();
			
			for (var i:int = 0; i < Resource.COLUMNS; i++) { /* i - столбецы (обработка слева на право) */
				var matrixUnits:Vector.<Unit> = new Vector.<Unit>();
			
				/* Удаление помеченных кристалов */
				for (var j1:int = Resource.ROWS - 1; j1 >= 0; j1--) {	// 9
					
					if ((Resource.MatrixUnit[i][j1] as Unit).flagModification == true) {	// модификация кристала
						level.addChild(new Stars((Resource.MatrixUnit[i][j1] as Unit).x, (Resource.MatrixUnit[i][j1] as Unit).y)); // анимация звезд
						(Resource.MatrixUnit[i][j1] as Unit).Modification();	// модификацияобъекта (визуальное изменение)
						/* Прогресс уровня (тип уровня ([собрать кристалы], [набрать очки], [спустить объект], [на время])*/
						if ((Resource.MatrixUnit[i][j1] as Unit).typeModification == 5) (level as Level).Progress(240);
						if ((Resource.MatrixUnit[i][j1] as Unit).typeModification > 5) (level as Level).Progress(160);
					}
					
					if ((Resource.MatrixUnit[i][j1] as Unit).flagRemove == true && (Resource.MatrixUnit[i][j1] as Unit).flagModification == false) {	// удаление кристала
						/* анимация звезд */
						level.addChild(new Stars((Resource.MatrixUnit[i][j1] as Unit).x, (Resource.MatrixUnit[i][j1] as Unit).y));
						/* Удаление объект с поля */
						level.removeChild(Resource.MatrixUnit[i][j1]);
						/* Удаляем в массиве */
						Resource.MatrixUnit[i].pop(); // Удаляем из массива
						/* Прогресс уровня (тип уровня ([собрать кристалы], [набрать очки], [спустить объект], [на время])*/
						(level as Level).Progress(60);
						/* Определяем возвращаемое значение данной функцией */
						resultCheck = true;
					} else { /* НЕ УДАЛЯЕМ. (ПЕРЕНОСИМ В МАССИВЕ НА СВОБОДНОЕ МЕСТО) */
						if ((Resource.MatrixCell[i][j1] as Cell).cellType != "CELL_TYPE_EMPTY") { // ПУСТОТА
							if ((Resource.MatrixUnit[i][j1] as Unit).unitType != "CRYSTAL_TYPE_9_STONE") { // ПРЕГРАДА
								/* Проверка свободных мест */
								
								//???????????????
								
								/* Сохраняем кристал в промежуточный массив */
								matrixUnits.push((Resource.MatrixUnit[i][j1] as Unit));
								/* Удаляем в массиве */
								Resource.MatrixUnit[i].pop(); // Удаляем из массива
							}
						}
						
						
						
					}
				}
				
				/* Возвращаем оставщиеся кристалы в массив игрового поля и добавляем новые */
				for (var j2:int = Resource.ROWS - 1; j2 >= 0; j2--) {	// 9
					if (matrixUnits.length > j2) {
						/* Перемещение кристала в массиве */
						Resource.MatrixUnit[i].push(matrixUnits[j2]); // Переносим (добавляем) в массив
					}else {
						/* Добавление новых объектов в массив и на поле */
						
						//???????????????
					}
				}
				
			}
			return resultCheck;
		}
		
		
		
		/* Коректировка Индексов каждого кристала в массиве */
		public static function Correction():void
		{
			for (var col:int = 0; col < Resource.COLUMNS; col++){
				for (var row:int = 0; row < Resource.ROWS; row++) {
					(Resource.MatrixUnit[col][row]as Unit).posColumnI = col;
					(Resource.MatrixUnit[col][row]as Unit).posRowJ = row;
					(Resource.MatrixUnit[col][row]as Unit).posX = (Resource.MatrixUnit[col][row]as Unit).x;
					(Resource.MatrixUnit[col][row]as Unit).posY = (Resource.MatrixUnit[col][row]as Unit).y;
					(Resource.MatrixUnit[col][row]as Unit).flagRemove = false;
					(Resource.MatrixUnit[col][row]as Unit).flagModification = false;
					(Resource.MatrixUnit[col][row]as Unit).typeModification = 0;
				}
			}
		}
		
		
	}

}
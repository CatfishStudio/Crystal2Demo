package Crystal2.assets.kernel 
{
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	import Crystal2.assets.units.Cell;
	import Crystal2.assets.units.Unit;
	import Crystal2.assets.resource.Resource;
	import Crystal2.assets.level.Level;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Mechanics 
	{
		
		/* Генератор случайный число =================================================================== */
		public static function RandomIndex():int
		{
			var indexRandom:Number = Math.random() * 10;
			var index:int = Math.round(indexRandom);
			return index;
		}
		/* ============================================================================================ */
		
		/* Создание 2D массива тип Vector ============================================================== */
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
		/* ============================================================================================ */
		
		/* Инициализация массива прогресса =============================================================*/
		public static function InitProgress(_line:uint):Vector.<Vector.<int>>
		{
			var _matrixProgress:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
			var _indexLevel:int = 1;
			
			for (var i:uint = 0; i < _line; i++) {
				var newRow:Vector.<int> = new Vector.<int>();
				newRow.push(_indexLevel); 	// номер уровня
				newRow.push(0);				// очки за одну звезду
				newRow.push(0);				// очки за две звезды
				newRow.push(0);				// очки за три звезды
				newRow.push(0);				// флаг пройденного уровня (0 - не пройден, 1 - пройден)
				_matrixProgress.push(newRow);
				_indexLevel++;
			}
			return _matrixProgress;
		}
		/* ============================================================================================ */
		
		/* Обмен местами в массиве выбранных пользователем  объектов ===================================*/
		public static function ExchangeCrystals(level:Level, columnCrystal1:int, rowCrystal1:int, columnCrystal2:int, rowCrystal2:int):void
		{
			var crystalMove:Unit = new Unit();
			crystalMove = Resource.MatrixUnit[columnCrystal1][rowCrystal1];
			Resource.MatrixUnit[columnCrystal1][rowCrystal1] = Resource.MatrixUnit[columnCrystal2][rowCrystal2];
			Resource.MatrixUnit[columnCrystal2][rowCrystal2] = crystalMove;
			(Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).posColumnI = columnCrystal1;
			(Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).posRowJ = rowCrystal1;
			(Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).posColumnI = columnCrystal2;
			(Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).posRowJ = rowCrystal2;
			
			var _tweenUnit1:Tween = new Tween((Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit), 0.5);
			var _tweenUnit2:Tween = new Tween((Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit), 0.5);
			var unit1Complite:Boolean = false;
			var unit2Complite:Boolean = false;
			
			_tweenUnit1.moveTo((Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).x, (Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).y);
			_tweenUnit1.onComplete = function():void { unit1Complite = true; if (unit1Complite && unit2Complite) level.CheckField(false); };
			Starling.juggler.add(_tweenUnit1);
			
			_tweenUnit2.moveTo((Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).x, (Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).y);
			_tweenUnit2.onComplete = function():void { unit2Complite = true; if (unit1Complite && unit2Complite) level.CheckField(false); };
			Starling.juggler.add(_tweenUnit2);
		}
		
		public static function BackExchangeCrystals(level:Level, columnCrystal1:int, rowCrystal1:int, columnCrystal2:int, rowCrystal2:int):void
		{
			var crystalMove:Unit = new Unit();
			crystalMove = Resource.MatrixUnit[columnCrystal1][rowCrystal1];
			Resource.MatrixUnit[columnCrystal1][rowCrystal1] = Resource.MatrixUnit[columnCrystal2][rowCrystal2];
			Resource.MatrixUnit[columnCrystal2][rowCrystal2] = crystalMove;
			(Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).posColumnI = columnCrystal1;
			(Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).posRowJ = rowCrystal1;
			(Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).posColumnI = columnCrystal2;
			(Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).posRowJ = rowCrystal2;
			
			var _tweenUnit1:Tween = new Tween((Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit), 0.5);
			var _tweenUnit2:Tween = new Tween((Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit), 0.5);
			var unit1Complite:Boolean = false;
			var unit2Complite:Boolean = false;
			
			_tweenUnit1.moveTo((Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).x, (Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).y);
			_tweenUnit1.onComplete = function():void { unit1Complite = true; if (unit1Complite && unit2Complite) level.RecoveryField(); };
			Starling.juggler.add(_tweenUnit1);
			
			_tweenUnit2.moveTo((Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).x, (Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).y);
			_tweenUnit2.onComplete = function():void { unit2Complite = true; if (unit1Complite && unit2Complite) level.RecoveryField(); };
			Starling.juggler.add(_tweenUnit2);
		}
		/* ============================================================================================ */
		
		/* Поиск групп после действия пользователя =====================================================*/
		/* Проверка строка (3-и и более в ряд) */
		public static function CheckRow(row:int):Boolean
		{
			var resultCheck:Boolean = false;
			/* просматриваем в строке (по столбцам) */
			for (var i:int = 0; i < Resource.COLUMNS; i++) {
				if (i < Resource.COLUMNS - 2) {
					if ((Resource.MatrixUnit[i][row] as Unit).unitType != "CRYSTAL_TYPE_0") {
						
					/* Группа из 3-х объектов */
					if (Resource.MatrixUnit[i][row].unitType == Resource.MatrixUnit[i + 1][row].unitType && Resource.MatrixUnit[i][row].unitType == Resource.MatrixUnit[i + 2][row].unitType) {
						/*Отмечаем кристалы для удаления */
						resultCheck = true;
						(Resource.MatrixUnit[i][row] as Unit).flagRemove = true;
						(Resource.MatrixUnit[i+1][row] as Unit).flagRemove = true;
						(Resource.MatrixUnit[i+2][row] as Unit).flagRemove = true;
						(Resource.MatrixUnit[i][row] as Unit).alpha = 0.2;
						(Resource.MatrixUnit[i+1][row] as Unit).alpha = 0.2;
						(Resource.MatrixUnit[i+2][row] as Unit).alpha = 0.2;
						
						/* Группа из 4-х кристалов */
						if (i < Resource.COLUMNS - 3) {
							if (Resource.MatrixUnit[i][row].unitType == Resource.MatrixUnit[i + 3][row].unitType) {
								(Resource.MatrixUnit[i + 3][row] as Unit).flagRemove = true;
								(Resource.MatrixUnit[i+3][row] as Unit).alpha = 0.2;
								
								/* Группа из 5-ти кристалов */
								if (i < Resource.COLUMNS - 4) {
									if (Resource.MatrixUnit[i][row].unitType == Resource.MatrixUnit[i + 4][row].unitType) {
										/*Отмечаем кристалы для модификации и удаления */
										(Resource.MatrixUnit[i + 4][row] as Unit).flagRemove = true;
										(Resource.MatrixUnit[i+4][row] as Unit).alpha = 0.2;
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
			/* просматриваем  в столбце (по строкам) */
			for (var j:int = 0; j < Resource.ROWS; j++) {
				if (j < Resource.ROWS - 2) {
					if((Resource.MatrixUnit[column][j] as Unit).unitType != "CRYSTAL_TYPE_0"){
						/* Группа из 3-х объектов */
						if (Resource.MatrixUnit[column][j].unitType == Resource.MatrixUnit[column][j+1].unitType && Resource.MatrixUnit[column][j].unitType == Resource.MatrixUnit[column][j+2].unitType) {
							/*Отмечаем кристалы для удаления */
							resultCheck = true;
							(Resource.MatrixUnit[column][j] as Unit).flagRemove = true;
							(Resource.MatrixUnit[column][j+1] as Unit).flagRemove = true;
							(Resource.MatrixUnit[column][j+2] as Unit).flagRemove = true;
							(Resource.MatrixUnit[column][j] as Unit).alpha = 0.2;
							(Resource.MatrixUnit[column][j+1] as Unit).alpha = 0.2;
							(Resource.MatrixUnit[column][j+2] as Unit).alpha = 0.2;
						
							/* Группа из 4-х кристалов */
							if (j < Resource.ROWS - 3) {
								if (Resource.MatrixUnit[column][j].unitType == Resource.MatrixUnit[column][j+3].unitType) {
									(Resource.MatrixUnit[column][j+3] as Unit).flagRemove = true;
									(Resource.MatrixUnit[column][j+3] as Unit).alpha = 0.2;
								
									/* Группа из 5-ти кристалов */
									if (j < Resource.ROWS - 4) {	// < 6
										if (Resource.MatrixUnit[column][j].unitType == Resource.MatrixUnit[column][j+4].unitType) {
											(Resource.MatrixUnit[column][j+4] as Unit).flagRemove = true;
											(Resource.MatrixUnit[column][j+4] as Unit).alpha = 0.2;
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
		/* ============================================================================================ */
		
		/* Удаление на поле всех отмеченных ячеек (Удаление, сортировка, добавление ====================*/
		public static function SimplyRemove(level:Level):void
		{
			for (var i:int = 0; i < Resource.COLUMNS; i++) { /* i - столбецы (обработка слева на право) */
				var matrixUnits:Vector.<Unit> = new Vector.<Unit>(); // массив юнитов сохраняемых на поле
				var matrixEmpty:Vector.<Unit> = new Vector.<Unit>(); // массив пустот сохраняемых на поле
				var matrixAll:Vector.<Unit> = new Vector.<Unit>(); // массив всех эдементов игрового поля (после слияния и добавления)
				
				/* Удаление помеченных кристалов ---------------------------------------------------------------------------------*/
				for (var j1:int = Resource.ROWS - 1; j1 >= 0; j1--) {
					
					/* Удаление */
					if ((Resource.MatrixUnit[i][j1] as Unit).flagRemove == true && (Resource.MatrixUnit[i][j1] as Unit).unitType != "CRYSTAL_TYPE_0") {	// удаление 
						/* анимация вспышки */
						//////////////////////level.addChild(new Flash((Resource.MatrixUnit[i][j1] as Unit).x - 50, (Resource.MatrixUnit[i][j1] as Unit).y - 30));
						/* Увеличиваем количество собранных кристалов и очков */
						level.CollectAmountCrystalsAndScore((Resource.MatrixUnit[i][j1] as Unit).unitType);
						/* Удаление объект с поля */
						level.removeChild(Resource.MatrixUnit[i][j1]);
						/* Удаляем в главном массиве */
						Resource.MatrixUnit[i].pop(); // Удаляем из главного массива
						
					}else {
						/* Проверка пустота или нет */
						if ((Resource.MatrixUnit[i][j1] as Unit).unitType == "CRYSTAL_TYPE_0") { // CRYSTAL_TYPE_0 - пустота
							
							/* переносим пустоту в промежуточный массив */
							matrixEmpty.push((Resource.MatrixUnit[i][j1] as Unit));
							/* Удаляем в главном массиве */
							Resource.MatrixUnit[i].pop(); // Удаляем из массива
								
						}else { // не пустота
							
							/* Сохраняем удар в промежуточный массив */
							matrixUnits.push((Resource.MatrixUnit[i][j1] as Unit));
							/* Удаляем в главном массиве */
							Resource.MatrixUnit[i].pop(); // Удаляем из массива
							
						}
					}
				}
				/*---------------------------------------------------------------------------------------------------------------*/
				
				
				/* Слияние двух массивов и добавление новых объектов -------------------------------------------------------------*/
				var totalRows:int = matrixUnits.length + matrixEmpty.length;
				if (totalRows == Resource.ROWS) { // слияние без добавлений ----------
					for (var iTotal:int = Resource.ROWS - 1; iTotal >= 0; iTotal--) {
						if (matrixEmpty.length > 0){ // пустоты
							if ((matrixEmpty[0] as Unit).posRowJ == iTotal) {
								matrixAll.push(matrixEmpty[0]); // переносим
								matrixEmpty.shift(); // удаляем
							}
						}
						if (matrixUnits.length > 0) { // объекты
							if ((matrixUnits[0] as Unit).posRowJ == iTotal) {
								matrixAll.push(matrixUnits[0]); // переносим
								matrixUnits.shift(); // удаляем
							}
						}
					}
				}else { // слияние с добавлением -------------------------------------
					for (var iAdd:int = Resource.ROWS - 1; iAdd >= 0; iAdd--) {
						if (matrixEmpty.length > 0){ // пустоты
							if ((matrixEmpty[0] as Unit).posRowJ == iAdd) {
								matrixAll.push(matrixEmpty[0]); // переносим
								matrixEmpty.shift(); // удаляем
							}else { // в пустоте не найдено
								if (matrixUnits.length > 0) { // объекты
									if ((matrixUnits[0] as Unit).posRowJ == iAdd) {
										matrixAll.push(matrixUnits[0]); // переносим
										matrixUnits.shift(); // удаляем
									}else { // переносим объект вниз
										(matrixUnits[0] as Unit).posRowJ = iAdd;		// изменяем индекс положения в строке
										matrixAll.push(matrixUnits[0]); // переносим
										AnimationMoveDown((matrixUnits[0] as Unit), (matrixUnits[0] as Unit).x, (70 + (50 * iAdd)), level);
										matrixUnits.shift(); // удаляем
									}
								}else { // создаём новый объект
							
									/* Добавление новых объектов в массив и на поле */
									var newUnit1:Unit = new Unit();
									newUnit1.x = 165 + (50 * i);
									newUnit1.y = 0 + (50 * 0);	// начальная позиция для нового объекта
									newUnit1.posColumnI = i;
									newUnit1.posRowJ = iAdd;
									
									var type1:int = RandomIndex();
									if (type1 >= 0 && type1 < 2) newUnit1.unitType = "CRYSTAL_TYPE_1_VIOLET";
									if (type1 >= 2 && type1 < 4) newUnit1.unitType = "CRYSTAL_TYPE_2_GREEN";
									if (type1 >= 4 && type1 < 6) newUnit1.unitType = "CRYSTAL_TYPE_3_RED";
									if (type1 >= 6 && type1 < 8) newUnit1.unitType = "CRYSTAL_TYPE_4_BLUE";
									if (type1 >= 8 && type1 <= 10) newUnit1.unitType = "CRYSTAL_TYPE_5_YELLOW";
									
									/*события*/
									newUnit1.addEventListener(TouchEvent.TOUCH, (level as Level).onButtonTouch);
									newUnit1.cellType = "CELL_TYPE_CLEAR";
									newUnit1.CrystalShow();
						
									matrixAll.push(newUnit1);
									level.addChild(newUnit1)
									AnimationMoveDown(newUnit1, newUnit1.x, (70 + (50 * iAdd)), level);
								}
							}
						}else { // пустоты закончились
								if (matrixUnits.length > 0) { // объекты
									if ((matrixUnits[0] as Unit).posRowJ == iAdd) {
										matrixAll.push(matrixUnits[0]); // переносим
										matrixUnits.shift(); // удаляем
									}else { // переносим объект вниз
										(matrixUnits[0] as Unit).posRowJ = iAdd;		// изменяем индекс положения в строке
										matrixAll.push(matrixUnits[0]); // переносим
										AnimationMoveDown((matrixUnits[0] as Unit), (matrixUnits[0] as Unit).x, (70 + (50 * iAdd)), level);
										matrixUnits.shift(); // удаляем
									}
								}else { // создаём новый объект
							
									/* Добавление новых объектов в массив и на поле */
									var newUnit2:Unit = new Unit();
									newUnit2.x = 165 + (50 * i);
									newUnit2.y = 0 + (50 * 0);	// начальная позиция для нового объекта
									newUnit2.posColumnI = i;
									newUnit2.posRowJ = iAdd;
									
									var type2:int = RandomIndex();
									if (type2 >= 0 && type2 < 2) newUnit2.unitType = "CRYSTAL_TYPE_1_VIOLET";
									if (type2 >= 2 && type2 < 4) newUnit2.unitType = "CRYSTAL_TYPE_2_GREEN";
									if (type2 >= 4 && type2 < 6) newUnit2.unitType = "CRYSTAL_TYPE_3_RED";
									if (type2 >= 6 && type2 < 8) newUnit2.unitType = "CRYSTAL_TYPE_4_BLUE";
									if (type2 >= 8 && type2 <= 10) newUnit2.unitType = "CRYSTAL_TYPE_5_YELLOW";
						
									/*события*/
									newUnit2.addEventListener(TouchEvent.TOUCH, (level as Level).onButtonTouch);
									newUnit2.cellType = "CELL_TYPE_CLEAR";
									newUnit2.CrystalShow();
						
									matrixAll.push(newUnit2);
									level.addChild(newUnit2)
									AnimationMoveDown(newUnit2, newUnit2.x, (70 + (50 * iAdd)), level);
								}
						}
						
					}
				}
				/*---------------------------------------------------------------------------------------------------------------*/
				
				
				/* Возвращаем объекты обратно в главный массив ------------------------------------------------------------------*/
				for (var j2:int = Resource.ROWS - 1; j2 >= 0; j2--) {	// 5-4-3-2-1-0
					Resource.MatrixUnit[i].push(matrixAll[j2]); 	// Переносим (добавляем) в массив
				}
				
			}
		}
		
		
		/* ============================================================================================ */
		
		/* Анимация спуска объектов ====================================================================*/
		private static var _totalAnimation:int = 0;
		public static function AnimationMoveDown(unit:Unit, xMove:int, yMove:int, level:Level):void 
		{
			_totalAnimation++;
			var _tweenUnit:Tween = new Tween(unit, 0.5);
			_tweenUnit.moveTo(xMove, yMove);
			_tweenUnit.onComplete = function():void { Starling.juggler.remove(_tweenUnit); _totalAnimation--; if(_totalAnimation == 0) level.CheckField(true)};
			Starling.juggler.add(_tweenUnit);
		}
		/* ============================================================================================ */
		
		/* Определение возможности хода и перестановка в случае отсутствия такой возможности ========== */
		
		/* ============================================================================================ */ 
	}

}
package Crystal2.assets.kernel 
{
	import starling.core.Starling;
	import starling.animation.Tween;
	
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
			_tweenUnit1.onComplete = function():void { unit1Complite = true; if (unit1Complite && unit2Complite) level.CheckField(); };
			Starling.juggler.add(_tweenUnit1);
			
			_tweenUnit2.moveTo((Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).x, (Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).y);
			_tweenUnit2.onComplete = function():void { unit2Complite = true; if (unit1Complite && unit2Complite) level.CheckField(); };
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
		
		
		
	}

}
package Crystal.kernel 
{
	import Crystal.units.Cell;
	import Crystal.units.Unit;
	import Crystal.resource.Resource;
	
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
								(Resource.MatrixUnit[i][row] as Unit).flagModification = true;
								(Resource.MatrixUnit[i][row] as Unit).typeModification = 4;
								(Resource.MatrixUnit[i][row] as Unit).flagRemove = false;
								(Resource.MatrixUnit[i + 3][row] as Unit).flagRemove = true;
								//(Resource.MatrixUnit[i+3][row] as Unit).alpha = 0.2;
								
								/* Группа из 5-ти кристалов */
								if (i < Resource.COLUMNS - 4) {	// < 6
									if (Resource.MatrixUnit[i][row].unitType == Resource.MatrixUnit[i + 4][row].unitType) {
										/*Отмечаем кристалы для модификации и удаления */
										(Resource.MatrixUnit[i][row] as Unit).flagModification = true;
										(Resource.MatrixUnit[i][row] as Unit).typeModification = 5;
										(Resource.MatrixUnit[i][row] as Unit).flagRemove = false;
										(Resource.MatrixUnit[i + 4][row] as Unit).flagRemove = true;
										//(Resource.MatrixUnit[i+4][row] as Unit).alpha = 0.2;
								
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
								(Resource.MatrixUnit[column][j] as Unit).flagModification = true;
								(Resource.MatrixUnit[column][j] as Unit).typeModification = 4;
								(Resource.MatrixUnit[column][j] as Unit).flagRemove = false;
								(Resource.MatrixUnit[column][j+3] as Unit).flagRemove = true;
								//(Resource.MatrixUnit[column][j+3] as Unit).alpha = 0.2;
								
								/* Группа из 5-ти кристалов */
								if (j < Resource.ROWS - 4) {	// < 6
									if (Resource.MatrixUnit[column][j].unitType == Resource.MatrixUnit[column][j+4].unitType) {
										/*Отмечаем кристалы для модификации и удаления */
										(Resource.MatrixUnit[column][j] as Unit).flagModification = true;
										(Resource.MatrixUnit[column][j] as Unit).typeModification = 5;
										(Resource.MatrixUnit[column][j] as Unit).flagRemove = false;
										(Resource.MatrixUnit[column][j+4] as Unit).flagRemove = true;
										//(Resource.MatrixUnit[column][j+4] as Unit).alpha = 0.2;
								
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
		
		
	}

}
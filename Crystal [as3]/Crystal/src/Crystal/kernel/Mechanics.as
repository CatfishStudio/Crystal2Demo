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
		public static function ExchangeCrystals(unit1:Unit, unit2:Unit):void
		{
			var unitType:String = (Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).unitType;
			var flagRemove:Boolean = (Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).flagRemove;
			var flagModification:Boolean = (Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).flagModification;
			var typeModification:int = (Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).typeModification;
			var posColumnI:int = (Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).posColumnI;
			var posRowJ:int = (Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).posRowJ;
			var posX:int = (Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).posX;
			var posY:int = (Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).posY;
		
			(Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).unitType = (Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).unitType;
			(Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).flagRemove = (Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).flagRemove;
			(Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).flagModification = (Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).flagModification;
			(Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).typeModification = (Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).typeModification;
			(Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).posColumnI = (Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).posColumnI;
			(Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).posRowJ = (Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).posRowJ;
			(Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).posX = (Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).posX;
			(Resource.MatrixUnit[unit1.posColumnI][unit1.posRowJ] as Unit).posY = (Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).posY;
			
			(Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).unitType = unitType;
			(Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).flagRemove = flagRemove;
			(Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).flagModification = flagModification;
			(Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).typeModification = typeModification;
			(Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).posColumnI = posColumnI;
			(Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).posRowJ = posRowJ;
			(Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).posX = posX;
			(Resource.MatrixUnit[unit2.posColumnI][unit2.posRowJ] as Unit).posY = posY;
			
			
		}
		
		
	}

}
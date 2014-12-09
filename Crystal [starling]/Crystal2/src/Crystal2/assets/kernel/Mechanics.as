package Crystal2.assets.kernel 
{
	import starling.core.Starling;
	import starling.animation.Tween;
	
	import Crystal2.assets.units.Cell;
	import Crystal2.assets.units.Unit;
	import Crystal2.assets.resource.Resource;
	
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
			
			var _tweenUnit1:Tween = new Tween((Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit), 1.0);
			var _tweenUnit2:Tween = new Tween((Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit), 1.0);
		
			_tweenUnit1.moveTo((Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).x, (Resource.MatrixUnit[columnCrystal2][rowCrystal2] as Unit).y);
			_tweenUnit2.moveTo((Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).x, (Resource.MatrixUnit[columnCrystal1][rowCrystal1] as Unit).y);
			//_tween.onComplete = function():void { Starling.juggler.remove(_tween); }
			Starling.juggler.add(_tweenUnit1);
			Starling.juggler.add(_tweenUnit2);
		}
		/* ============================================================================================ */
		
		
		
		
	}

}
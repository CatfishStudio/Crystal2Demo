package LevelEditor 
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class Resource 
	{
		[Embed(source = '../../images/cursor.png')]
		public static var CursorImage:Class;
		public static var Cursor:Bitmap = new CursorImage();
		[Embed(source = '../../images/cell.png')]
		public static var CellClearImage:Class;
		public static var CellClear:Bitmap = new CellClearImage();
		[Embed(source = '../../images/drop.png')]
		public static var CellDropImage:Class;
		public static var CellDrop:Bitmap = new CellDropImage();
		
		[Embed(source = '../../images/crystal_1_50_50.png')]
		public static var Crystal1Image:Class;
		public static var Crystal1:Bitmap = new Crystal1Image();
		[Embed(source = '../../images/crystal_2_50_50.png')]
		public static var Crystal2Image:Class;
		public static var Crystal2:Bitmap = new Crystal2Image();
		[Embed(source = '../../images/crystal_3_50_50.png')]
		public static var Crystal3Image:Class;
		public static var Crystal3:Bitmap = new Crystal3Image();
		[Embed(source = '../../images/crystal_4_50_50.png')]
		public static var Crystal4Image:Class;
		public static var Crystal4:Bitmap = new Crystal4Image();
		[Embed(source = '../../images/crystal_5_50_50.png')]
		public static var Crystal5Image:Class;
		public static var Crystal5:Bitmap = new Crystal5Image();
		
		/* Костанты */
		public static const COLUMNS:int = 10;
		public static const ROWS:int = 10;
		
		/* Тип уровня */
		public static var LevelsType:Array = new Array( 
			{label:"Собрать кристалы", data:"LEVEL_TYPE_COLLECT"}, 
			{label:"Набрать очки", data:"LEVEL_TYPE_SCORE_POINTS"}, 
			{label:"На время", data:"LEVEL_TYPE_TIME"} 
		);
		
		/* Тип кристала */
		public static var CrystalsType:Array = new Array( 
			{label:"Все кристалы", data:"CRYSTAL_TYPE_ALL"},
			{label:"1-Фиолетовый", data:"CRYSTAL_TYPE_1_VIOLET"}, 
			{label:"2-Зеленый", data:"CRYSTAL_TYPE_2_GREEN"}, 
			{label:"3-Красный", data:"CRYSTAL_TYPE_3_RED"}, 
			{label:"4-Синий", data:"CRYSTAL_TYPE_4_BLUE" }, 
			{label:"5-Желтый", data:"CRYSTAL_TYPE_5_YELLOW" }
		);
		
		/* Выбраный объект */
		public static var SelectObject:String = "SELECT_NO_OBJECT";
		
		/* Параметры редактируемого уровня */
		public static var LevelNumber:String;		// номер уровня
		public static var LevelType:String;			// тип уровня
		public static var CrystalType:String;		// тип кристала
		public static var AmountCrystals:String;	// количество кристалов
		public static var AmountScoreStar1:String;	// количество очков на 1 звезду
		public static var AmountScoreStar2:String;	// количество очков на 2 звезды
		public static var AmountScoreStar3:String;	// количество очков на 3 звезды
		public static var AmountTime:String;		// время на уровне
		public static var AmountMoves:String;		// количество ходов
		
		/* Массив: Игровое поле (тип Vector) */
		public static var MatrixCell:Vector.<Vector.<FieldCell>>;
		
		/* Создание 2D массива тип Vector */
		public static function CreateVectorMatrix2D(_columns:uint, _rows:uint):Vector.<Vector.<FieldCell>>
		{
			var _matrixCell:Vector.<Vector.<FieldCell>> = new Vector.<Vector.<FieldCell>>();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Vector.<FieldCell> = new Vector.<FieldCell>();
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(new FieldCell());
				}
				_matrixCell.push(newRow);
			}
			return _matrixCell;
		}
		
		/* Создание 2D массива тип Array */
		public static function CreateArrayMatrix2D(_columns:uint, _rows:uint):Array
		{
			/* i - столбец; j - строка */
			var newArray:Array = [];
			var unitAdd:FieldCell = new FieldCell();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Array = [];
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(unitAdd);
				}
				newArray.push(newRow);
			}
			return newArray;
		}
		
	}

}
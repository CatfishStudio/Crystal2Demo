package MapEditor 
{
	import flash.display.Bitmap;
	import MapEditor.FieldCell;
	
	public class Resource 
	{
		
		[Embed(source = '../../images/crystal_1_50_50.png')]
		public static var CImage1:Class;
		[Embed(source = '../../images/crystal_1_50_50_line_horizontally.png')]
		public static var CLHImage1:Class;
		[Embed(source = '../../images/crystal_1_50_50_line_upright.png')]
		public static var CLUImage1:Class;
		[Embed(source = '../../images/crystal_1_50_50_Super.png')]
		public static var CSImage1:Class;
		
		[Embed(source = '../../images/crystal_2_50_50.png')]
		public static var CImage2:Class;
		[Embed(source = '../../images/crystal_2_50_50_line_horizontally.png')]
		public static var CLHImage2:Class;
		[Embed(source = '../../images/crystal_2_50_50_line_upright.png')]
		public static var CLUImage2:Class;
		[Embed(source = '../../images/crystal_2_50_50_Super.png')]
		public static var CSImage2:Class;
		
		[Embed(source = '../../images/crystal_3_50_50.png')]
		public static var CImage3:Class;
		[Embed(source = '../../images/crystal_3_50_50_line_horizontally.png')]
		public static var CLHImage3:Class;
		[Embed(source = '../../images/crystal_3_50_50_line_upright.png')]
		public static var CLUImage3:Class;
		[Embed(source = '../../images/crystal_3_50_50_Super.png')]
		public static var CSImage3:Class;
		
		[Embed(source = '../../images/crystal_4_50_50.png')]
		public static var CImage4:Class;
		[Embed(source = '../../images/crystal_4_50_50_line_horizontally.png')]
		public static var CLHImage4:Class;
		[Embed(source = '../../images/crystal_4_50_50_line_upright.png')]
		public static var CLUImage4:Class;
		[Embed(source = '../../images/crystal_4_50_50_Super.png')]
		public static var CSImage4:Class;
		
		[Embed(source = '../../images/crystal_5_50_50.png')]
		public static var CImage5:Class;
		[Embed(source = '../../images/crystal_5_50_50_line_horizontally.png')]
		public static var CLHImage5:Class;
		[Embed(source = '../../images/crystal_5_50_50_line_upright.png')]
		public static var CLUImage5:Class;
		[Embed(source = '../../images/crystal_5_50_50_Super.png')]
		public static var CSImage5:Class;
		
		
		[Embed(source = '../../images/cursor.png')]
		public static var CursorImage:Class;
		[Embed(source = '../../images/cell.png')]
		public static var CellClearImage:Class;
		[Embed(source = '../../images/drop.png')]
		public static var DropImage:Class;
		[Embed(source = '../../images/empty.png')]
		public static var EmptyImage:Class;
		[Embed(source = '../../images/rune.png')]
		public static var RuneImage:Class;
		[Embed(source = '../../images/stone.png')]
		public static var StoneImage:Class;
		
		/* Костанты */
		public static const COLUMNS:int = 10;
		public static const ROWS:int = 10;
		
		/* Тип уровня */
		public static var levelType:Array = new Array( 
			{label:"Собрать кристалы", data:"LEVEL_TYPE_COLLECT"}, 
			{label:"Набрать очки", data:"LEVEL_TYPE_SCORE_POINTS"}, 
			{label:"Спустить объект", data:"LEVEL_TYPE_DROP_OBJECT"}, 
			{label:"На время", data:"LEVEL_TYPE_TIME"} 
		); 
		
		/* Тип кристала */
		public static var crystalType:Array = new Array( 
			{label:"Все кристалы", data:"CRYSTAL_TYPE_ALL"},
			{label:"1-Фиолетовый", data:"CRYSTAL_TYPE_1_VIOLET"}, 
			{label:"2-Зеленый", data:"CRYSTAL_TYPE_2_GREEN"}, 
			{label:"3-Красный", data:"CRYSTAL_TYPE_3_RED"}, 
			{label:"4-Синий", data:"CRYSTAL_TYPE_4_BLUE" }, 
			{label:"5-Желтый", data:"CRYSTAL_TYPE_5_YELLOW" }, 
			{label:"6-Линейный вертикаль", data:"CRYSTAL_TYPE_6_LINE_UPRIGHT"},
			{label:"7-Линейный горизонталь", data:"CRYSTAL_TYPE_7_LINE_HORIZONTALLY"},
			{label:"8-Супер кристал", data:"CRYSTAL_TYPE_8_SUPER" },
			{label:"9-Не собирать", data:"CRYSTAL_TYPE_9_NO" }
		);
		
		/* Выбраный объект */
		public static var SelectObject:String = "SELECT_NO_OBJECT";
		
		/* Параметры редактируемого уровня */
		public static var Level:String;			// номер уровня
		public static var Location:String;		// номер локации
		public static var LevelType:String;		// тип уровня
		public static var CrystalType:String;	// тип кристала
		public static var AmountCrystals:String;// количество кристалов
		public static var AmountScoreStar1:String;	// количество очков
		public static var AmountScoreStar2:String;	// количество очков
		public static var AmountScoreStar3:String;	// количество очков
		public static var AmountTime:String;	// время на уровне
		public static var AmountMoves:String;	// количество ходов
		public static var FileBackground:String;	// имя файла фоновой картинки для уровня
	
		/* Массив: Игровое поле (тип Vector) */
		public static var MatrixCell:Vector.<Vector.<FieldCell>>;
		
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
	}

}
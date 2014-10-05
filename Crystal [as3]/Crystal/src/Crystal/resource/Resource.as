package Crystal.resource 
{
	import flash.display.Bitmap;
	import Crystal.units.Cell;
	import Crystal.units.Unit;
	
	public class Resource 
	{
		/* Костанты */
		public static const COLUMNS:int = 10;
		public static const ROWS:int = 10;
		
		/* Настройки игры */
		public static var Music:Boolean = true;
		public static var Sound:Boolean = true;
		
		/* Текстуры */
		public static var CrystalImage:Bitmap;
		public static var MenuBackground:Bitmap;
		public static var ButtonImage1:Bitmap;
		public static var ButtonImage2:Bitmap;
		public static var ButtonMusicImage:Bitmap;
		public static var ButtonSoundImage:Bitmap;
		public static var ButtonInfoImage:Bitmap;
		public static var MapImage:Bitmap;
		public static var MapBorderImage:Bitmap;
		public static var MapRoadblocksImages:Bitmap;
		public static var WindowBorderImage:Bitmap;
		public static var StarAndDialogImage:Bitmap;
		public static var UnitsImage:Bitmap;
				
		/* XML Файлы */
		public static var SelectFileXML:String;
		public static var FileXML:XML;
		
		/* Игровой прогресс(открытие уровней) */
		public static var Life:uint = 5;
		public static var MapLevel1:Boolean = true;
		public static var MapLevel1ScoreStar1:int = 0;
		public static var MapLevel1ScoreStar2:int = 0;
		public static var MapLevel1ScoreStar3:int = 0;
		public static var MapLevel2:Boolean = false;
		public static var MapLevel3:Boolean = false;
		public static var MapLevel4:Boolean = false;
		public static var MapLevel5:Boolean = false;
		
		/* Игровое поле */
		public static var MatrixCell:Vector.<Vector.<Cell>>;
		/* Объекты игрового поля */
		public static var MatrixUnit:Vector.<Vector.<Unit>>;
	}

}
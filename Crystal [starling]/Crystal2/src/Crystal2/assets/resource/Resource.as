package Crystal2.assets.resource 
{
	import flash.display.Bitmap;
	import Crystal2.assets.units.Cell;
	import Crystal2.assets.units.Unit;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Resource 
	{
		
		/* Костанты */
		public static const COLUMNS:int = 10;
		public static const ROWS:int = 10;
		
		/* Настройки игры */
		public static var Music:Boolean = true;
		public static var Sound:Boolean = true;
		
		/* Текстуры */
		public static var Image_Map:Bitmap;
		
		/* Атласы */
		public static var Image_AtlasAll:Bitmap;
		public static var FileXML_AtlasAll:XML;
		public static var Image_AtlasLevels:Bitmap;
		public static var FileXML_AtlasLevels:XML;
		public static var Image_AtlasPanel:Bitmap;
		public static var FileXML_AtlasPanel:XML;
		
		/* Уровни */
		public static var FilesXML_Levels:Vector.<XML> = new Vector.<XML>();
		
		/* Игровой прогресс(открытие уровней) */
		public static var Life:uint = 5;
		public static var MapLevel1:Boolean = true;
		public static var MapLevel2:Boolean = false;
		public static var MapLevel3:Boolean = false;
		public static var MapLevel4:Boolean = false;
		public static var MapLevel5:Boolean = false;
		public static var MapLevelScoreStar1:int = 0;
		public static var MapLevelScoreStar2:int = 0;
		public static var MapLevelScoreStar3:int = 0;
		public static var LevelQuest:String;
		public static var LevelComplete:int = 0;
		public static var Progress:Vector.<Vector.<int>>;
		
		
		/* Игровое поле (Level.as)*/
		public static var MatrixCell:Vector.<Vector.<Cell>>;
		/* Объекты игрового поля */
		public static var MatrixUnit:Vector.<Vector.<Unit>>;
	}

}
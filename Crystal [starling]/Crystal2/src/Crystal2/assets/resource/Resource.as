package Crystal2.assets.resource 
{
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import Crystal2.assets.units.Cell;
	import Crystal2.assets.units.Unit;
	import vk.APIConnection;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Resource 
	{
		/* ВКонтакте */
		public static var VK:APIConnection;
		
		/* Костанты */
		public static const COLUMNS:int = 10;
		public static const ROWS:int = 10;
		public static const CELL_WIDTH:int = 50;
		public static const CELL_HEIGHT:int = 50;
		
		/* Настройки игры */
		public static var Music:Boolean = true;
		public static var Sounds:Boolean = true;
		
		/* Текстуры */
		public static var Image_Map:Bitmap;
		
		/* Звуки */
		public static var MusicMelody:Sound;
		public static var MusicChannel:SoundChannel;
		public static var MoveSound:Sound;
		
		/* Атласы */
		public static var Image_AtlasAll:Bitmap;
		public static var FileXML_AtlasAll:XML;
		public static var Image_AtlasLevels:Bitmap;
		public static var FileXML_AtlasLevels:XML;
		public static var Image_AtlasPanel:Bitmap;
		public static var FileXML_AtlasPanel:XML;
		public static var AtlasAll:TextureAtlas;
		public static var AtlasLevels:TextureAtlas;
		public static var AtlasPanel:TextureAtlas;
		
		/* Уровни */
		public static var FilesXML_Levels:Vector.<XML> = new Vector.<XML>();
		
		/* Игровой прогресс(открытие уровней) */
		public static var Life:uint = 5;
		public static var SelectLevel:int = 0;
		public static var LevelComplete:int = 6;
		public static var Progress:Vector.<Vector.<int>>;
		
		/* Данные об уровне из xml файла ----------------------------------------*/
		/* тип уровня: 
		 * LEVEL_TYPE_COLLECT (Собрать кристалы), 
		 * LEVEL_TYPE_SCORE_POINTS (Набрать очки), 
		 * LEVEL_TYPE_TIME (На время)*/
		public static var LevelType:String;
		/* тип кристала 
		 * CRYSTAL_TYPE_ALL (все, любые)
		 * CRYSTAL_TYPE_1_VIOLET (1-фиолетовый)
		 * CRYSTAL_TYPE_2_GREEN (2-зеленый)
		 * CRYSTAL_TYPE_3_RED (3-красный)
		 * CRYSTAL_TYPE_4_BLUE (4-синий)
		 * CRYSTAL_TYPE_5_YELLOW (желтый)*/
		public static var CrystalType:String;
		/* количество кристалов*/
		public static var AmountCrystals:int = 0;
		/* очки на 1, 2, 3 звезды*/
		public static var AmountScoreStar1:int = 0;
		public static var AmountScoreStar2:int = 0;
		public static var AmountScoreStar3:int = 0;
		/* время */
		public static var AmountTime:int = 0;
		/* количество ходов */
		public static var AmountMoves:int = 0;
		/*-----------------------------------------------------------------------*/
		
		/* Игровое поле (Level.as)*/
		public static var MatrixCell:Vector.<Vector.<Cell>>;
		/* Объекты игрового поля */
		public static var MatrixUnit:Vector.<Vector.<Unit>>;
		
		/* МУЗЫКА -------------------------------------------------*/
		public static function PlayMusic():void
		{
			if (Music) {
				MusicChannel = MusicMelody.play();
				MusicChannel.addEventListener(Event.SOUND_COMPLETE, PlayMusicLoop);
			}
		}
		public static function PlayMusicLoop(e:Event):void
		{
			SoundChannel(e.target).removeEventListener(e.type, PlayMusicLoop);
			if (Music) PlayMusic();
		}
		public static function StopMusic():void
		{
			MusicChannel.stop();
		}
		/*ЗВУКИ --------------------------------------------------*/
		public static function PlaySound():void
		{
			if(Sounds) MoveSound.play();
		}
		/*---------------------------------------------------------*/
	}

}
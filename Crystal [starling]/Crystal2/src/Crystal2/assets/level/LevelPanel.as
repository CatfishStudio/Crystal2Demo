package Crystal2.assets.level 
{
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Quad;
	import starling.text.TextField;
	
	import Crystal2.assets.resource.Resource;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class LevelPanel extends Sprite 
	{
		[Embed(source = '../media/textures/crystal.png')]
		private var CrystalImage:Class;
		private var _crystalImage:Bitmap = new CrystalImage();
		
		private var _crystal:Image;
		private var _panel1:Quad;
		private var _panel2:Quad;
		public var labelQuest:TextField;	// задание
		public var labelGiven:TextField;	// дано на задание
		public var labelScore:TextField;	// очьки
		private var _textQuest:String;
		private var _textGiven:String;
		
		
		public function LevelPanel(textQuest:String, textGiven:String) 
		{
			super();
			_textQuest = textQuest; _textGiven = textGiven;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_panel1 = new Quad(100, 150, 0x800080, true);
			_panel1.x = 25; _panel1.y = 50;
			_panel1.alpha = 0.4;
			this.addChild(_panel1);
			
			_panel2 = new Quad(600, 40, 0x800080, true);
			_panel2.x = 60; _panel2.y = 20;
			_panel2.alpha = 0.4;
			this.addChild(_panel2);
			
			_crystal = new Image(Texture.fromBitmapData(_crystalImage.bitmapData));
			_crystal.x = 10; _crystal.y = 5;
			this.addChild(_crystal);
			
			labelQuest = new TextField(600, 100, _textQuest, "Aria", 18, 0xFFFFFF, true);
			labelQuest.x = 150; labelQuest.y = -10;
			labelQuest.hAlign = "left";
			this.addChild(labelQuest);
			
			labelGiven = new TextField(200, 100, _textGiven, "Aria", 18, 0xFFFFFF, true);
			labelGiven.x = 30; labelGiven.y = 80;
			labelGiven.hAlign = "left";
			this.addChild(labelGiven);
			
			labelScore = new TextField(200, 100, "Очки: 0", "Aria", 16, 0xFFFFFF, true);
			labelScore.x = 30; labelScore.y = 130;
			labelScore.hAlign = "left";
			this.addChild(labelScore);
		}
		
	}

}
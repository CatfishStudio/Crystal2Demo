package Crystal2.assets.units 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import Crystal2.assets.resource.Resource;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Unit extends Sprite 
	{
		public var cellType:String = "CELL_TYPE_CLEAR";	// тип ячейки
		public var unitType:String = "CRYSTAL_TYPE_0";	// тип кристала			
		
		public var flagRemove:Boolean = false;
		public var posColumnI:int = 0;
		public var posRowJ:int = 0;
		
		private var _crystalImage:Image;
		private var _atlasAll:TextureAtlas;
		
		public function Unit() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function CrystalShow():void
		{
			if (unitType == "CRYSTAL_TYPE_0") {
				this.visible = false;
			}
			if (unitType == "CRYSTAL_TYPE_1_VIOLET") {
				_crystalImage = new Image(Resource.AtlasAll.getTexture("crystal_1_50_50.png"));
				this.addChild(_crystalImage);
			}
			if (unitType == "CRYSTAL_TYPE_2_GREEN") {
				_crystalImage = new Image(Resource.AtlasAll.getTexture("crystal_2_50_50.png"));
				this.addChild(_crystalImage);
			}
			if (unitType == "CRYSTAL_TYPE_3_RED") {
				_crystalImage = new Image(Resource.AtlasAll.getTexture("crystal_3_50_50.png"));
				this.addChild(_crystalImage);
			}
			if (unitType == "CRYSTAL_TYPE_4_BLUE") {
				_crystalImage = new Image(Resource.AtlasAll.getTexture("crystal_4_50_50.png"));
				this.addChild(_crystalImage);
			}
			if (unitType == "CRYSTAL_TYPE_5_YELLOW") {
				_crystalImage = new Image(Resource.AtlasAll.getTexture("crystal_5_50_50.png"));
				this.addChild(_crystalImage);
			}
		}
		
		public function CrystalUpdate():void
		{
			this.removeChild(_crystalImage);
			if (unitType == "CRYSTAL_TYPE_0") {
				this.visible = false;
			}
			if (unitType == "CRYSTAL_TYPE_1_VIOLET") {
				_crystalImage = new Image(Resource.AtlasAll.getTexture("crystal_1_50_50.png"));
				this.addChild(_crystalImage);
			}
			if (unitType == "CRYSTAL_TYPE_2_GREEN") {
				_crystalImage = new Image(Resource.AtlasAll.getTexture("crystal_2_50_50.png"));
				this.addChild(_crystalImage);
			}
			if (unitType == "CRYSTAL_TYPE_3_RED") {
				_crystalImage = new Image(Resource.AtlasAll.getTexture("crystal_3_50_50.png"));
				this.addChild(_crystalImage);
			}
			if (unitType == "CRYSTAL_TYPE_4_BLUE") {
				_crystalImage = new Image(Resource.AtlasAll.getTexture("crystal_4_50_50.png"));
				this.addChild(_crystalImage);
			}
			if (unitType == "CRYSTAL_TYPE_5_YELLOW") {
				_crystalImage = new Image(Resource.AtlasAll.getTexture("crystal_5_50_50.png"));
				this.addChild(_crystalImage);
			}
		}
		
	}

}
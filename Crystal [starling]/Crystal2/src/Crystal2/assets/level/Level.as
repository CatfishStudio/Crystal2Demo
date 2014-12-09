package Crystal2.assets.level 
{
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import Crystal2.assets.resource.Resource;
	import Crystal2.assets.events.NavigationEvent;
	import Crystal2.assets.animation.Quest;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Level extends Sprite 
	{
		private var _atlasAll:TextureAtlas;
		private var _atlasLevels:TextureAtlas;
		
		
		
		public function Level() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.TRIGGERED, onClick);
			
			_atlasAll = new TextureAtlas(Texture.fromBitmap(Resource.Image_AtlasAll), Resource.FileXML_AtlasAll);
			_atlasLevels = new TextureAtlas(Texture.fromBitmap(Resource.Image_AtlasLevels), Resource.FileXML_AtlasLevels);
			
			if (Resource.SelectLevel == 1) this.addChild(new Image(_atlasLevels.getTexture("level_1_map_1.jpg")));
			if (Resource.SelectLevel == 2) this.addChild(new Image(_atlasLevels.getTexture("level_2_map_1.jpg")));
			if (Resource.SelectLevel == 3) this.addChild(new Image(_atlasLevels.getTexture("level_3_map_1.jpg")));
			if (Resource.SelectLevel == 4) this.addChild(new Image(_atlasLevels.getTexture("level_4_map_1.jpg")));
			if (Resource.SelectLevel == 5) this.addChild(new Image(_atlasLevels.getTexture("level_5_map_1.jpg")));
			
			this.addChild(new Quest());
		}
		
			
		private function onClick(e:Event):void
		{
			
		}
	}

}
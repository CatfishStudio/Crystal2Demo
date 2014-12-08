package Crystal2.assets.menu 
{
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import Crystal2.assets.resource.Resource;
	import Crystal2.assets.events.NavigationEvent;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class StartMenu extends Sprite 
	{
		private var _btnStart:Button;
		private var _btnSetting:Button;
		private var _bgImage:Image;
		
		public function StartMenu() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var atlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(Resource.Image_AtlasAll), Resource.FileXML_AtlasAll);
			_bgImage = new Image(atlas.getTexture("menu.png"));
			this.addChild(_bgImage);
			
			_btnStart = new Button(atlas.getTexture("button_1.png"), "Играть", atlas.getTexture("button_2.png"));
			_btnStart.fontColor = 0xffffff;
			_btnStart.fontSize = 18;
			_btnStart.fontName = "Arial";
			_btnStart.x = 330; _btnStart.y = 450;
			this.addChild(_btnStart);
			
			_btnSetting = new Button(atlas.getTexture("button_1.png"), "Настройки", atlas.getTexture("button_2.png"));
			_btnSetting.fontColor = 0xffffff;
			_btnSetting.fontSize = 18;
			_btnSetting.fontName = "Arial";
			_btnSetting.x = 330; _btnSetting.y = 500;
			this.addChild(_btnSetting);
			
			this.addEventListener(Event.TRIGGERED, onClick);
		}
		
		private function onClick(e:Event):void
		{
			if ((e.target as Button) == _btnStart)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "PLAY" }, true));
			}
			if ((e.target as Button) == _btnSetting)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "SETTINGS" }, true));
			}
		} 
		
	}

}
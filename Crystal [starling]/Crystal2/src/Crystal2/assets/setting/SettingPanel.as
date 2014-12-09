package Crystal2.assets.setting 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Button;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import Crystal2.assets.resource.Resource;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class SettingPanel extends Sprite 
	{
		private var _atlasAll:TextureAtlas;
		private var _btnMusic:Button;
		private var _btnSound:Button;
		private var _btnInfo:Button;
		
		public function SettingPanel() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.TRIGGERED, onClick);
			
			_atlasAll = new TextureAtlas(Texture.fromBitmap(Resource.Image_AtlasAll), Resource.FileXML_AtlasAll);
			
			if (Resource.Music) _btnMusic = new Button(_atlasAll.getTexture("settingMusic_1.png"), "");
			else _btnMusic = new Button(_atlasAll.getTexture("settingMusic_2.png"), "");
			_btnMusic.x = 0; _btnMusic.y = 0;
			this.addChild(_btnMusic);
			
			if (Resource.Sound) _btnSound = new Button(_atlasAll.getTexture("settingSound_1.png"), "");
			else _btnSound = new Button(_atlasAll.getTexture("settingSound_2.png"), "");
			_btnSound.x = 50; _btnSound.y = 0;
			this.addChild(_btnSound);
			
			_btnInfo = new Button(_atlasAll.getTexture("settingInfo.png"), "");
			_btnInfo.x = 95; _btnInfo.y = 0;
			this.addChild(_btnInfo);
			
			
		}
		
		private function onClick(e:Event):void
		{
			if ((e.target as Button) == _btnMusic) {
				if (Resource.Music == false) {
					Resource.Music = true;	_btnMusic.upState = _atlasAll.getTexture("settingMusic_1.png");
				}else {
					Resource.Music = false;	_btnMusic.upState = _atlasAll.getTexture("settingMusic_2.png");
				}
			}
			if ((e.target as Button) == _btnSound) {
				if (Resource.Sound == false) {
					Resource.Sound = true;	_btnSound.upState = _atlasAll.getTexture("settingSound_1.png");
				}else {
					Resource.Sound = false;	_btnSound.upState = _atlasAll.getTexture("settingSound_2.png");
				}
			}
			
		} 
	}

}
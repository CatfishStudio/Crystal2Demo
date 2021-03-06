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
			
			if (Resource.Music) _btnMusic = new Button(Resource.AtlasAll.getTexture("settingMusic_1.png"), "");
			else _btnMusic = new Button(Resource.AtlasAll.getTexture("settingMusic_2.png"), "");
			_btnMusic.x = 0; _btnMusic.y = 0;
			this.addChild(_btnMusic);
			
			if (Resource.Sounds) _btnSound = new Button(Resource.AtlasAll.getTexture("settingSound_1.png"), "");
			else _btnSound = new Button(Resource.AtlasAll.getTexture("settingSound_2.png"), "");
			_btnSound.x = 50; _btnSound.y = 0;
			this.addChild(_btnSound);
			
			_btnInfo = new Button(Resource.AtlasAll.getTexture("settingInfo.png"), "");
			_btnInfo.x = 95; _btnInfo.y = 0;
			this.addChild(_btnInfo);
			
			
		}
		
		private function onClick(e:Event):void
		{
			if ((e.target as Button) == _btnMusic) {
				if (Resource.Music == false) {
					Resource.Music = true;	_btnMusic.upState = Resource.AtlasAll.getTexture("settingMusic_1.png");
					Resource.PlayMusic();
				}else {
					Resource.Music = false;	_btnMusic.upState = Resource.AtlasAll.getTexture("settingMusic_2.png");
					Resource.StopMusic();
				}
			}
			if ((e.target as Button) == _btnSound) {
				if (Resource.Sounds == false) {
					Resource.Sounds = true;	_btnSound.upState = Resource.AtlasAll.getTexture("settingSound_1.png");
				}else {
					Resource.Sounds = false; _btnSound.upState = Resource.AtlasAll.getTexture("settingSound_2.png");
				}
			}
			
		} 
	}

}
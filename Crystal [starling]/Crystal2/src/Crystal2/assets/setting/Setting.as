package Crystal2.assets.setting 
{
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.display.Quad;
	import starling.display.Button;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import Crystal2.assets.resource.Resource;
	import Crystal2.assets.events.NavigationEvent;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Setting extends Sprite 
	{
		private var _tween:Tween;
		
		private var _window:Sprite;
		private var _panel:Quad;
		private var _bg:Quad;
		
		private var _btnMusic:Button;
		private var _btnSound:Button;
		private var _btnInfo:Button;
		private var _btnClose:Button;
		
		public function Setting() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.TRIGGERED, onClick);
			
			_bg = new Quad(800, 600,  0x000000, true);
			_bg.alpha = 0.5;
			this.addChild(_bg);
			
			_window = new Sprite();
			_panel = new Quad(800, 100, 0xFFFFFF, true);
			_panel.alpha = 0.8;
			_window.addChild(_panel);
			
			if (Resource.Music) _btnMusic = new Button(Resource.AtlasAll.getTexture("settingMusic_1.png"), "");
			else _btnMusic = new Button(Resource.AtlasAll.getTexture("settingMusic_2.png"), "");
			_btnMusic.x = 300; _btnMusic.y = 30;
			_window.addChild(_btnMusic);
			
			if (Resource.Sounds) _btnSound = new Button(Resource.AtlasAll.getTexture("settingSound_1.png"), "");
			else _btnSound = new Button(Resource.AtlasAll.getTexture("settingSound_2.png"), "");
			_btnSound.x = 400; _btnSound.y = 30;
			_window.addChild(_btnSound);
			
			_btnInfo = new Button(Resource.AtlasAll.getTexture("settingInfo.png"), "");
			_btnInfo.x = 500; _btnInfo.y = 30;
			_window.addChild(_btnInfo);
			
			_btnClose = new Button(Resource.AtlasAll.getTexture("button_1.png"), "Закрыть", Resource.AtlasAll.getTexture("button_2.png"));
			_btnClose.fontColor = 0xffffff;
			_btnClose.fontSize = 18;
			_btnClose.fontName = "Arial";
			_btnClose.x = 600; _btnClose.y = 30;
			_window.addChild(_btnClose);
			
			this.addChild(_window);
			
			
			
			
			_tween = new Tween(_window, 0.2);
			_tween.moveTo(0, 250);
			_tween.onComplete = function():void { Starling.juggler.remove(_tween); }
			Starling.juggler.add(_tween);
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
					Resource.Sounds = false;	_btnSound.upState = Resource.AtlasAll.getTexture("settingSound_2.png");
				}
			}
			if ((e.target as Button) == _btnClose) this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "SETTING_CLOSE" }, true));
		} 
		
	}

}
package Crystal.windows 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Crystal.buttons.ButtonInfo;
	import Crystal.buttons.ButtonBlue;
	import Crystal.buttons.ButtonSound;
	import Crystal.resource.Resource;
	import Crystal.events.NavigationEvent;
	import Crystal.buttons.ButtonMusic;
	import Crystal.text.Label;
	import Crystal.buttons.ButtonBlue;
	import Crystal.buttons.ButtonGray;
	
	public class Setting extends MovieClip 
	{
		private var _panel:Sprite = new Sprite();
		private var _bg:Sprite = new Sprite();		// полупрозрачный фон окна фон окна
		private var _buttonMusic:ButtonMusic;
		private var _buttonSound:ButtonSound;
		private var _buttonInfo:ButtonInfo;
		private var _bClose:ButtonBlue;
		
		public function Setting() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_bg.graphics.lineStyle(1, 0x000000, 1);
			_bg.graphics.beginFill(0x000000, 1);
			_bg.graphics.drawRect(0, 0, 800, 600);
			_bg.graphics.endFill();
			_bg.x = 0; _bg.y = 0;
			_bg.alpha = 0.4;
			this.addChild(_bg);
			
			_panel.graphics.lineStyle(1, 0x000000, 0);
			_panel.graphics.beginFill(0xF0F0F0, 1);
			_panel.graphics.drawRect(0, 0, 800, 100);
			_panel.graphics.endFill();
			_panel.x = 0; _panel.y = -50;
			_panel.alpha = 0.9;
			
			_panel.addChild(new Label(320, 10, 400, 30, "Aria", 24, 0x2E46D1, "Настройки игры", false));
			
			_buttonMusic = new ButtonMusic(300, 50);
			_panel.addChild(_buttonMusic);
			
			_buttonSound = new ButtonSound(400, 50);
			_panel.addChild(_buttonSound);
			
			_buttonInfo = new ButtonInfo(500, 50);
			_panel.addChild(_buttonInfo);
			
			_bClose = new ButtonBlue(620, 30, 40, "Закрыть")
			_bClose.addEventListener(MouseEvent.CLICK, onMouseClickButtonSetting)
			_panel.addChild(_bClose);
			
			this.addChild(_panel);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.play();
		}
		
		private function onMouseClickButtonSetting(e:MouseEvent):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_WINDOW_SETTING_CLOSE" }, true));
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (_panel.y == 250) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame); 
			else _panel.y += 50;
		}
	}

}
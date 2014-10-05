package Crystal.menu 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Crystal.buttons.ButtonBlue;
	import Crystal.text.Label;
	import Crystal.resource.Resource;
	import Crystal.events.NavigationEvent;
	
	public class StartMenu extends Sprite 
	{
		
		public function StartMenu() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			var bStart:ButtonBlue = new ButtonBlue(330, 460, 50, "Играть");
			var bSetting:ButtonBlue = new ButtonBlue(330, 520, 25, "Нaстройки");
			
			this.addChild(Resource.MenuBackground);
			bStart.addEventListener(MouseEvent.CLICK, onMouseClickButtonStart)
			this.addChild(bStart);
			bSetting.addEventListener(MouseEvent.CLICK, onMouseClickButtonSetting)
			this.addChild(bSetting);
		}
		
		private function onMouseClickButtonStart(e:MouseEvent):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_PLAY" }, true));
		}
		
		private function onMouseClickButtonSetting(e:MouseEvent):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_WINDOW_SETTING_SHOW" }, true));
		}
		
		
	}

}
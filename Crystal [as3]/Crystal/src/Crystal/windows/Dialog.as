package Crystal.windows 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import Crystal.kernel.Atlas;
	import Crystal.resource.Resource;
	import Crystal.text.Label;
	
	public class Dialog extends MovieClip
	{
		private var upDown:Boolean = false;
		public function Dialog() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if(Resource.MapLevel1 == true && Resource.MapLevel2 == false){
				this.addChild(new Bitmap(Atlas.AtlasGetBitmap(Resource.StarAndDialogImage, 465, 135, 200, 140, true, 0x000000000000, 0, 0, 200, 140, 0, 0).bitmapData));
				this.addChild(new Label(15, 5, 250, 100, "Arial", 18, 0xFFFFFF, "Приключения \nначинаются.\nМы отправляемся \nна поиски кристала.", false));
			}
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.play();
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (upDown == false) this.y += 0.5;
			else this.y -= 0.5;
			if (this.y == 80) upDown = true;
			if (this.y == 70) upDown = false
			
		}
		
		
	}

}
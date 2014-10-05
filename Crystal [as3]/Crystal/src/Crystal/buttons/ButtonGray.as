package Crystal.buttons 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import Crystal.text.Label;
	import Crystal.resource.Resource;
	
	public class ButtonGray extends Sprite 
	{
		
		public function ButtonGray(posX:int, posY:int, posTextX:int , text:String) 
		{
			var button:Bitmap = new Bitmap(Resource.ButtonImage2.bitmapData);
			button.x = posX; button.y = posY;
			this.addChild(button);
			
			var label:Label = new Label(posX + posTextX, posY + 5, 200, 30, "Arial", 24, 0xFFFFFF, text, false);
			this.addChild(label);
			
			/*события*/
			//this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUpButton);
		}
		
		/*
		private function onMouseClickButton(e:MouseEvent):void 
		{
			
		}
		*/
		
		private function onMouseUpButton(e:MouseEvent):void 
		{
			this.scaleX += 0.01; this.scaleY += 0.01;
			this.x -= 1; this.y -= 1;
		}
		
		private function onMouseDownButton(e:MouseEvent):void 
		{
			this.scaleX -= 0.01; this.scaleY -= 0.01;
			this.x += 1; this.y += 1;
		}
		
		private function onMouseOutButton(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		private function onMouseOverButton(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.BUTTON;
		}
	}

}
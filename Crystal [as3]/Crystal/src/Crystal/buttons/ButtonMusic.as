package Crystal.buttons 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import Crystal.text.Label;
	import Crystal.resource.Resource;
	import Crystal.kernel.Atlas;
	
	public class ButtonMusic extends Sprite 
	{
		private var _buttonOn:Bitmap;
		private var _buttonOff:Bitmap;
		
		public function ButtonMusic(posX:int, posY:int) 
		{
			
			_buttonOn = new Bitmap(Atlas.AtlasGetBitmap(Resource.ButtonMusicImage, 70, 35, 35, 35, true, 0x000000000000, 0, 0, 35, 35, 0, 0).bitmapData);
			_buttonOn.x = posX; _buttonOn.y = posY;
			this.addChild(_buttonOn);
			
			_buttonOff = new Bitmap(Atlas.AtlasGetBitmap(Resource.ButtonMusicImage, 70, 35, 35, 35, true, 0x000000000000, 35, 0, 35, 35, 0, 0).bitmapData);
			_buttonOff.x = posX; _buttonOff.y = posY;
			this.addChild(_buttonOff);
			
			if (Resource.Music) {
				_buttonOn.visible = true;
				_buttonOff.visible = false;
			}else {
				_buttonOn.visible = false;
				_buttonOff.visible = true;
			}
			
			/*события*/
			this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUpButton);
			
			this.width = 35; this.height = 35;
		}
		
		private function onMouseClickButton(e:MouseEvent):void 
		{
			if (Resource.Music) {
				Resource.Music = false;
				_buttonOn.visible = false;
				_buttonOff.visible = true;
			}else {
				Resource.Music = true;
				_buttonOn.visible = true;
				_buttonOff.visible = false;
			}
		}
				
		private function onMouseUpButton(e:MouseEvent):void 
		{
			this.scaleX += 0.01;
			this.scaleY += 0.01;
			this.x -= 1;
			this.y -= 1;
		}
		
		private function onMouseDownButton(e:MouseEvent):void 
		{
			this.scaleX -= 0.01;
			this.scaleY -= 0.01;
			this.x += 1;
			this.y += 1;
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
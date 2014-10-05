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
	import Crystal.events.NavigationEvent;
	
	public class ButtonRoadblock extends Sprite 
	{
		private var _buttonOpen:Bitmap;
		private var _buttonClose:Bitmap;
		private var _levelOpen:Boolean;
		private var _levelFileXML:String;
		
		public function ButtonRoadblock(posX:int, posY:int, rectX:int, rectY:int, levelOpen:Boolean, levelFileXML:String) 
		{
			_levelFileXML = levelFileXML;
			_levelOpen = levelOpen;
			
			_buttonClose = new Bitmap(Atlas.AtlasGetBitmap(Resource.MapRoadblocksImages, 432, 318, 108, 106, true, 0x000000000000, rectX, rectY, 108, 106, 0, 0).bitmapData);
			_buttonClose.x = posX; _buttonClose.y = posY;
			this.addChild(_buttonClose);
			
			_buttonOpen = new Bitmap(Atlas.AtlasGetBitmap(Resource.MapRoadblocksImages, 432, 318, 108, 106, true, 0x000000000000, rectX + 108, rectY, 108, 106, 0, 0).bitmapData);
			_buttonOpen.x = posX; _buttonOpen.y = posY;
			this.addChild(_buttonOpen);
			
			if (_levelOpen) {
				_buttonOpen.visible = true;
				_buttonClose.visible = false;
			}else {
				_buttonOpen.visible = false;
				_buttonClose.visible = true;
			}
						
			/*события*/
			this.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUpButton);
			
			this.width = 108; this.height = 106;
		}
		
		private function onMouseClickButton(e:MouseEvent):void 
		{
			if (_levelOpen) {
				Resource.SelectFileXML = _levelFileXML;
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_WINDOW_START_LEVEL_SHOW" }, true));
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
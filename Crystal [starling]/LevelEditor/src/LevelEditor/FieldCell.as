package LevelEditor 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import LevelEditor.Resource;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class FieldCell extends Sprite 
	{
		private var _cell:Sprite = new Sprite();			// ячейка
		private var _object:Sprite = new Sprite();			// объект
		public var cellType:String = "CELL_TYPE_CLEAR";		// тип ячейки
		public var cellObject:String = "CRYSTAL_TYPE_0";				// объект ячейки
		
		
		public function FieldCell() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			
			_cell.graphics.lineStyle(1, 0x000000, 1);
			_cell.graphics.beginFill(0x0080FF, 0.5);
			_cell.graphics.drawRect(0, 0, 50, 50);
			_cell.graphics.endFill();
			
			_cell.addChild(_object);
			this.addChild(_cell);
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.BUTTON;
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			SetObject();
		}
		
		public function SetObject():void
		{
			if (Resource.SelectObject != "SELECT_NO_OBJECT") {
				if (Resource.SelectObject == "CELL_TYPE_CLEAR") {
					cellType = "CELL_TYPE_CLEAR";
					this.removeChild(_cell);
					_cell = new Sprite();
					_cell.graphics.lineStyle(1, 0x000000, 1);
					_cell.graphics.beginFill(0x0080FF, 0.5);
					_cell.graphics.drawRect(0, 0, 50, 50);
					_cell.graphics.endFill();
					_object = new Sprite();
					_cell.addChild(_object);
					this.addChild(_cell);
				}
				if (Resource.SelectObject == "CELL_TYPE_DROP") {
					cellType = "CELL_TYPE_DROP";
					this.removeChild(_cell);
					_cell = new Sprite();
					_cell.graphics.lineStyle(1, 0x000000, 1);
					_cell.graphics.beginFill(0xCC9733, 0.5);
					_cell.graphics.drawRect(0, 0, 50, 50);
					_cell.graphics.endFill();
					_object = new Sprite();
					_cell.addChild(_object);
					this.addChild(_cell);
				}
				if (Resource.SelectObject == "CRYSTAL_TYPE_1_VIOLET" && cellType != "CELL_TYPE_DROP") {
					cellObject = "CRYSTAL_TYPE_1_VIOLET";
					_object.addChild(new Bitmap((Resource.Crystal1 as Bitmap).bitmapData));
				}
				if (Resource.SelectObject == "CRYSTAL_TYPE_2_GREEN" && cellType != "CELL_TYPE_DROP") {
					cellObject = "CRYSTAL_TYPE_2_GREEN";
					_object.addChild(new Bitmap((Resource.Crystal2 as Bitmap).bitmapData));
				}
				if (Resource.SelectObject == "CRYSTAL_TYPE_3_RED" && cellType != "CELL_TYPE_DROP") {
					cellObject = "CRYSTAL_TYPE_3_RED";
					_object.addChild(new Bitmap((Resource.Crystal3 as Bitmap).bitmapData));
				}
				if (Resource.SelectObject == "CRYSTAL_TYPE_4_BLUE" && cellType != "CELL_TYPE_DROP") {
					cellObject = "CRYSTAL_TYPE_4_BLUE";
					_object.addChild(new Bitmap((Resource.Crystal4 as Bitmap).bitmapData));
				}
				if (Resource.SelectObject == "CRYSTAL_TYPE_5_YELLOW" && cellType != "CELL_TYPE_DROP") {
					cellObject = "CRYSTAL_TYPE_5_YELLOW";
					_object.addChild(new Bitmap((Resource.Crystal5 as Bitmap).bitmapData));
				}
			}
		}
		
		
		
	}

}
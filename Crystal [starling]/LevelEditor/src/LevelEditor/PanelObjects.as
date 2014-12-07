package LevelEditor 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.events.MouseEvent;
	
	import LevelEditor.Resource;
	
	import fl.controls.Label;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class PanelObjects extends Sprite 
	{
		private var _label1:Label = new Label();
		private var _sCursor:Sprite = new Sprite();
		private var _cellClear:Sprite = new Sprite();
		private var _cellDrop:Sprite = new Sprite();
		private var _crystal1:Sprite = new Sprite();
		private var _crystal2:Sprite = new Sprite();
		private var _crystal3:Sprite = new Sprite();
		private var _crystal4:Sprite = new Sprite();
		private var _crystal5:Sprite = new Sprite();
		
		
		public function PanelObjects() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			/* объекты ----------------------------*/
			/* Метка */
			_label1.text = "Объекты:";
			_label1.x = 730; _label1.y = 25;
			this.addChild(_label1);
			
			/* Курсор */
			_sCursor.addChild(Resource.Cursor);
			_sCursor.name = "sCursor";
			_sCursor.x = 730; _sCursor.y = 50;
			_sCursor.addEventListener(MouseEvent.CLICK, onMouseClick);
			_sCursor.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_sCursor.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_sCursor);
			
			/* пустая ячейка */
			_cellClear.addChild(Resource.CellClear);
			_cellClear.name = "cellClear";
			_cellClear.x = 730; _cellClear.y = 110;
			_cellClear.addEventListener(MouseEvent.CLICK, onMouseClick);
			_cellClear.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_cellClear.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_cellClear);
			
			/* удаленная ячейка */
			_cellDrop.addChild(Resource.CellDrop);
			_cellDrop.name = "cellDrop";
			_cellDrop.x = 730; _cellDrop.y = 170;
			_cellDrop.addEventListener(MouseEvent.CLICK, onMouseClick);
			_cellDrop.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_cellDrop.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_cellDrop);
			
			/* Кристал 1 */
			_crystal1.addChild(Resource.Crystal1);
			_crystal1.name = "crystal1";
			_crystal1.x = 730; _crystal1.y = 250;
			_crystal1.addEventListener(MouseEvent.CLICK, onMouseClick);
			_crystal1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_crystal1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_crystal1);
			
			/* Кристал 2 */
			_crystal2.addChild(Resource.Crystal2);
			_crystal2.name = "crystal2";
			_crystal2.x = 730; _crystal2.y = 310;
			_crystal2.addEventListener(MouseEvent.CLICK, onMouseClick);
			_crystal2.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_crystal2.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_crystal2);
			
			/* Кристал 3 */
			_crystal3.addChild(Resource.Crystal3);
			_crystal3.name = "crystal3";
			_crystal3.x = 730; _crystal3.y = 370;
			_crystal3.addEventListener(MouseEvent.CLICK, onMouseClick);
			_crystal3.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_crystal3.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_crystal3);
			
			/* Кристал 4 */
			_crystal4.addChild(Resource.Crystal4);
			_crystal4.name = "crystal4";
			_crystal4.x = 730; _crystal4.y = 430;
			_crystal4.addEventListener(MouseEvent.CLICK, onMouseClick);
			_crystal4.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_crystal4.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_crystal4);
			
			/* Кристал 5 */
			_crystal5.addChild(Resource.Crystal5);
			_crystal5.name = "crystal5";
			_crystal5.x = 730; _crystal5.y = 490;
			_crystal5.addEventListener(MouseEvent.CLICK, onMouseClick);
			_crystal5.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_crystal5.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_crystal5);
			
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			if (e.target.name == "sCursor")	Resource.SelectObject = "SELECT_NO_OBJECT";
			if (e.target.name == "cellClear")	Resource.SelectObject = "CELL_TYPE_CLEAR";
			if (e.target.name == "cellDrop")	Resource.SelectObject = "CELL_TYPE_DROP";
			if (e.target.name == "crystal1")	Resource.SelectObject = "CRYSTAL_TYPE_1_VIOLET";
			if (e.target.name == "crystal2")	Resource.SelectObject = "CRYSTAL_TYPE_2_GREEN";
			if (e.target.name == "crystal3")	Resource.SelectObject = "CRYSTAL_TYPE_3_RED";
			if (e.target.name == "crystal4")	Resource.SelectObject = "CRYSTAL_TYPE_4_BLUE";
			if (e.target.name == "crystal5")	Resource.SelectObject = "CRYSTAL_TYPE_5_YELLOW";
		}
		
		
		/* Общие события мыши */
		private function onMouseOver(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.BUTTON;
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
		
	}

}
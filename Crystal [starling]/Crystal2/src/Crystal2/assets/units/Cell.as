package Crystal2.assets.units 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Quad;
	
	import Crystal2.assets.resource.Resource;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Cell extends Sprite 
	{
		public var cellType:String = "CELL_TYPE_CLEAR";	// тип ячейки
		private var _cellBG:Quad;
		private var _cell:Quad;
		
		public function Cell() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if (cellType == "CELL_TYPE_EMPTY") this.visible = false;
			if (cellType == "CELL_TYPE_CLEAR") {
				_cellBG = new Quad(Resource.CELL_WIDTH, Resource.CELL_HEIGHT, 0x8000FF, true);
				_cellBG.alpha = 0.4;
				this.addChild(_cellBG);
				_cell = new Quad(Resource.CELL_WIDTH, Resource.CELL_HEIGHT, 0x000000, true);
				_cell.width = 48; _cell.height = 48;
				_cell.alpha = 0.6;
				this.addChild(_cell);
			}
			
		}
		
	}

}
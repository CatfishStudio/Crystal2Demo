package Crystal.units 
{
	import flash.display.Shape;
	import flash.events.Event;
	
	public class Cell extends Shape 
	{
		public var cellType:String = "CELL_TYPE_CLEAR";				// тип ячейки
		
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
				this.graphics.lineStyle(1, 0x000000, 1);
				this.graphics.beginFill(0xFFFFFF, 1);
				this.graphics.drawRect(0, 0, 50, 50);
				this.graphics.endFill();
				this.alpha = 0.4;
			}
			if (cellType == "CELL_TYPE_DROP") {
				this.graphics.lineStyle(1, 0x000000, 1);
				this.graphics.beginFill(0xFFFFFF, 1);
				this.graphics.drawRect(0, 0, 50, 50);
				this.graphics.endFill();
				
				this.graphics.lineStyle(1, 0x000000, 1);
				this.graphics.beginFill(0xFFFFFF, 1);
				this.graphics.drawCircle(25, 50, 15);
				this.graphics.endFill();
				
				this.alpha = 0.4;
			}
		}
		
	}

}
package Crystal.units 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import Crystal.kernel.Atlas;
	import Crystal.resource.Resource;
	import Crystal.units.Cell;
	
	public class Unit extends Sprite 
	{
		public var unitType:String;
		public var flagRemove:Boolean = false;
		public var flagModification:Boolean = false;
		public var typeModification:int;
		public var posColumnI:int = 0;
		public var posRowJ:int = 0;
		public var posX:int = 0;
		public var posY:int = 0;
		
		private var _imgObject:Bitmap;
		
		public function Unit() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if ((Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType == "CELL_TYPE_EMPTY") this.visible = false;
			
			if (unitType == "CRYSTAL_TYPE_1_VIOLET" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 0, 5, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_1_VIOLET_LINE_HORIZONTALLY" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 50, 5, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_1_VIOLET_LINE_UPRIGHT" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 104, 5, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_1_VIOLET_SUPER" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 155, 5, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			
			if (unitType == "CRYSTAL_TYPE_2_GREEN" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 0, 53, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_2_GREEN_LINE_HORIZONTALLY" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 50, 53, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_2_GREEN_LINE_UPRIGHT" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 104, 53, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_2_GREEN_SUPER" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 155, 53, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			
			if (unitType == "CRYSTAL_TYPE_3_RED" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 0, 101, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_3_RED_LINE_HORIZONTALLY" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 50, 101, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_3_RED_LINE_UPRIGHT" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 104, 101, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_3_RED_SUPER" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 155, 101, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			
			if (unitType == "CRYSTAL_TYPE_4_BLUE" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 0, 149, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_4_BLUE_LINE_HORIZONTALLY" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 50, 149, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_4_BLUE_LINE_UPRIGHT" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 104, 149, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_4_BLUE_SUPER" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 155, 149, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			
			if (unitType == "CRYSTAL_TYPE_5_YELLOW" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 0, 197, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_5_YELLOW_LINE_HORIZONTALLY" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 50, 197, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_5_YELLOW_LINE_UPRIGHT" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 104, 197, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			if (unitType == "CRYSTAL_TYPE_5_YELLOW_SUPER" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 45, 45, true, 0x000000000000, 155, 197, 45, 45, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 3; this.y += 6;
			}
			
			if (unitType == "CRYSTAL_TYPE_9_STONE" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 50, 50, true, 0x000000000000, 70, 245, 50, 50, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x -= 1; this.y += 1;
			}
			if (unitType == "CRYSTAL_TYPE_10_RUNE" && (Resource.MatrixCell[posColumnI][posRowJ] as Cell).cellType != "CELL_TYPE_EMPTY") {
				_imgObject = new Bitmap(Atlas.AtlasGetBitmap(Resource.UnitsImage, 200, 300, 50, 50, true, 0x000000000000, 5, 242, 50, 50, 0, 0).bitmapData);
				this.addChild(_imgObject);
				this.x += 0; this.y += 1;
			}
		}
		
	}

}
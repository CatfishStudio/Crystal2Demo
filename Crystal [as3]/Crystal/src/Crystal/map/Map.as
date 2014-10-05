package Crystal.map 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import Crystal.resource.Resource;
	import Crystal.buttons.ButtonRoadblock;	
	import Crystal.windows.Dialog;
	
	
	public class Map extends Sprite 
	{
		private var _map:Sprite;		// карта
		private var _mapBitmap:Bitmap;	// рисунок карты
		private var _mapMouseX:Number;	// позиция курсора
		private var _mapMouseY:Number;	// позиция курсора
		private var _mapMove:Boolean = false;	// флаг движения курсора (скрол карты)
		private var _mapBorder:Bitmap;
		
		private var _mapRoadblock1:ButtonRoadblock;
		private var _mapRoadblock2:ButtonRoadblock;
		private var _mapRoadblock3:ButtonRoadblock;
		private var _mapRoadblock4:ButtonRoadblock;
		private var _mapRoadblock5:ButtonRoadblock;
		
		private var _dialog:Dialog;
		
		public function Map() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_mapBitmap = new Bitmap(Resource.MapImage.bitmapData);
			_mapBitmap.x = 0; _mapBitmap.y = -400;
			
			_map = new Sprite();
			_map.addChild(_mapBitmap);
			_map.addEventListener(MouseEvent.MOUSE_DOWN, onMapMauseDown);
			_map.addEventListener(MouseEvent.MOUSE_UP, onMapMauseUp);
			_map.addEventListener(MouseEvent.MOUSE_MOVE, onMapMauseMove);
						
			this.addChild(_map);
			
			_mapRoadblock1 = new ButtonRoadblock(200, 200, 0, 0, Resource.MapLevel1, "resource/levels/level1.xml");
			_map.addChild(_mapRoadblock1);
			_mapRoadblock2 = new ButtonRoadblock(280, 360, 216, 0, Resource.MapLevel2, "resource/levels/level2.xml");
			_map.addChild(_mapRoadblock2);
			_mapRoadblock3 = new ButtonRoadblock(530, 420, 0, 106, Resource.MapLevel3, "resource/levels/level3.xml");
			_map.addChild(_mapRoadblock3);
			_mapRoadblock4 = new ButtonRoadblock(550, 280, 216, 106, Resource.MapLevel4, "resource/levels/level4.xml");
			_map.addChild(_mapRoadblock4);
			_mapRoadblock5 = new ButtonRoadblock(500, 100, 0, 212, Resource.MapLevel5, "resource/levels/level5.xml");
			_map.addChild(_mapRoadblock5);
			
			_mapBorder = new Bitmap(Resource.MapBorderImage.bitmapData);
			this.addChild(_mapBorder);
			
			_dialog = new Dialog();
			_dialog.x = 90; _dialog.y = 70;
			this.addChild(_dialog);
		}
		
		private function onMapMauseDown(e:MouseEvent):void 
		{
			_mapMouseX = e.localX;
			_mapMouseY = e.localY;
			_mapMove = true;
			Mouse.cursor = MouseCursor.HAND;
		}
		
		private function onMapMauseUp(e:MouseEvent):void 
		{
			_mapMouseX = e.localX;
			_mapMouseY = e.localY;
			_mapMove = false;
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		private function onMapMauseMove(e:MouseEvent):void 
		{
			if (_mapMove) {
				
				if (_mapMouseX < e.localX) { // движение вправо
					if (_map.x < 0 && _map.x < 880)	_map.x += 15;
				}else if (_map.x > -800) _map.x -= 15; // движение влево
								
				if (_mapMouseY < e.localY) { // движение вниз
					if(_map.y < 350 && _map.y < 1050) _map.y += 15;
				}else if (_map.y > -10) _map.y -= 15; // движение вверх
				
				//_mapMouseX = e.localX;
				//_mapMouseY = e.localY;
			}
		}
		
		
		
		
		
		
	}

}
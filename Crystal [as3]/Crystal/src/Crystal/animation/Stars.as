package Crystal.animation 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Stars extends MovieClip 
	{
		// полная картинка
		private var _imageBD:BitmapData = new BitmapData(250, 50, true, 0x000000000000);
		// размер выбраной картинки
		private var _canvasBD:BitmapData = new BitmapData(50, 50, true, 0x000000000000);
		private var _image:Bitmap;
		private var _loaderImage:Bitmap; 
		
		private var _rect:Rectangle = new Rectangle(0, 0, 250, 50); //исходный размер
		private var _pt:Point = new Point(0, 0); // начальная точка 
		
		[Embed(source = '../media/textures/stars.png')]
		public var LoaderImage:Class; 
		
		public function Stars(_x:int, _y:int) 
		{
			super();
			this.x = _x; this.y = _y;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_image = new LoaderImage();
			_imageBD.draw(_image); // загрузка картинки
			_rect.x = 0;
			_canvasBD.copyPixels(_imageBD, _rect, _pt);
			_loaderImage = new Bitmap(_canvasBD);
			this.addChild(_loaderImage);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.play();
		}
		
		private function onEnterFrame(e:Event):void 
		{
			_rect.x += 50;
			if (_rect.x > 250) {
				_rect.x = 0;
				this.stop();
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				this.parent.removeChild(this);	// удаляет сам себя
			}
			_canvasBD.copyPixels(_imageBD, _rect, _pt);
			_loaderImage = new Bitmap(_canvasBD);
		}
		
	}

}
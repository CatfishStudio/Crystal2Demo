package Crystal.kernel 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle; 
	
	public class Atlas 
	{
		
		public function Atlas() 
		{
			
		}
		
		public static function AtlasGetBitmap(_bitmap:Bitmap, _fullSizeWidth:int, _fullSizeHeight:int, _backSizeWidth:int,  _backSizeHeight:int,  _transparent:Boolean, _fillColor:uint, _rectX1:int, _rectY1:int, _rectX2:int, _rectY2:int, _ptX:int, _ptY:int):Bitmap
		{
			// полная картинка
			var imageBD:BitmapData = new BitmapData(_fullSizeWidth, _fullSizeHeight, _transparent, _fillColor);
			// размер выбраной картинки
			var canvasBD:BitmapData = new BitmapData(_backSizeWidth, _backSizeHeight, _transparent, _fillColor);
			//исходный размер
			var rect:Rectangle = new Rectangle(_rectX1, _rectY1, _rectX2, _rectY2);
			// начальная точка
			var pt:Point = new Point(_ptX, _ptY);  
			var bitmap:Bitmap;
			
			imageBD = _bitmap.bitmapData;
			canvasBD.copyPixels(imageBD, rect, pt);
			bitmap = new Bitmap(canvasBD);
			
			return bitmap;
		}
	}

}
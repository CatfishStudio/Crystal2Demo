package LoadGame
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import LoadGame.GameLoad;
	
	/**
	 * ...
	 * @author Catfish Studio
	 */
	
	[SWF(width="800", height="600", frameRate="30", backgroundColor="#ffffff")]
	public class Main extends Sprite
	{
		private var _gameLoad:GameLoad;
		private var _request:URLRequest = new URLRequest("Crystal2.swf");
		private var _loader:Loader = new Loader();
			
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_gameLoad = new GameLoad();
			this.addChild(_gameLoad);
			
			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, LoadComplite);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, LoadError);
			_loader.load(_request);
			this.addChild(_loader);
		}
		
		private function LoadError(e:IOErrorEvent):void 
		{
			
		}
		
		private function LoadComplite(e:Event):void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, LoadComplite); 
			this.removeChild(_gameLoad);
		}
	
	}

}
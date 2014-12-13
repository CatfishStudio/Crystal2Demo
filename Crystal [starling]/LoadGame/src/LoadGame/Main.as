package LoadGame
{
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	import flash.system.Security;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.external.ExternalInterface;
	import LoadGame.GameLoad;
	
	
	/**
	 * ...
	 * @author Catfish Studio
	 */
	
	[SWF(width="800", height="600", frameRate="30", backgroundColor="#ffffff")]
	public class Main extends Sprite
	{
		private var _gameLoad:GameLoad;
		private var _request:URLRequest;
		private var _loader:Loader;
		private var _loaderContext:LoaderContext
		
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
			
			//Security.allowDomain(_loader.contentLoaderInfo.url);
			//Security.allowDomain("https://app.vk.com");
			//Security.loadPolicyFile("https://app.vk.com/c420925/u99302165/e9cb1c679adc18.swf");
			//Security.allowDomain("*");
			
			/*
			if (ExternalInterface.available)
			{
				var urle:String = ExternalInterface.call("window.location.href.toString");
				var protocol:String = urle.slice(0, 5);
			}else protocol = "https";
			*/
			
			_loader = new Loader();
			_loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
			//if (protocol == "https") _request = new URLRequest("https://app.vk.com/c420925/u99302165/e9cb1c679adc18.swf");
			//else _request = new URLRequest("http://app.vk.com/c420925/u99302165/e9cb1c679adc18.swf");
			
			_request = new URLRequest("https://app.vk.com/c420925/u99302165/e9cb1c679adc18.swf");
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, LoadComplite);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, LoadError);
			_loader.load(_request, _loaderContext);
			
		}
		
		private function LoadError(e:IOErrorEvent):void 
		{
			_gameLoad.progressText.text = "Ошибка загрузки! ";
			trace("Error!!! " + e.toString() );
		}
		
		private function LoadComplite(e:Event):void
		{
			_gameLoad.progressText.text = "Загрузка завершена! ";
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, LoadComplite); 
			this.removeChild(_gameLoad);
			
			this.addChild(_loader);
		
		}
	
	}

}
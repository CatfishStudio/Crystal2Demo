package Crystal2
{
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import starling.core.Starling;
	import starling.display.Stage;
	
	import Crystal2.Stats;
	
	[SWF(width="800", height="600", frameRate="30", backgroundColor="#ffffff")]
	public class Main extends Sprite 
	{
		private var _loadResource:LoadResource;
		private var _starling:Starling;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.addChild(new Stats); // панель статистики
			_loadResource = new LoadResource();
			_loadResource.addEventListener(Event.CLEAR, onLoadComplete);
			this.addChild(_loadResource);
		}
		
		private function onLoadComplete(e:Event):void
		{
			this.removeChild(_loadResource);
			initStarling(); // инициализация Старлинг
		}
		
		/* Инициализация Старлинга */
		private function initStarling():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener (Event.RESIZE, resizeListenerFlash);
			_starling = new Starling(Game, stage);
			_starling.antiAliasing = 1;
			_starling.start();
		}
		
		private function resizeListenerFlash(e:Event):void
		{
			Starling.current.viewPort = new Rectangle (0, 0, stage.stageWidth, stage.stageHeight);
			_starling.stage.stageWidth = 800;
			_starling.stage.stageHeight = 600;
		}
		
	}
	
}
package Crystal2.assets.animation 
{
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.text.TextField;
	import starling.display.Quad;
	
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Quest extends Sprite 
	{
		private var _tween:Tween;
		private var _bg:Quad;
		private var _panel:Quad;
		private var _window:Sprite;
		private var _countTime:int = 0;
		private var _label:TextField;
		private var _text:String;
		
		[Embed(source = '../media/textures/crystal.png')]
		private var Crystal:Class;
		private var _textureCrystal:Texture;
		private var _imageCrystal:Image;
		
		public function Quest(text:String) 
		{
			super();
			_text = text;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			/* фон */
			_bg = new Quad(800, 600,  0x000000, true); _bg.alpha = 0.5;
			this.addChild(_bg);
			
			/* Окно ------------------------------------------------------ */
			_window = new Sprite();
			
			_panel = new Quad(800, 100, 0xFFFFFF, true);
			_panel.x = 0; _panel.y = -100; _panel.alpha = 0.8; 
			_window.addChild(_panel);
			
			_textureCrystal = Texture.fromBitmap(new Crystal());
			_imageCrystal = new Image(_textureCrystal);
			_imageCrystal.x = 150; _imageCrystal.y = -110;
			_window.addChild(_imageCrystal);
			
			_label = new TextField(450, 100, _text, "Aria", 22, 0x0080FF, true);
			_label.x = 300; _label.y = -100;
			_label.hAlign = "left";
			_window.addChild(_label);
				
			this.addChild(_window);
			/* --------------------------------------------------------- */
			
			/* анимация ------------------------------------------------- */
			animation();
		}
		
		private function animation():void
		{
			_tween = new Tween(_window, 0.5);
			_tween.moveTo(0, 300);
			if (_countTime < 50) _tween.onComplete = animation;
			else {
				Starling.juggler.remove(_tween);
				this.parent.removeChild(this);
			}
			_tween.onUpdate = function():void { _countTime++ }
			Starling.juggler.add(_tween);
		}
		
	}

}
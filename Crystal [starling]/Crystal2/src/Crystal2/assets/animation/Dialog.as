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
	
	import Crystal2.assets.resource.Resource;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Dialog extends Sprite
	{
		private var _upDown:Boolean = false;
		private var _label:TextField;
		private var _tween:Tween;
		private var _xStart:int = 70;
		private var _yStart:int = 70;
		private var _xEnd:int = 80;
		private var _yEnd:int = 80;
		
		public function Dialog() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED, onRemoveStage);
		}
		
		private function onRemoveStage(e:Event):void 
		{
			Starling.juggler.remove(_tween);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var atlasAll:TextureAtlas = new TextureAtlas(Texture.fromBitmap(Resource.Image_AtlasAll), Resource.FileXML_AtlasAll);
			
			if (Resource.MapLevel1 == true && Resource.MapLevel2 == false) {
				this.x = 70; this.y = 70;
				this.addChild(new Image(atlasAll.getTexture("dialog.png")));
				_label = new TextField(250, 100, "Приключения \nначинаются.\nМы отправляемся \nна поиски кристала.", "Arial", 18, 0xFFFFFF, true);
				_label.x = -25;
				this.addChild(_label);
			}
			
			animation();
			
			//_tween = new Tween(this, 1.0, Transitions.EASE_IN_OUT);
			//_tween.animate("x", this.x + 5); _tween.animate("y", this.y + 5);
			//_tween.onComplete = function():void { trace("END!"); };
			//_tween.fadeTo(1);
			
			//_tween = new Tween(this, 1.0);
			//_tween.repeatCount = 10;
			//_tween.moveTo(this.x + 5, this.y + 5);
			//_tween.onComplete = function():void { Starling.juggler.remove(_tween); }
			//Starling.juggler.add(_tween);
			
		}
		
		private function animation():void
		{
			_tween = new Tween(this, 1.0);
			if (this.x == _xStart && this.y == _yStart) _tween.moveTo(_xEnd, _yEnd);
			if (this.x == _xEnd && this.y == _yEnd) _tween.moveTo(_xStart, _yStart);
			_tween.onComplete = animation;
			Starling.juggler.add(_tween);
		}
		
	}

}
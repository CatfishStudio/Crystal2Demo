package Crystal2.assets.animation 
{
	import starling.display.Sprite;
	import starling.core.Starling;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.events.Event; 
	
	import Crystal2.assets.resource.Resource;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Stars extends Sprite 
	{
		private var _movie:MovieClip;
		
		public function Stars() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//Создание Movie Clip
            _movie = new MovieClip(Resource.AtlasAll.getTextures("stars_amin_"), 10);
			_movie.addEventListener(Event.COMPLETE, onComplete);
            _movie.loop = false; // постоянный повтор
            this.addChild(_movie);
            //Выполнение анимации
            Starling.juggler.add(_movie); 
		}
		
		private function onComplete(e:Event):void 
		{
			Starling.juggler.remove(_movie); 
			this.removeChild(_movie); 
			this.parent.removeChild(this);
		}
		
		
	}

}
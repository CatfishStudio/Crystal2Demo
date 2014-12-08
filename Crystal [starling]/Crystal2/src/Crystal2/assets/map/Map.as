package Crystal2.assets.map 
{
	import Crystal2.assets.animation.Dialog;
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import Crystal2.assets.resource.Resource;
	import Crystal2.assets.events.NavigationEvent;
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Map extends Sprite 
	{
		private var _btnExit:Button;		// кнопка выход в меню
		private var _roadblock1:Button;		// роадблок 1-го уровня
		private var _roadblock2:Button;		// роадблок 2-го уровня
		private var _roadblock3:Button;		// роадблок 3-го уровня
		private var _roadblock4:Button;		// роадблок 4-го уровня
		private var _roadblock5:Button;		// роадблок 5-го уровня
		private var _panelImage:Image;		// панель на карте
		private var _map:Sprite;			// карта
		private var _mapMouseX:Number;		// позиция курсора
		private var _mapMouseY:Number;		// позиция курсора
		private var _mapMove:Boolean = false;	// флаг движения курсора (скрол карты)
		private var _dialog:Dialog;			// диалог героя
		
		public function Map() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.TRIGGERED, onClick);
			
			var atlasAll:TextureAtlas = new TextureAtlas(Texture.fromBitmap(Resource.Image_AtlasAll), Resource.FileXML_AtlasAll);
			var atlasPanel:TextureAtlas = new TextureAtlas(Texture.fromBitmap(Resource.Image_AtlasPanel), Resource.FileXML_AtlasPanel);
			
			/* Карта -------------------------------------------------------------------------*/
			_map = new Sprite();
			_map.addChild(new Image(Texture.fromBitmap(Resource.Image_Map)));
			_map.x = 0; _map.y = -400;
			_map.addEventListener(TouchEvent.TOUCH, onMapTouch);
			
			/* Роадблоки */
			if (Resource.LecelComplete >= 0) _roadblock1 = new Button(atlasAll.getTexture("roadblock_level_1_map1.png"), "");
			else _roadblock1 = new Button(atlasAll.getTexture("roadblock_level_1_lock_map1.png"), "");
			_roadblock1.x = 200; _roadblock1.y = 600;
			_map.addChild(_roadblock1);
			
			if (Resource.LecelComplete > 1) _roadblock2 = new Button(atlasAll.getTexture("roadblock_level_2_map1.png"), "");
			else _roadblock2 = new Button(atlasAll.getTexture("roadblock_level_2_lock_map1.png"), "");
			_roadblock2.x = 250; _roadblock2.y = 750;
			_map.addChild(_roadblock2);
			
			if (Resource.LecelComplete > 2) _roadblock3 = new Button(atlasAll.getTexture("roadblock_level_3_map1.png"), "");
			else _roadblock3 = new Button(atlasAll.getTexture("roadblock_level_3_lock_map1.png"), "");
			_roadblock3.x = 550; _roadblock3.y = 820;
			_map.addChild(_roadblock3);
			
			if (Resource.LecelComplete > 3) _roadblock4 = new Button(atlasAll.getTexture("roadblock_level_4_map1.png"), "");
			else _roadblock4 = new Button(atlasAll.getTexture("roadblock_level_4_lock_map1.png"), "");
			_roadblock4.x = 640; _roadblock4.y = 660;
			_map.addChild(_roadblock4);
			
			if (Resource.LecelComplete > 4) _roadblock5 = new Button(atlasAll.getTexture("roadblock_level_5_map1.png"), "");
			else _roadblock5 = new Button(atlasAll.getTexture("roadblock_level_5_lock_map1.png"), "");
			_roadblock5.x = 500; _roadblock5.y = 500;
			_map.addChild(_roadblock5);
			
			this.addChild(_map);
			/*-------------------------------------------------------------*/
			
			/* Панель */
			_panelImage = new Image(atlasPanel.getTexture("panel_1_map_1.png"));
			_panelImage.x = 0; _panelImage.y = 145;
			this.addChild(_panelImage);
			_panelImage = new Image(atlasPanel.getTexture("panel_2_map_1.png"));
			_panelImage.x = 0; _panelImage.y = 0;
			this.addChild(_panelImage);
			_panelImage = new Image(atlasPanel.getTexture("panel_3_map_1.png"));
			_panelImage.x = 32; _panelImage.y = 0;
			this.addChild(_panelImage);
			_panelImage = new Image(atlasPanel.getTexture("panel_4_map_1.png"));
			_panelImage.x = 615; _panelImage.y = 0;
			this.addChild(_panelImage);
			_panelImage = new Image(atlasPanel.getTexture("panel_5_map_1.png"));
			_panelImage.x = 759; _panelImage.y = 215;
			this.addChild(_panelImage);
			_panelImage = new Image(atlasPanel.getTexture("panel_6_map_1.png"));
			_panelImage.x = 144; _panelImage.y = 567;
			this.addChild(_panelImage);
			
			/* Диалог героя */
			_dialog = new Dialog();
			this.addChild(_dialog);
			
			/* Кнопка выход */
			_btnExit = new Button(atlasAll.getTexture("button_3.png"), "Выход", atlasAll.getTexture("button_2.png"));
			_btnExit.fontColor = 0xffffff;	_btnExit.fontSize = 18; _btnExit.fontName = "Arial";
			_btnExit.x = 70; _btnExit.y = 540;
			this.addChild(_btnExit);
		}
		
		/* Перемещение карты */
		private function onMapTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if(touch){
				if (touch.phase == TouchPhase.BEGAN)
				{
					_mapMouseX = touch.globalX;
					_mapMouseY = touch.globalY;
					_mapMove = true;
				} 
				if (touch.phase == TouchPhase.ENDED)
				{
					_mapMouseX = touch.globalX;
					_mapMouseY = touch.globalY;
					_mapMove = false;
				}
				if (touch.phase == TouchPhase.MOVED)
				{
					if (_mapMove) {
						if (_mapMouseX < touch.globalX) {
							if(_map.x < 0 && _map.x < 880) _map.x += 10;
						}
						if (_mapMouseX > touch.globalX) {
							if(_map.x > -880) _map.x -= 10;
						}
						if (_mapMouseY < touch.globalY) {
							if(_map.y < 0 && _map.y < 1050) _map.y += 10;
						}
						if (_mapMouseY > touch.globalY) {
							if(_map.y > -450) _map.y -= 10;
						}
						_mapMouseX = touch.globalX;
						_mapMouseY = touch.globalY;
					
					}
				}
			}
		}
		
		private function onClick(e:Event):void
		{
			if ((e.target as Button) == _btnExit) {
				this.removeChild(_dialog)
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "EXIT_START_MENU" }, true));
			}
		} 
		
	}

}
package Crystal2.assets.level 
{
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.text.TextField;
	import starling.animation.Tween;
	import starling.core.Starling;
	
	import Crystal2.assets.resource.Resource;
	import Crystal2.assets.events.NavigationEvent;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	 
	public class LevelDialog extends Sprite
	{
		private var _tween:Tween;
		private var _atlasAll:TextureAtlas;
		
		private var _window:Sprite;
		private var _panel:Quad;
		private var _bg:Quad;
		private var _bgPanel:Quad;
		
		private var _borderImage1:Image;
		private var _borderImage2:Image;
		private var _Star1Image:Image;
		private var _Star2Image:Image;
		private var _Star3Image:Image;
		private var _labelLevel:TextField;
		private var _labelStar1:TextField;
		private var _labelStar2:TextField;
		private var _labelStar3:TextField;
		private var _labelQuest:TextField;
		
		private var _btnPlay:Button;
		private var _btnClose:Button;
		
		private var _xmlLevel:XML;
		
		public function LevelDialog() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.TRIGGERED, onClick);
			
			_atlasAll = new TextureAtlas(Texture.fromBitmap(Resource.Image_AtlasAll), Resource.FileXML_AtlasAll);
			
			/* фон */
			_bg = new Quad(800, 600,  0x000000, true);
			_bg.alpha = 0.5;
			this.addChild(_bg);
			
			/* Окно ------------------------------------------------------ */
			_window = new Sprite();
			
			// панели
			panels();
			
			// верхний бордюр
			_borderImage1 = new Image(_atlasAll.getTexture("windowBorder_1.png"));
			_borderImage1.x = 5; _borderImage1.y = 5;
			_window.addChild(_borderImage1);
			
			// чтение xml файла уровня
			readXML();
			
			// метка номер уровня
			labelLevelNum();
			
			// звёзды
			stars();
			
			// Задание на уровень
			quest(Resource.LevelQuest);
			
			// Кнопки
			buttons();
			
			// нижний бордюр
			_borderImage2 = new Image(_atlasAll.getTexture("windowBorder_2.png"));
			_borderImage2.x = 5; _borderImage2.y = 405;
			_window.addChild(_borderImage2);
			
			_window.x = 200; _window.y = -400;
			this.addChild(_window);
			/* --------------------------------------------------------- */
			
			/* анимация ------------------------------------------------- */
			_tween = new Tween(_window, 0.2);
			_tween.moveTo(200, 100);
			_tween.onComplete = function():void { Starling.juggler.remove(_tween); }
			Starling.juggler.add(_tween);
		}
		
		private function panels():void
		{
			_bgPanel = new Quad(410, 460, 0x8000FF, true);
			_bgPanel.alpha = 0.5;
			_window.addChild(_bgPanel);
			_panel = new Quad(400, 450, 0xFFFFFF, false);
			_panel.x = 5; _panel.y = 5;
			_window.addChild(_panel);
		}
		
		private function labelLevelNum():void
		{
			_labelLevel = new TextField(250, 100, "Уровень " + (Resource.LevelComplete + 1), "Arial", 32, 0x8000FF, true);
			_labelLevel.x = 80; _labelLevel.y = 20;
			_window.addChild(_labelLevel);
		}
		
		private function stars():void
		{
			if ((Resource.Progress[Resource.LevelComplete][1] as int) == 0) {
				_Star1Image = new Image(_atlasAll.getTexture("star_1.png"));
				_labelStar1 = new TextField(_Star1Image.width, 50, Resource.MapLevelScoreStar1.toString(), "Arial", 28, 0x8000FF, true);
			}else {
				_Star1Image = new Image(_atlasAll.getTexture("star_2.png"));
				_labelStar1 = new TextField(_Star1Image.width, 50, (Resource.Progress[Resource.LevelComplete][1] as int).toString(), "Arial", 28, 0x8000FF, true);
			}
			_Star1Image.x = 10; _Star1Image.y = 150; 
			_window.addChild(_Star1Image);
			_labelStar1.x = _Star1Image.x; _labelStar1.y = _Star1Image.y + _Star1Image.height - 20; _labelStar1.hAlign = "center";	
			_window.addChild(_labelStar1);
			
			
			if ((Resource.Progress[Resource.LevelComplete][2] as int) == 0) {
				_Star2Image = new Image(_atlasAll.getTexture("star_1.png"));
				_labelStar2 = new TextField(_Star2Image.width, 50, Resource.MapLevelScoreStar2.toString(), "Arial", 28, 0x8000FF, true);
			} else {
				_Star2Image = new Image(_atlasAll.getTexture("star_2.png"));
				_labelStar2 = new TextField(_Star2Image.width, 50, (Resource.Progress[Resource.LevelComplete][2] as int).toString(), "Arial", 28, 0x8000FF, true);
			}
			_Star2Image.x = 140; _Star2Image.y = 100;
			_window.addChild(_Star2Image);
			_labelStar2.x = _Star2Image.x; _labelStar2.y = _Star2Image.y + _Star2Image.height - 20; _labelStar2.hAlign = "center";	
			_window.addChild(_labelStar2);
			
			
			if ((Resource.Progress[Resource.LevelComplete][3] as int) == 0) {
				_Star3Image = new Image(_atlasAll.getTexture("star_1.png"));
				_labelStar3 = new TextField(_Star3Image.width, 50, Resource.MapLevelScoreStar3.toString(), "Arial", 28, 0x8000FF, true);
			} else {
				_Star3Image = new Image(_atlasAll.getTexture("star_2.png"));
				_labelStar3 = new TextField(_Star3Image.width, 50, (Resource.Progress[Resource.LevelComplete][3] as int).toString(), "Arial", 28, 0x8000FF, true);
			}
			_Star3Image.x = 270; _Star3Image.y = 150;
			_window.addChild(_Star3Image);
			_labelStar3.x = _Star3Image.x; _labelStar3.y = _Star3Image.y + _Star3Image.height - 20; _labelStar3.hAlign = "center";	
			_window.addChild(_labelStar3);
		}
		
		private function quest(id:String):void
		{
			if (id == "LEVEL_TYPE_COLLECT")	_labelQuest = new TextField(250, 100, "Задание: Собрать кристалы.", "Aria", 22, 0x8000FF, true);
			if (id == "LEVEL_TYPE_SCORE_POINTS")	_labelQuest = new TextField(250, 100, "Задание: Набрать очки.", "Aria", 22, 0x8000FF, true);
			if (id == "LEVEL_TYPE_TIME")	_labelQuest = new TextField(250, 100, "Задание: Успеть за время.", "Aria", 22, 0x8000FF, true);
			_labelQuest.x = 0; _labelQuest.y = 270;
			_labelQuest.width = 400;
			_window.addChild(_labelQuest);
		}
		
		private function readXML():void
		{
			_xmlLevel = new XML((Resource.FilesXML_Levels[Resource.LevelComplete + 1] as XML));
			Resource.MapLevelScoreStar1 = _xmlLevel.AmountScoreStar1;
			Resource.MapLevelScoreStar2 = _xmlLevel.AmountScoreStar2;
			Resource.MapLevelScoreStar3 = _xmlLevel.AmountScoreStar3;
			Resource.LevelQuest = _xmlLevel.LevelType;
		}
		
		private function buttons():void
		{
			/* Кнопка Play */
			_btnPlay = new Button(_atlasAll.getTexture("button_3.png"), "Играть", _atlasAll.getTexture("button_2.png"));
			_btnPlay.fontColor = 0xffffff;	_btnPlay.fontSize = 18; _btnPlay.fontName = "Arial";
			_btnPlay.x = 25; _btnPlay.y = 350; _btnPlay.name = "Play";
			_window.addChild(_btnPlay);
			/* Кнопка Close */
			_btnClose = new Button(_atlasAll.getTexture("button_3.png"), "Закрыть", _atlasAll.getTexture("button_2.png"));
			_btnClose.fontColor = 0xffffff;	_btnClose.fontSize = 18; _btnClose.fontName = "Arial";
			_btnClose.x = 210; _btnClose.y = 350; _btnClose.name = "Close";
			_window.addChild(_btnClose);
		}
		
		private function onClick(e:Event):void
		{
			if ((e.target as Button).name == "Play") this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "LEVEL_PLAY" }, true));
			if ((e.target as Button).name == "Close") this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "LEVEL_DIALOG_CLOSE" }, true));
		}
	}

}
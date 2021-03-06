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
	 * @author Catfish Studio
	 */
	public class LevelDialogResult extends Sprite 
	{
		private var _tween:Tween;
		
		private var _window:Sprite;
		private var _panel:Quad;
		private var _bg:Quad;
		private var _bgPanel:Quad;
		private var _bgPanel2:Quad;
		
		private var _borderImage1:Image;
		private var _borderImage2:Image;
		private var _Star1Image:Image;
		private var _Star2Image:Image;
		private var _Star3Image:Image;
		private var _labelStatus:TextField;
		private var _labelStar1:TextField;
		private var _labelStar2:TextField;
		private var _labelStar3:TextField;
		private var _labelResult:TextField;
		
		private var _btnNext:Button;
		private var _btnContinue:Button;
		private var _btnPost:Button;
		private var _btnClose:Button;
		
		private var _status:String;
		
		public function LevelDialogResult(status:String) 
		{
			super();
			_status = status;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.addEventListener(Event.TRIGGERED, onClick);
			
			/* фон */
			_bg = new Quad(800, 600,  0x000000, true);
			_bg.alpha = 0.5;
			this.addChild(_bg);
			
			/* Окно ------------------------------------------------------ */
			_window = new Sprite();
			
			// панели
			panels();
			
			// верхний бордюр
			_borderImage1 = new Image(Resource.AtlasAll.getTexture("windowBorder_1.png"));
			_borderImage1.x = 5; _borderImage1.y = 5;
			_window.addChild(_borderImage1);
			
			// метка номер уровня
			if (_status == "WIN") _labelStatus = new TextField(250, 100, "Вы выиграли!", "Arial", 32, 0x8000FF, true);
			if (_status == "LOSE" || _status == "EXIT")_labelStatus = new TextField(250, 100, "Уровень проигран!", "Arial", 32, 0x8000FF, true);
			_labelStatus.x = 80; _labelStatus.y = 20;
			_window.addChild(_labelStatus);
			
			// звёзды
			stars();
			
			// Результат уровня
			if (_status == "WIN") _labelResult = new TextField(250, 100, "Все условия выполнены успешно.", "Aria", 22, 0x8000FF, true);
			if (_status == "LOSE" || _status == "EXIT") _labelResult = new TextField(250, 100, "Вы не выполнили задание.", "Aria", 22, 0x8000FF, true);
			_labelResult.x = 0; _labelResult.y = 270;
			_labelResult.width = 400;
			_window.addChild(_labelResult);
			
			// Кнопки
			buttons();
			
			// нижний бордюр
			_borderImage2 = new Image(Resource.AtlasAll.getTexture("windowBorder_2.png"));
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
			
			_bgPanel2 = new Quad(250, 250, 0x8000FF, false);
			_bgPanel2.alpha = 0.2;
			_bgPanel2.x = 208; _bgPanel2.y = 54;
			_bgPanel2.rotation = 0.8;
			_window.addChild(_bgPanel2);
		}
		
		private function stars():void
		{
				if ((Resource.Progress[Resource.SelectLevel][1] as int) < Resource.AmountScoreStar1) _Star1Image = new Image(Resource.AtlasAll.getTexture("star_1.png"));
				else _Star1Image = new Image(Resource.AtlasAll.getTexture("star_2.png"));
				_labelStar1 = new TextField(_Star1Image.width, 50, (Resource.Progress[Resource.SelectLevel][1] as int).toString(), "Arial", 28, 0x8000FF, true);
				_Star1Image.x = 10; _Star1Image.y = 150; 
				_window.addChild(_Star1Image);
				_labelStar1.x = _Star1Image.x; _labelStar1.y = _Star1Image.y + _Star1Image.height - 20; _labelStar1.hAlign = "center";	
				_window.addChild(_labelStar1);
				
				if ((Resource.Progress[Resource.SelectLevel][2] as int) < Resource.AmountScoreStar2) _Star2Image = new Image(Resource.AtlasAll.getTexture("star_1.png"));
				else _Star1Image = new Image(Resource.AtlasAll.getTexture("star_2.png"));
				_labelStar2 = new TextField(_Star2Image.width, 50, (Resource.Progress[Resource.SelectLevel][2] as int).toString(), "Arial", 28, 0x8000FF, true);
				_Star2Image.x = 140; _Star2Image.y = 100;
				_window.addChild(_Star2Image);
				_labelStar2.x = _Star2Image.x; _labelStar2.y = _Star2Image.y + _Star2Image.height - 20; _labelStar2.hAlign = "center";	
				_window.addChild(_labelStar2);
				
				if ((Resource.Progress[Resource.SelectLevel][3] as int) < Resource.AmountScoreStar3) _Star3Image = new Image(Resource.AtlasAll.getTexture("star_1.png"));
				else _Star3Image = new Image(Resource.AtlasAll.getTexture("star_2.png"));
				_labelStar3 = new TextField(_Star3Image.width, 50, (Resource.Progress[Resource.SelectLevel][3] as int).toString(), "Arial", 28, 0x8000FF, true);
				_Star3Image.x = 270; _Star3Image.y = 150;
				_window.addChild(_Star3Image);
				_labelStar3.x = _Star3Image.x; _labelStar3.y = _Star3Image.y + _Star3Image.height - 20; _labelStar3.hAlign = "center";	
				_window.addChild(_labelStar3);
			
			
			
			
		}
		
		private function buttons():void
		{
			
			
			if (_status == "WIN") {
				/* Кнопка Next */
				_btnNext = new Button(Resource.AtlasAll.getTexture("button_3.png"), "Далее", Resource.AtlasAll.getTexture("button_2.png"));
				_btnNext.fontColor = 0xffffff;	_btnNext.fontSize = 18; _btnNext.fontName = "Arial";
				_btnNext.x = 25; _btnNext.y = 350; _btnNext.name = "Next";
				_window.addChild(_btnNext);
				/* Кнопка Post */
				_btnPost = new Button(Resource.AtlasAll.getTexture("button_3.png"), "Расказать", Resource.AtlasAll.getTexture("button_2.png"));
				_btnPost.fontColor = 0xffffff;	_btnPost.fontSize = 18; _btnPost.fontName = "Arial";
				_btnPost.x = 210; _btnPost.y = 350; _btnPost.name = "Post";
				_window.addChild(_btnPost);
			}
			if (_status == "LOSE") {
				
				
				/* Кнопка Close */
				_btnClose = new Button(Resource.AtlasAll.getTexture("button_3.png"), "Закрыть", Resource.AtlasAll.getTexture("button_2.png"));
				_btnClose.fontColor = 0xffffff;	_btnClose.fontSize = 18; _btnClose.fontName = "Arial";
				_btnClose.x = 210; _btnClose.y = 350; _btnClose.name = "Close";
				_window.addChild(_btnClose);
			}
			if (_status == "EXIT") {
				/* Кнопка Continue */
				_btnContinue = new Button(Resource.AtlasAll.getTexture("button_3.png"), "Продолжить", Resource.AtlasAll.getTexture("button_2.png"));
				_btnContinue.fontColor = 0xffffff;	_btnContinue.fontSize = 18; _btnContinue.fontName = "Arial";
				_btnContinue.x = 25; _btnContinue.y = 350; _btnContinue.name = "Continue";
				_window.addChild(_btnContinue);
				
				/* Кнопка Close */
				_btnClose = new Button(Resource.AtlasAll.getTexture("button_3.png"), "Закрыть", Resource.AtlasAll.getTexture("button_2.png"));
				_btnClose.fontColor = 0xffffff;	_btnClose.fontSize = 18; _btnClose.fontName = "Arial";
				_btnClose.x = 210; _btnClose.y = 350; _btnClose.name = "Close";
				_window.addChild(_btnClose);
			}
			
		}
		
		private function onClick(e:Event):void
		{
			if ((e.target as Button).name == "Continue") this.parent.removeChild(this);
			if ((e.target as Button).name == "Next") this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "LEVEL_NEXT" }, true));
			if ((e.target as Button).name == "Close") this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "LEVEL_CLOSE" }, true));
			if ((e.target as Button).name == "Post") this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "LEVEL_POST" }, true));
		}
		
	}

}
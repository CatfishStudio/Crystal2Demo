package Crystal.level 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	import Crystal.text.Label;
	import Crystal.resource.Resource;
	import Crystal.kernel.Mechanics;
	import Crystal.units.Cell;
	import Crystal.units.Unit;
	import Crystal.buttons.ButtonViolet;
	import Crystal.events.NavigationEvent;
	
	public class Level extends MovieClip
	{
		private var _loadBackground:Shape = new Shape();
		
		private var _loaderART:Loader; // для загрузки арта
		private var _loaderXML:URLLoader; // для загрузки XML
		private var _urlReq:URLRequest;
		private var _xml:XML;
		private var _levelFileXML:String;
		
		/* Конструкция уровня */
		private var _background:Bitmap;		
		
		private var _levelNumber:String;	// <levelNumber>
		private var _locationNumber:String;	// <locationNumber>
		private var _levelType:String;		// <levelType>
		private var _crystalType:String;	// <crystalType>
		private var _amountCrystals:String;	// <amountCrystals>
		private var _amountScoreStar1:String;	// <amountScoreStar1>
		private var _amountScoreStar2:String;	// <amountScoreStar2>
		private var _amountScoreStar3:String;	// <amountScoreStar3>
		private var _amountTime:String;		// <amountTime>
		private var _amountMoves:String;	// <amountMoves>
		private var _fileBackground:String;	// <FileBackground>
		
		private var _brifing:MovieClip;		// окно брифинга уровня
		private var _time:uint = 0;			// отсчет времени показа окна брифинга
		
		private var _labelMove:Label;		// метка для панели количества ходов
		private var _labelQuest:Label;		// метка для панели задания
		
		/* Условия прохождения уровня */
		private var _levelQuest:String;		// тип уровня ([собрать кристалы], [набрать очки], [спустить объект], [на время])
		private var _levelQuestCrystal:String;	// тип кристалов по заданию [собрать кристалы]
		private var _levelQuestAmountCrystalOrObject: int;	// Количество кристалов или объектов которые необходимо собрать или спустить.
		private var _levelQuestAmountScore:int;	// количество очков
		private var _levelQuestAmountTime:Date;	// время отведенное на уровень
		private var _levelQuestAmountMoves:int;	// количество ходов на уровень
		/*----------------------------*/
		
		private var _clickObject:Boolean = false; 	// флаг нажатия на объект (кристал, камень, руну)
		private var _blockedField:Boolean = false;	// флаг блокировки игрового поля от нажатий
		private var _movingObject:String;			// Направление передвижения объекта на поле (при воздействии пользователя на него)
		private var _unit1:Unit;					// Выбранные объекты для обмена местами
		private var _unit2:Unit;						
		
		
		public function Level(xmlFileName:String) 
		{
			_levelFileXML = xmlFileName;
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			/* Прелоадер */
			_loadBackground.graphics.beginFill(0x8000FF, 1);
			_loadBackground.graphics.drawRect(0, 0, 800, 600);
			_loadBackground.x = 0; _loadBackground.y = 0;
			_loadBackground.graphics.endFill();
			this.addChild(_loadBackground);
			this.addChild(new Label(360, 270, 200, 50, "Arial", 22, 0xFFFFFF, "Загрузка", false));
			
			/* Открытие XML файла (файл уровня) */
			_urlReq = new URLRequest(_levelFileXML);
			_loaderXML = new URLLoader(_urlReq);
			_loaderXML.addEventListener(Event.COMPLETE, xmlLoadComplete);
			_loaderXML.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			_loaderXML.addEventListener(IOErrorEvent.IO_ERROR, ioError);
		}
		
		/* Загрузка файла данных */
		private function xmlLoadComplete(e:Event):void 
		{
			_loaderXML.removeEventListener(Event.COMPLETE, xmlLoadComplete);
			
			/* Загрузка данных из файла XML */
			_xml = new XML(e.target.data);
			_levelNumber = _xml.levelNumber;
			_locationNumber = _xml.locationNumber;
			_levelType = _xml.levelType;
			_crystalType = _xml.crystalType;
			_amountCrystals = _xml.amountCrystals;
			_amountScoreStar1 = _xml.amountScoreStar1;
			_amountScoreStar2 = _xml.amountScoreStar2;
			_amountScoreStar3 = _xml.amountScoreStar3;
			_amountTime = _xml.amountTime;
			_amountMoves = _xml.amountMoves;
			_fileBackground = _xml.FileBackground;
			
			/* Создание игрового поля */
			Resource.MatrixCell = Mechanics.CreateCellVectorMatrix2D(Resource.COLUMNS, Resource.ROWS);
			/* i - столбец; j - строка */
			var index:uint = 0;
			for (var iCell:uint = 0; iCell < Resource.COLUMNS; iCell++) {
				for (var jCell:uint = 0; jCell < Resource.ROWS; jCell++) {
					(Resource.MatrixCell[iCell][jCell] as Cell).x = 200 + (50 * iCell);
					(Resource.MatrixCell[iCell][jCell] as Cell).y = 70 + (50 * jCell);
					(Resource.MatrixCell[iCell][jCell] as Cell).cellType = _xml.cell[index].cellType;
					index++;
				}
			}
			
			/* Создание объектов игрового поля */
			Resource.MatrixUnit = Mechanics.CreateUnitVectorMatrix2D(Resource.COLUMNS, Resource.ROWS);
			index = 0;
			for (var iUnit:uint = 0; iUnit < Resource.COLUMNS; iUnit++) {
				for (var jUnit:uint = 0; jUnit < Resource.ROWS; jUnit++) {
					(Resource.MatrixUnit[iUnit][jUnit] as Unit).x = 200 + (50 * iUnit);
					(Resource.MatrixUnit[iUnit][jUnit] as Unit).y = 70 + (50 * jUnit);
					(Resource.MatrixUnit[iUnit][jUnit] as Unit).posColumnI = iUnit;
					(Resource.MatrixUnit[iUnit][jUnit] as Unit).posRowJ = jUnit;
					(Resource.MatrixUnit[iUnit][jUnit] as Unit).posX = (Resource.MatrixUnit[iUnit][jUnit] as Unit).x;
					(Resource.MatrixUnit[iUnit][jUnit] as Unit).posY = (Resource.MatrixUnit[iUnit][jUnit] as Unit).y;
					(Resource.MatrixUnit[iUnit][jUnit] as Unit).unitType = _xml.cell[index].cellObject;
					/*события*/
					(Resource.MatrixUnit[iUnit][jUnit] as Unit).addEventListener(MouseEvent.CLICK, onMouseClick);
					(Resource.MatrixUnit[iUnit][jUnit] as Unit).addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
					(Resource.MatrixUnit[iUnit][jUnit] as Unit).addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
					(Resource.MatrixUnit[iUnit][jUnit] as Unit).addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
					(Resource.MatrixUnit[iUnit][jUnit] as Unit).addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
					(Resource.MatrixUnit[iUnit][jUnit] as Unit).addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
					index++;
				}
			}
			
			/* Загрузка фонового изображения */
			_loaderART = new Loader();
			_loaderART.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplite);
			_loaderART.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			_loaderART.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			_urlReq = new URLRequest("resource/textures/" + _fileBackground);
			_loaderART.load(_urlReq);
			
		}
				
		private function securityError(e:SecurityErrorEvent):void 
		{
			trace("Ошибка доступа!");
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace("Ошибка загрузки!");
		}
		
		/* Первичное построение уровня */
		private function onLoadComplite(e:Event):void 
		{
			_loaderART.contentLoaderInfo.removeEventListener(Event.COMPLETE, CreateLevel);
			
			/* Фоновое изобразение */
			_background = new Bitmap();
			_background = (e.target.content as Bitmap);
			this.addChild(_background);
			
			/* Окно брифинга */
			ShowBrifing();
		}
		
		/* Окно задания на уровень */
		private function ShowBrifing():void
		{
			var crystalImage:Bitmap = new Bitmap(Resource.CrystalImage.bitmapData);
			crystalImage.x = 150; crystalImage.y = -10;
			
			_brifing = new MovieClip();
			_brifing.graphics.lineStyle(1, 0x000000, 0);
			_brifing.graphics.beginFill(0xF0F0F0, 1);
			_brifing.graphics.drawRect(0, 0, 800, 100);
			_brifing.graphics.endFill();
			_brifing.x = 0; _brifing.y = -50;
			_brifing.alpha = 0.9;
			
			_brifing.addChild(crystalImage);
			if (_levelType == "LEVEL_TYPE_COLLECT") _brifing.addChild(new Label(300, 30, 500, 50, "Arial", 24, 0x2E46D1, "Задание: Собрать кристалы.", false));
			if (_levelType == "LEVEL_TYPE_SCORE_POINTS") _brifing.addChild(new Label(300, 30, 500, 50, "Arial", 24, 0x2E46D1, "Задание: Набрать " + _amountScoreStar1 + " очков.", false));
			if (_levelType == "LEVEL_TYPE_DROP_OBJECT") _brifing.addChild(new Label(300, 30, 500, 50, "Arial", 24, 0x2E46D1, "Задание: Спустить руны.", false));
			if (_levelType == "LEVEL_TYPE_TIME") _brifing.addChild(new Label(300, 30, 350, 500, "Arial", 24, 0x2E46D1, "Задание: Успеть по времени.", false));
			
			_brifing.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_brifing.play();
			
			this.addChild(_brifing);
			
		}
		
		private function onEnterFrame(e:Event):void 
		{
			_time++;
			if (_brifing.y == 250) this.removeEventListener(Event.ENTER_FRAME, onEnterFrame); 
			else _brifing.y += 20;
			if (_time == 50) {
				_time = 0;
				_brifing.stop();
				_brifing.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				this.removeChild(_brifing);
				CreateLevel();
			}
		}
		
		/* ПОСТРОЕНИЕ УРОВНЯ ------------------------------------------------ */
		private function CreateLevel():void
		{
			/* Определение условия прохождения уровня */
			_levelQuest = _levelType;
			_levelQuestCrystal = _crystalType;
			_levelQuestAmountCrystalOrObject = (_amountCrystals as int);
			_levelQuestAmountScore = 0;
			//_levelQuestAmountTime = 0;
			_levelQuestAmountMoves = 0;
			
			
			/* Отобразить игровое поле (i - столбец; j - строка) */
			for (var iCell:uint = 0; iCell < Resource.COLUMNS; iCell++) {
				for (var jCell:uint = 0; jCell < Resource.ROWS; jCell++) {
					this.addChild(Resource.MatrixCell[iCell][jCell]);
				}
			}
			
			/* Отображаем объекты игрового поля */
			for (var iUnit:uint = 0; iUnit < Resource.COLUMNS; iUnit++) {
				for (var jUnit:uint = 0; jUnit < Resource.ROWS; jUnit++) {
					this.addChild(Resource.MatrixUnit[iUnit][jUnit]);
				}
			}
			
			/* Отображение панелей */
			var panelMove:Sprite = new Sprite();	// панель ходов
			panelMove.graphics.lineStyle(1, 0xcccccc, 1);
			panelMove.graphics.beginFill(0x800080, 1);//0x800080
			panelMove.graphics.drawRect(25, 50, 100, 100);
			panelMove.graphics.endFill();
			panelMove.alpha = 0.3;
			this.addChild(panelMove);
			_labelMove = new Label(40, 120, 100, 30, "Arial", 16, 0xFFFFFF, "Ходов: " + _amountMoves.toString(), false);
			this.addChild(_labelMove);
			
			var panelTask:Sprite = new Sprite();	// панель задания
			panelTask.graphics.lineStyle(1, 0xcccccc, 1);
			panelTask.graphics.beginFill(0x800080, 1); //0x5E7597
			panelTask.graphics.drawRect(60, 20, 600, 40);
			panelTask.graphics.endFill();
			panelTask.alpha = 0.3;
			this.addChild(panelTask);
			if (_levelType == "LEVEL_TYPE_COLLECT" && _crystalType == "CRYSTAL_TYPE_ALL") _labelQuest = new Label(155, 30, 400, 30, "Arial", 16, 0xFFFFFF, "Задание: Собрано 0 /  " + _amountCrystals.toString() + " любых кристалов.", false);
			if (_levelType == "LEVEL_TYPE_COLLECT" && _crystalType == "CRYSTAL_TYPE_1_VIOLET") _labelQuest = new Label(155, 30, 400, 30, "Arial", 16, 0xFFFFFF, "Задание: Собрано 0 /  " + _amountCrystals.toString() + " фиолетовых кристалов.", false);
			if (_levelType == "LEVEL_TYPE_COLLECT" && _crystalType == "CRYSTAL_TYPE_2_GREEN") _labelQuest = new Label(155, 30, 400, 30, "Arial", 16, 0xFFFFFF, "Задание: Собрано 0 /  " + _amountCrystals.toString() + " зеленых кристалов.", false);
			if (_levelType == "LEVEL_TYPE_COLLECT" && _crystalType == "CRYSTAL_TYPE_3_RED") _labelQuest = new Label(155, 30, 400, 30, "Arial", 16, 0xFFFFFF, "Задание: Собрано 0 /  " + _amountCrystals.toString() + " красных кристалов.", false);
			if (_levelType == "LEVEL_TYPE_COLLECT" && _crystalType == "CRYSTAL_TYPE_4_BLUE") _labelQuest = new Label(155, 30, 400, 30, "Arial", 16, 0xFFFFFF, "Задание: Собрано 0 /  " + _amountCrystals.toString() + " синих кристалов.", false);
			if (_levelType == "LEVEL_TYPE_COLLECT" && _crystalType == "CRYSTAL_TYPE_5_YELLOW") _labelQuest = new Label(155, 30, 400, 30, "Arial", 16, 0xFFFFFF, "Задание: Собрано 0 /  " + _amountCrystals.toString() + " желтых кристалов.", false);
			if (_levelType == "LEVEL_TYPE_COLLECT" && _crystalType == "CRYSTAL_TYPE_6_LINE_UPRIGHT") _labelQuest = new Label(155, 30, 400, 30, "Arial", 16, 0xFFFFFF, "Задание: Собрано 0 /  " + _amountCrystals.toString() + " линейных вертикальных кристалов.", false);
			if (_levelType == "LEVEL_TYPE_COLLECT" && _crystalType == "CRYSTAL_TYPE_7_LINE_HORIZONTALLY") _labelQuest = new Label(155, 30, 400, 30, "Arial", 16, 0xFFFFFF, "Задание: Собрано 0 /  " + _amountCrystals.toString() + " горизонтальных кристалов.", false);
			if (_levelType == "LEVEL_TYPE_COLLECT" && _crystalType == "CRYSTAL_TYPE_8_SUPER") _labelQuest = new Label(155, 30, 400, 30, "Arial", 16, 0xFFFFFF, "Задание: Собрано 0 /  " + _amountCrystals.toString() + " супер кристалов.", false);
			if (_levelType == "LEVEL_TYPE_SCORE_POINTS") _labelQuest = new Label(155, 30, 400, 30, "Arial", 16, 0xFFFFFF, "Задание: Набрано 0 / " + _amountScoreStar1.toString() + " очков.", false);
			if (_levelType == "LEVEL_TYPE_DROP_OBJECT") _labelQuest = new Label(155, 30, 400, 30, "Arial", 16, 0xFFFFFF, "Задание: Спустить 0 / " + _amountCrystals.toString() + "рун.", false);
			if (_levelType == "LEVEL_TYPE_TIME") _labelQuest = new Label(155, 30, 4000, 30, "Arial", 16, 0xFFFFFF, "Задание: Успеть за " + _amountTime.toString() + " минут.", false);
			this.addChild(_labelQuest);
			
			/* рисунок Кристала */
			var crystalImage:Bitmap = new Bitmap(Resource.CrystalImage.bitmapData);
			crystalImage.x = 10; crystalImage.y = 5;
			this.addChild(crystalImage);
			
			/* кнопка настройка */
			var bSetting:ButtonViolet = new ButtonViolet(10, 470, 25, "Нaстройки");
			bSetting.addEventListener(MouseEvent.CLICK, onMouseClickButtonSetting)
			this.addChild(bSetting);
			
			/* кнопка выход */
			var bExit:ButtonViolet = new ButtonViolet(10, 520, 50, "Выход");
			bExit.addEventListener(MouseEvent.CLICK, onMouseClickButtonExit)
			this.addChild(bExit);
			
			
		}
		
		private function onMouseClickButtonExit(e:MouseEvent):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_LEVEL_CLOSE_MAP_SHOW" }, true));
		}
		
		private function onMouseClickButtonSetting(e:MouseEvent):void 
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "GAME_WINDOW_SETTING_SHOW" }, true));
		}
		
		/*События объектов игрового поля --------------------------------------------*/
		private function onMouseClick(e:MouseEvent):void
		{
			// при нажатии
			trace("ПОЗИЦИЯ(i-колонка):" + (e.target as Unit).posColumnI.toString() + "  ПОЗИЦИЯ(j-строка):" + (e.target as Unit).posRowJ.toString());
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			_clickObject = true; // флаг - объект нажат
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			_clickObject = false; // флаг - объект не нажат
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			//_clickObject = false;
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.BUTTON;
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			/* i - столбец; j - строка */
			if(_blockedField == false){	// Игровое поле разблокировано
				if (_clickObject) {		// объект нажат
					/* Смещение по горизонтале вправо */
					trace("X=" + e.localX.toString() + " |  Y=" + e.localY.toString());
					if (e.localX > 35 && e.localY < 35) {
						if ((e.target as Unit).posColumnI < Resource.COLUMNS - 1) {	// < 9
							/* Если не преграда (Камень) */
							if((Resource.MatrixUnit[(e.target as Unit).posColumnI + 1][(e.target as Unit).posRowJ] as Unit).unitType != "CRYSTAL_TYPE_9_STONE"){
								_movingObject = "Right:I+1";	// Обмен местами по горизонтали с объектом стоящим справа
								_unit1 = (e.target as Unit);
								_unit2 = (Resource.MatrixUnit[(e.target as Unit).posColumnI + 1][(e.target as Unit).posRowJ] as Unit);
								this.addEventListener(Event.ENTER_FRAME, AnimationExchangeCrystals);
								this.play();
								
								//uAction.Perform();
							}
						}
						trace("Смещение по горизонтале вправо X > 45 и Y < 45");
						_clickObject = false;
					}
					
					/* Смещение по горизонтале влево */
					if (e.localX < 5 && e.localY > 5) {
						trace("Смещение по горизонтале влево X < 5 и Y > 5");
						_clickObject = false;
					}
					
					/* Смещение по вертикале вверх */
					if (e.localY < 5 && e.localX > 5) {
						trace("Смещение по вертикале вверх Y < 5 и X > 5");
						_clickObject = false;
					}
					
					/* Смещение по вертикале вниз */
					if (e.localY > 35 && e.localX < 35) {
						trace("Смещение по вертикале вниз Y > 45 и X < 45");
						_clickObject = false;
					}
				}
			}
		}
		
		/* Анимация обмена местами между двумя объектами на поле, после воздействия на них пользователем */
		private function AnimationExchangeCrystals(e:Event):void 
		{
			/* Анимация пеемещания кристалов */
			if (_movingObject !="") {
				if (_movingObject == "Right:I+1") { // Смещение по горизонтале вправо
					_unit1.x += 10; // вправо
					_unit2.x -= 10; // влево
					trace("АНИМАЦИЯ: _unit1.x=" + _unit1.x.toString() + " | " + "_unit2.posX=" + _unit2.posX.toString());
					if (_unit1.x >= _unit2.posX) {
						this.stop();
						this.removeEventListener(Event.ENTER_FRAME, AnimationExchangeCrystals);
						Mechanics.ExchangeCrystals(_unit1, _unit2);
					}
				}
				if (_movingObject == "Left:I-1") { // Смещение по горизонтале влево
					_unit1.x += 10; // вправо
					_unit2.x -= 10; // влево
				}
				if (_movingObject == "Up:J-1") { // Смещение по вертикале вверх
					_unit1.y += 10; // вправо
					_unit2.y -= 10; // влево
				}
				if (_movingObject == "Down:J+1") { // Смещение по вертикале вниз
					_unit1.y -= 10; // вправо
					_unit2.y += 10; // влево
				}
				
			}
		}
		/*------------------------------------------------------------------------*/
	}

}
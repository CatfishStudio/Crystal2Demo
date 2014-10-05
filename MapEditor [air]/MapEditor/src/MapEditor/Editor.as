package MapEditor 
{
	import fl.controls.Button;
	import fl.controls.TextInput;
	import fl.controls.ComboBox;
	import fl.controls.Label;
	import fl.data.DataProvider; 
	import fl.events.ComponentEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.xml.XMLDocument;
	
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.navigateToURL; 
	import flash.net.Responder;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
		
	import MapEditor.Resource;
	
	/*
		 * ТАБЛИЦА ЗНАЧЕНИЙ РЕДАКТОРА
		 * -------------------------------------
		 * 1. Номер уровня: 0
		 * 2. Номер локации: 0
		 * 3. Тип уровня: 
				"Собрать кристалы" - "LEVEL_TYPE_COLLECT" 
				"Набрать очки" - "LEVEL_TYPE_SCORE_POINTS" 
				"Спустить объект" - "LEVEL_TYPE_DROP_OBJECT" 
				"На время" - "LEVEL_TYPE_TIME"
		 * 4. Тип кристала:
				"Все кристалы" - "CRYSTAL_TYPE_ALL"
				"1-Фиолетовый" - "CRYSTAL_TYPE_1_VIOLET" 
				"2-Зеленый" - "CRYSTAL_TYPE_2_GREEN" 
				"3-Красный" - "CRYSTAL_TYPE_3_RED" 
				"4-Синий" - "CRYSTAL_TYPE_4_BLUE" 
				"5-Желтый" - "CRYSTAL_TYPE_5_YELLOW" 
				"6-Линейный кристал вертикаль" - "CRYSTAL_TYPE_6_LINE_UPRIGHT"
				"7-Линейный кристал горизонталь" - "CRYSTAL_TYPE_7_LINE_HORIZONTALLY"
				"8-Супер кристал" - "CRYSTAL_TYPE_8_SUPER"
				"9-Не собирать" - "CRYSTAL_TYPE_9_NO"
		 * 5. Количество кристалов: 0
		 * 6. Количество очков: 0
		 * 7. Время на уровне: 0
		 * 8. Количество ходов: 0
		 * 9. Тип ячейки:
				"Нет ячейки" - "CELL_TYPE_EMPTY"
				"Пустая ячейка" - "CELL_TYPE_CLEAR"
				"Место спуска" - "CELL_TYPE_DROP"
		 * 10. Тип объекта в ячейке
				"нет объекта" - "CRYSTAL_TYPE_0_NO_OBJECT"
				"1-Фиолетовый" - "CRYSTAL_TYPE_1_VIOLET" 
				"2-Зеленый" - "CRYSTAL_TYPE_2_GREEN" 
				"3-Красный" - "CRYSTAL_TYPE_3_RED" 
				"4-Синий" - "CRYSTAL_TYPE_4_BLUE" 
				"5-Желтый" - "CRYSTAL_TYPE_5_YELLOW"
				"6-Линейный кристал вертикаль" - "CRYSTAL_TYPE_6_LINE_UPRIGHT"
				"7-Линейный кристал горизонталь" - "CRYSTAL_TYPE_7_LINE_HORIZONTALLY"
				"8-Супер кристал" - "CRYSTAL_TYPE_8_SUPER"
				"9-Камень" - "CRYSTAL_TYPE_9_STONE"
				"10-Руна" - "CRYSTAL_TYPE_10_RUNE"
		 * 
		 * -------------------------------------
		 * */
	
	public class Editor extends Sprite 
	{
		private var _file: File;
		private var _button1:Button = new Button();	// открыть файл
		private var _button2:Button = new Button();	// сохранить файл
		private var _button3:Button = new Button();	// очистить
		private var _label1:Label = new Label();
		private var _textBox1:TextInput = new TextInput();	//номер уровня <levelNumber>
		private var _label2:Label = new Label();
		private var _textBox2:TextInput = new TextInput();	//номер локации <locationNumber>
		private var _label3:Label = new Label();
		private var _comboBox1:ComboBox = new ComboBox();	// тип уровня <LevelType>
		private var _label4:Label = new Label();
		private var _comboBox2:ComboBox = new ComboBox();	// тип кристалов по заданию сбора <CrystalType>
		private var _label5:Label = new Label();
		private var _textBox3:TextInput = new TextInput();	// Количество кристалов <AmountCrystal>
		private var _label6:Label = new Label();
		private var _label6_1:Label = new Label();
		private var _textBox4_1:TextInput = new TextInput();	// Количество очнов <AmountScoreStar1> (одна звезда)
		private var _label6_2:Label = new Label();
		private var _textBox4_2:TextInput = new TextInput();	// Количество очнов <AmountScoreStar2> (две звезды)
		private var _label6_3:Label = new Label();
		private var _textBox4_3:TextInput = new TextInput();	// Количество очнов <AmountScoreStar3> (три звезды)
		private var _label7:Label = new Label();
		private var _textBox5:TextInput = new TextInput();	// Время на уровне <AmountTime>
		private var _label8:Label = new Label();
		private var _textBox6:TextInput = new TextInput();	// Количество ходов <AmountMoves>
		
		private var _label9:Label = new Label();
		private var _textBox7:TextInput = new TextInput();	// имя файла фоновой картинки для уровня <FileBackground>
		
		private var _loaderXML:URLLoader; // для загрузки XML
		private var _urlReq:URLRequest;
		private var _xml:XML;
		
		public function Editor() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			/* Кнопки */
			_button1.label = "Открыть";
			_button1.x = 10; _button1.y = 10;
			_button1.addEventListener(MouseEvent.CLICK, onButton1MouseClick);
			this.addChild(_button1);
			_button2.label = "Сохранить";
			_button2.x = 120; _button2.y = 10;
			_button2.addEventListener(MouseEvent.CLICK, onButton2MouseClick);
			this.addChild(_button2);
			_button3.label = "Очистить";
			_button3.x = 230; _button3.y = 10;
			_button3.addEventListener(MouseEvent.CLICK, onButton3MouseClick);
			this.addChild(_button3);
			
			/* Метка */
			_label1.text = "Номер уровня:";
			_label1.x = 20; _label1.y = 50;
			this.addChild(_label1);
			/* Номер уровня */
			_textBox1.text = "0";
			_textBox1.x = 20; _textBox1.y = 70;
			_textBox1.width = 200;
			this.addChild(_textBox1);
			
			/* Метка */
			_label2.text = "Номер локации:";
			_label2.x = 20; _label2.y = 100;
			this.addChild(_label2);
			/* Номер локации */
			_textBox2.text = "0";
			_textBox2.x = 20; _textBox2.y = 120;
			_textBox2.width = 200;
			this.addChild(_textBox2);
			
			/* Метка */
			_label3.text = "Тип уровня:";
			_label3.x = 20; _label3.y = 150;
			this.addChild(_label3);
			/* Тип уровня */
			_comboBox1.x = 20; _comboBox1.y = 170;
			_comboBox1.dropdownWidth = 210; 
			_comboBox1.width = 200;  
			_comboBox1.selectedIndex = 0;
			_comboBox1.dataProvider = new DataProvider(Resource.levelType); 
			_comboBox1.addEventListener(Event.CHANGE, changeHandler1); 
			this.addChild(_comboBox1);
			
			/* Метка */
			_label4.text = "Тип кристала по заданию сбора:";
			_label4.x = 20; _label4.y = 200;
			_label4.width = 200;
			this.addChild(_label4);
			/* Тип кристала по заданию сбора */
			_comboBox2.x = 20; _comboBox2.y = 220;
			_comboBox2.dropdownWidth = 210; 
			_comboBox2.width = 200;  
			_comboBox2.selectedIndex = 0;
			_comboBox2.dataProvider = new DataProvider(Resource.crystalType); 
			_comboBox2.addEventListener(Event.CHANGE, changeHandler2);
			this.addChild(_comboBox2);
			
			/* Метка */
			_label5.text = "Количество кристалов / объектов:";
			_label5.x = 20; _label5.y = 250;
			_label5.width = 300;
			this.addChild(_label5);
			/* Количество кристалов */
			_textBox3.text = "0";
			_textBox3.x = 20; _textBox3.y = 270;
			_textBox3.width = 200;
			this.addChild(_textBox3);
			
			/* Метка */
			_label6.text = "Количество очнов:";
			_label6.x = 20; _label6.y = 320;
			this.addChild(_label6);
			_label6_1.text = "(одна звезда)";
			_label6_1.x = 20; _label6_1.y = 340;
			this.addChild(_label6_1);
			/* Количество очнов (одна звезда)*/
			_textBox4_1.text = "0";
			_textBox4_1.x = 20; _textBox4_1.y = 360;
			_textBox4_1.width = 200;
			this.addChild(_textBox4_1);
			
			_label6_2.text = "(две звезды)";
			_label6_2.x = 20; _label6_2.y = 380;
			this.addChild(_label6_2);
			/* Количество очнов (две звезды)*/
			_textBox4_2.text = "0";
			_textBox4_2.x = 20; _textBox4_2.y = 400;
			_textBox4_2.width = 200;
			this.addChild(_textBox4_2);
			
			_label6_3.text = "(три звезды)";
			_label6_3.x = 20; _label6_3.y = 420;
			this.addChild(_label6_3);
			/* Количество очнов (три звезды))*/
			_textBox4_3.text = "0";
			_textBox4_3.x = 20; _textBox4_3.y = 440;
			_textBox4_3.width = 200;
			this.addChild(_textBox4_3);
			
			/* Метка */
			_label7.text = "Время на уровне:";
			_label7.x = 20; _label7.y = 480;
			this.addChild(_label7);
			/* Время на уровне */
			_textBox5.text = "0";
			_textBox5.x = 20; _textBox5.y = 500;
			_textBox5.width = 200;
			this.addChild(_textBox5);
			
			/* Метка */
			_label8.text = "Количество ходов:";
			_label8.x = 20; _label8.y = 520;
			this.addChild(_label8);
			/* Количество ходов */
			_textBox6.text = "0";
			_textBox6.x = 20; _textBox6.y = 540;
			_textBox6.width = 200;
			this.addChild(_textBox6);
			
			/* Метка */
			_label9.text = "Файл фоновой картинки:";
			_label9.width = 200;
			_label9.x = 20; _label9.y = 580;
			this.addChild(_label9);
			/* Количество ходов */
			_textBox7.text = "*.png";
			_textBox7.x = 20; _textBox7.y = 600;
			_textBox7.width = 200;
			this.addChild(_textBox7);
			
			/* ПАНЕЛЬ ОБЪЕКТОВ */
			this.addChild(new PanelObjects());
			
			/* ИГРОВОЕ ПОЛЕ */
			Resource.MatrixCell =  Resource.CreateVectorMatrix2D(Resource.COLUMNS, Resource.ROWS);
			showField(Resource.COLUMNS, Resource.ROWS);
			
			/* ЗНАЧЕНИЯ ПО УМОЛЧАНИЮ */
			Resource.Level = "";
			Resource.Location = "";
			Resource.LevelType = "";
			Resource.CrystalType = "";
			Resource.AmountCrystals = "";
			Resource.AmountScoreStar1 = "";
			Resource.AmountScoreStar2 = "";
			Resource.AmountScoreStar3 = "";
			Resource.AmountTime = "";
			Resource.AmountMoves = "";
			Resource.FileBackground = "";
		}
		
		private function changeHandler2(e:Event):void 
		{
			_comboBox2.text = ComboBox(e.target).selectedItem.label;
		}
		
		private function changeHandler1(e:Event):void 
		{
			_comboBox1.text = ComboBox(e.target).selectedItem.label;
		}
		
		/*Открытие файла*/
		private function onButton1MouseClick(e:MouseEvent):void 
		{
			var fileFiltres:Array = [];
			fileFiltres.push(new FileFilter("Файл уровня в XML формате", "*.xml"));
			fileFiltres.push(new FileFilter("Все файлы", "*.*"));
			_file = File.desktopDirectory;
			_file.browseForOpen("Открыть файл", fileFiltres);
			_file.addEventListener(Event.SELECT, openFileEventHandler);
		}
		
		private function openFileEventHandler(e:Event):void 
		{
			trace("Open file name: " + _file.name);
			trace("Open file path: " + _file.nativePath);
			
			var stream:FileStream = new FileStream();
			stream.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			stream.addEventListener(Event.COMPLETE, completeHandler);
			stream.openAsync(e.target as File, FileMode.READ);
		}
		
		private function progressHandler(e:ProgressEvent):void 
		{
			var stream:FileStream = e.target as FileStream;
			if (stream.bytesAvailable) {
				//trace(stream.readUTFBytes(stream.bytesAvailable).toString());
				//trace(stream.readUTF(stream.bytesAvailable).toString());
				//trace(stream.readMultiByte(stream.bytesAvailable, "iso-8859-1"));
			}
		}
		
		private function completeHandler(e:Event):void 
		{
			_urlReq = new URLRequest(_file.nativePath);
			_loaderXML = new URLLoader(_urlReq);
			_loaderXML.addEventListener(Event.COMPLETE, xmlLoadComplete);
			_loaderXML.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			_loaderXML.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			e.target.close();
			
		}
		
		/* чтение данных из XML файла */
		private function xmlLoadComplete(e:Event):void 
		{
			_loaderXML.removeEventListener(Event.COMPLETE, xmlLoadComplete);
			_xml = new XML(e.target.data);
			Resource.Level = _xml.levelNumber; _textBox1.text = Resource.Level;
			Resource.Location = _xml.locationNumber; _textBox2.text = Resource.Location;
			
			Resource.LevelType = _xml.levelType;
			for (var iCox1:uint = 0; iCox1 < _comboBox1.length; iCox1++) {
				if(_comboBox1.getItemAt(iCox1).data == Resource.LevelType) _comboBox1.selectedIndex = iCox1;
			}
						
			Resource.CrystalType = _xml.crystalType;
			for (var iCox2:uint = 0; iCox2 < _comboBox2.length; iCox2++) {
				if(_comboBox2.getItemAt(iCox2).data == Resource.CrystalType) _comboBox2.selectedIndex = iCox2;
			}
			
			Resource.AmountCrystals = _xml.amountCrystals; _textBox3.text = Resource.AmountCrystals;
			Resource.AmountScoreStar1 = _xml.amountScoreStar1; _textBox4_1.text = Resource.AmountScoreStar1;
			Resource.AmountScoreStar2 = _xml.amountScoreStar2; _textBox4_2.text = Resource.AmountScoreStar2;
			Resource.AmountScoreStar3 = _xml.amountScoreStar3; _textBox4_3.text = Resource.AmountScoreStar3;
			Resource.AmountTime = _xml.amountTime; _textBox5.text = Resource.AmountTime;
			Resource.AmountMoves = _xml.amountMoves; _textBox6.text = Resource.AmountMoves;
			Resource.FileBackground = _xml.FileBackground; _textBox7.text = Resource.FileBackground;
			
			//trace("DATA: " + xml.cell0_0.cellType);
			//trace("ROW: " + xml.cell[1].cellRow);
			
			/* i - столбец; j - строка */
			for (var index:uint = 0; index < Resource.COLUMNS * Resource.ROWS; index++) {
				var col:uint; /* столбец */
				var row:uint; /* строка */
				col = _xml.cell[index].cellColumn;
				row = _xml.cell[index].cellRow;
				(Resource.MatrixCell[col][row] as FieldCell).cellType = _xml.cell[index].cellType;
				(Resource.MatrixCell[col][row] as FieldCell).cellObject = _xml.cell[index].cellObject;
				Resource.SelectObject = _xml.cell[index].cellObject;
				(Resource.MatrixCell[col][row] as FieldCell).SetObject();
			}
			
			trace("File: " + _file.name + " open comlpite!");
		}
		
		private function securityError(e:SecurityErrorEvent):void 
		{
			trace("Ошибка доступа!");
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace("Ошибка загрузки!");
		}
		/*-----------------------------------------*/
		
		/*Сохранить файл*/
		private function onButton2MouseClick(e:MouseEvent):void 
		{
			_file = File.desktopDirectory;
			_file.browseForSave("Сохранить файл");
			_file.addEventListener(Event.SELECT, saveFileEventHandler);
		}
		
		private function saveFileEventHandler(e:Event):void 
		{
			trace("File name: " + _file.name);
			trace("File path: " + _file.nativePath);
			
			Resource.Level = _textBox1.text;
			Resource.Location = _textBox2.text
			Resource.LevelType = _comboBox1.selectedItem.data;
			Resource.CrystalType = _comboBox2.selectedItem.data;
			Resource.AmountCrystals = _textBox3.text;
			Resource.AmountScoreStar1 = _textBox4_1.text;
			Resource.AmountScoreStar2 = _textBox4_2.text;
			Resource.AmountScoreStar3 = _textBox4_3.text;
			Resource.AmountTime = _textBox5.text;
			Resource.AmountMoves = _textBox6.text;
			Resource.FileBackground = _textBox7.text;
			
			var bytes:ByteArray = new ByteArray();
			
			bytes.writeMultiByte("<?xml ", "iso-8859-1");
			bytes.writeMultiByte("version=\"1.0\" encoding=\"UTF-8\"", "iso-8859-1");
			bytes.writeMultiByte("?>\n", "iso-8859-1");
			
			bytes.writeMultiByte("<Level>\n", "iso-8859-1");
			
			bytes.writeMultiByte("<levelNumber>", "iso-8859-1");
			bytes.writeMultiByte(Resource.Level, "iso-8859-1");
			bytes.writeMultiByte("</levelNumber>\n", "iso-8859-1");
			bytes.writeMultiByte("<locationNumber>", "iso-8859-1");
			bytes.writeMultiByte(Resource.Location, "iso-8859-1");
			bytes.writeMultiByte("</locationNumber>\n", "iso-8859-1");
			bytes.writeMultiByte("<levelType>", "iso-8859-1");
			bytes.writeMultiByte(Resource.LevelType, "iso-8859-1");
			bytes.writeMultiByte("</levelType>\n", "iso-8859-1");
			bytes.writeMultiByte("<crystalType>", "iso-8859-1");
			bytes.writeMultiByte(Resource.CrystalType, "iso-8859-1");
			bytes.writeMultiByte("</crystalType>\n", "iso-8859-1");
			bytes.writeMultiByte("<amountCrystals>", "iso-8859-1");
			bytes.writeMultiByte(Resource.AmountCrystals, "iso-8859-1");
			bytes.writeMultiByte("</amountCrystals>\n", "iso-8859-1");
			bytes.writeMultiByte("<amountScoreStar1>", "iso-8859-1");
			bytes.writeMultiByte(Resource.AmountScoreStar1, "iso-8859-1");
			bytes.writeMultiByte("</amountScoreStar1>\n", "iso-8859-1");
			bytes.writeMultiByte("<amountScoreStar2>", "iso-8859-1");
			bytes.writeMultiByte(Resource.AmountScoreStar2, "iso-8859-1");
			bytes.writeMultiByte("</amountScoreStar2>\n", "iso-8859-1");
			bytes.writeMultiByte("<amountScoreStar3>", "iso-8859-1");
			bytes.writeMultiByte(Resource.AmountScoreStar3, "iso-8859-1");
			bytes.writeMultiByte("</amountScoreStar3>\n", "iso-8859-1");
			bytes.writeMultiByte("<amountTime>", "iso-8859-1");
			bytes.writeMultiByte(Resource.AmountTime, "iso-8859-1");
			bytes.writeMultiByte("</amountTime>\n", "iso-8859-1");
			bytes.writeMultiByte("<amountMoves>", "iso-8859-1");
			bytes.writeMultiByte(Resource.AmountMoves, "iso-8859-1");
			bytes.writeMultiByte("</amountMoves>\n", "iso-8859-1");
			bytes.writeMultiByte("<FileBackground>", "iso-8859-1");
			bytes.writeMultiByte(Resource.FileBackground, "iso-8859-1");
			bytes.writeMultiByte("</FileBackground>\n", "iso-8859-1");
			
			/* i - столбец; j - строка */
			for (var i:uint = 0; i < Resource.COLUMNS; i++) {
				for (var j:uint = 0; j < Resource.ROWS; j++) {
					bytes.writeMultiByte("<cell>\n", "iso-8859-1");
						bytes.writeMultiByte("<cellType>", "iso-8859-1");
						bytes.writeMultiByte((Resource.MatrixCell[i][j] as FieldCell).cellType, "iso-8859-1");
						bytes.writeMultiByte("</cellType>\n", "iso-8859-1");
						bytes.writeMultiByte("<cellObject>", "iso-8859-1");
						bytes.writeMultiByte((Resource.MatrixCell[i][j] as FieldCell).cellObject, "iso-8859-1");
						bytes.writeMultiByte("</cellObject>\n", "iso-8859-1");
						bytes.writeMultiByte("<cellColumn>", "iso-8859-1");
						bytes.writeMultiByte(i.toString(), "iso-8859-1");
						bytes.writeMultiByte("</cellColumn>\n", "iso-8859-1");
						bytes.writeMultiByte("<cellRow>", "iso-8859-1");
						bytes.writeMultiByte(j.toString(), "iso-8859-1");
						bytes.writeMultiByte("</cellRow>\n", "iso-8859-1");
					bytes.writeMultiByte("</cell>\n", "iso-8859-1");
					
				}
			}
			
			bytes.writeMultiByte("</Level>", "iso-8859-1");
			
			var stream:FileStream = new FileStream();
			stream.open(_file, FileMode.WRITE);
			stream.writeBytes(bytes);
			stream.close();
			trace("File: " + _file.name + " save comlpite!");
		}
		/*-----------------------------------------*/
		
		/* Очистка */
		private function onButton3MouseClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event(Event.CLEAR));
		}
		
		/* Отобразить игровое поле */
		private function showField(_columns:uint, _rows:uint):void
		{
			/* i - столбец; j - строка */
			for (var i:uint = 0; i < _columns; i++) {
				for (var j:uint = 0; j < _rows; j++) {
					(Resource.MatrixCell[i][j] as FieldCell).x = 300 + (50 * i);
					(Resource.MatrixCell[i][j] as FieldCell).y = 50 + (50 * j);
					this.addChild(Resource.MatrixCell[i][j]);
				}
			}
		}
	}

}
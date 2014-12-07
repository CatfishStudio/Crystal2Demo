package LevelEditor 
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
	
	import LevelEditor.Resource;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class Editor extends Sprite 
	{
		private var _file: File;
		private var _button1:Button = new Button();	// открыть файл
		private var _button2:Button = new Button();	// сохранить файл
		private var _button3:Button = new Button();	// очистить
		
		private var _label1:Label = new Label();
		private var _textBox1:TextInput = new TextInput();	//номер уровня <LevelNumber>
		private var _label2:Label = new Label();
		private var _comboBox2:ComboBox = new ComboBox();	// тип уровня <LevelType>
		private var _label3:Label = new Label();
		private var _comboBox3:ComboBox = new ComboBox();	// тип кристала <CrystalType>
		private var _label4:Label = new Label();
		private var _textBox4:TextInput = new TextInput();	//количество кристалов <AmountCrystals>
		private var _label5:Label = new Label();
		private var _textBox5:TextInput = new TextInput();	//количество очков на 1 звезду <AmountScoreStar1>
		private var _label6:Label = new Label();
		private var _textBox6:TextInput = new TextInput();	//количество очков на 2 звезду <AmountScoreStar2>
		private var _label7:Label = new Label();
		private var _textBox7:TextInput = new TextInput();	//количество очков на 3 звезду <AmountScoreStar3>
		private var _label8:Label = new Label();
		private var _textBox8:TextInput = new TextInput();	//время на уровне <AmountTime>
		private var _label9:Label = new Label();
		private var _textBox9:TextInput = new TextInput();	//количество ходов <AmountMoves>
		
		private var _labelMessage:Label = new Label();
		
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
			_button1.label = "Открыть";	_button1.name = "buttonOpen";
			_button1.x = 10; _button1.y = 10;
			_button1.addEventListener(MouseEvent.CLICK, onButtonMouseClick);
			this.addChild(_button1);
			_button2.label = "Сохранить"; _button2.name = "buttonSave";
			_button2.x = 120; _button2.y = 10;
			_button2.addEventListener(MouseEvent.CLICK, onButtonMouseClick);
			this.addChild(_button2);
			_button3.label = "Очистить"; _button3.name = "buttonClear";
			_button3.x = 230; _button3.y = 10;
			_button3.addEventListener(MouseEvent.CLICK, onButtonMouseClick);
			this.addChild(_button3);
			
			/* Метка */
			_label1.text = "Номер уровня:"; _label1.x = 20; _label1.y = 50;
			this.addChild(_label1);
			/* Номер уровня */
			_textBox1.text = "0"; _textBox1.x = 20; _textBox1.y = 70; _textBox1.width = 200;
			this.addChild(_textBox1);
			
			/* Метка */
			_label2.text = "Тип уровня:";
			_label2.x = 20; _label2.y = 100;
			this.addChild(_label2);
			/* Тип уровня */
			_comboBox2.name = "comboBox2";
			_comboBox2.x = 20; _comboBox2.y = 120;
			_comboBox2.dropdownWidth = 210; _comboBox2.width = 200;  
			_comboBox2.selectedIndex = 0;
			_comboBox2.dataProvider = new DataProvider(Resource.LevelsType); 
			_comboBox2.addEventListener(Event.CHANGE, changeHandlerComboBox); 
			this.addChild(_comboBox2);
			
			/* Метка */
			_label3.text = "Тип уровня:";
			_label3.x = 20; _label3.y = 150;
			this.addChild(_label3);
			/* Тип кристала */
			_comboBox3.name = "comboBox3";
			_comboBox3.x = 20; _comboBox3.y = 170;
			_comboBox3.dropdownWidth = 210; _comboBox3.width = 200;  
			_comboBox3.selectedIndex = 0;
			_comboBox3.dataProvider = new DataProvider(Resource.CrystalsType); 
			_comboBox3.addEventListener(Event.CHANGE, changeHandlerComboBox); 
			this.addChild(_comboBox3);
			
			/* Метка */
			_label4.text = "Количество кристалов:"; _label4.x = 20; _label4.y = 200; _label4.width = 200;
			this.addChild(_label4);
			/* Номер уровня */
			_textBox4.text = "0"; _textBox4.x = 20; _textBox4.y = 220; _textBox4.width = 200;
			this.addChild(_textBox4);
			
			/* Метка */
			_label5.text = "Количество очков на 1 звезду:"; _label5.x = 20; _label5.y = 250; _label5.width = 200;
			this.addChild(_label5);
			/* Номер уровня */
			_textBox5.text = "0"; _textBox5.x = 20; _textBox5.y = 270; _textBox5.width = 200;
			this.addChild(_textBox5);
			
			/* Метка */
			_label6.text = "Количество очков на 2 звезды:"; _label6.x = 20; _label6.y = 300; _label6.width = 200;
			this.addChild(_label6);
			/* Номер уровня */
			_textBox6.text = "0"; _textBox6.x = 20; _textBox6.y = 320; _textBox6.width = 200;
			this.addChild(_textBox6);
			
			/* Метка */
			_label7.text = "Количество очков на 3 звезды:"; _label7.x = 20; _label7.y = 350; _label7.width = 200;
			this.addChild(_label7);
			/* Номер уровня */
			_textBox7.text = "0"; _textBox7.x = 20; _textBox7.y = 370; _textBox7.width = 200;
			this.addChild(_textBox7);
			
			/* Метка */
			_label8.text = "Время на уровне:"; _label8.x = 20; _label8.y = 400; _label8.width = 200;
			this.addChild(_label8);
			/* Номер уровня */
			_textBox8.text = "0"; _textBox8.x = 20; _textBox8.y = 420; _textBox8.width = 200;
			this.addChild(_textBox8);
			
			/* Метка */
			_label9.text = "Количество ходов:"; _label9.x = 20; _label9.y = 450; _label9.width = 200;
			this.addChild(_label9);
			/* Номер уровня */
			_textBox9.text = "0"; _textBox9.x = 20; _textBox9.y = 470; _textBox9.width = 200;
			this.addChild(_textBox9);
			
			/* Метка */
			_labelMessage.text = "Create new!"; _labelMessage.x = 20; _labelMessage.y = 500; _labelMessage.width = 200;
			this.addChild(_labelMessage);
			
			/* ИГРОВОЕ ПОЛЕ */
			Resource.MatrixCell =  Resource.CreateVectorMatrix2D(Resource.COLUMNS, Resource.ROWS);
			showField(Resource.COLUMNS, Resource.ROWS);
			
			/* ПАНЕЛЬ ОБЪЕКТОВ */
			this.addChild(new PanelObjects());
			
			/* ЗНАЧЕНИЯ ПО УМОЛЧАНИЮ */
			Resource.LevelNumber = "";		// номер уровня
			Resource.LevelType = "";		// тип уровня
			Resource.CrystalType = "";		// тип кристала
			Resource.AmountCrystals = "";	// количество кристалов
			Resource.AmountScoreStar1 = "";	// количество очков на 1 звезду
			Resource.AmountScoreStar2 = "";	// количество очков на 2 звезды
			Resource.AmountScoreStar3 = "";	// количество очков на 3 звезды
			Resource.AmountTime = "";		// время на уровне
			Resource.AmountMoves = "";		// количество ходов
		}
		
		private function onButtonMouseClick(e:MouseEvent):void 
		{
			if ((e.target as Button).name == "buttonOpen") openFile();
			if ((e.target as Button).name == "buttonSave") saveFile();
			if ((e.target as Button).name == "buttonClear") clear()
		}
		
		private function changeHandlerComboBox(e:Event):void 
		{
			if ((e.target as ComboBox).name == "comboBox2") _comboBox2.text = ComboBox(e.target).selectedItem.label;
			if ((e.target as ComboBox).name == "comboBox3") _comboBox3.text = ComboBox(e.target).selectedItem.label;
			
		}
		
		/*Открытие файла ========================================================*/
		private function openFile():void 
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
			
			Resource.LevelNumber = _xml.LevelNumber; 
			_textBox1.text = Resource.LevelNumber;
			
			Resource.LevelType = _xml.LevelType;
			for (var iCox2:uint = 0; iCox2 < _comboBox2.length; iCox2++) {
				if(_comboBox2.getItemAt(iCox2).data == Resource.LevelType) _comboBox2.selectedIndex = iCox2;
			}
			
			Resource.CrystalType = _xml.CrystalType;
			for (var iCox3:uint = 0; iCox3 < _comboBox3.length; iCox3++) {
				if(_comboBox3.getItemAt(iCox3).data == Resource.CrystalType) _comboBox3.selectedIndex = iCox3;
			}
			
			Resource.AmountCrystals = _xml.AmountCrystals; 
			_textBox4.text = Resource.AmountCrystals;
			
			Resource.AmountScoreStar1 = _xml.AmountScoreStar1; 
			_textBox5.text = Resource.AmountScoreStar1;
			
			Resource.AmountScoreStar2 = _xml.AmountScoreStar2; 
			_textBox6.text = Resource.AmountScoreStar2;
			
			Resource.AmountScoreStar3 = _xml.AmountScoreStar3; 
			_textBox7.text = Resource.AmountScoreStar3;
			
			Resource.AmountTime = _xml.AmountTime; 
			_textBox8.text = Resource.AmountTime;
			
			Resource.AmountMoves = _xml.AmountMoves; 
			_textBox9.text = Resource.AmountMoves;
			
			/* i - столбец; j - строка */
			for (var index:uint = 0; index < Resource.COLUMNS * Resource.ROWS; index++) {
				var col:uint; /* столбец */
				var row:uint; /* строка */
				col = _xml.cell[index].cellColumn;
				row = _xml.cell[index].cellRow;
				(Resource.MatrixCell[col][row] as FieldCell).cellType = _xml.cell[index].cellType;
				(Resource.MatrixCell[col][row] as FieldCell).cellObject = _xml.cell[index].cellObject;
				if (_xml.cell[index].cellType != "CELL_TYPE_DROP") Resource.SelectObject = _xml.cell[index].cellObject;
				else Resource.SelectObject = _xml.cell[index].cellType;
				(Resource.MatrixCell[col][row] as FieldCell).SetObject();
			}
			
			trace("File: " + _file.name + " open comlpite!");
			_labelMessage.text = "Open comlpite!";
		}
		
		private function securityError(e:SecurityErrorEvent):void 
		{
			trace("Ошибка доступа!");
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace("Ошибка загрузки!");
		}
		/*=================================================================*/
		
		/*Сохранить файл ==================================================*/
		private function saveFile():void 
		{
			_file = File.desktopDirectory;
			_file.browseForSave("Сохранить файл");
			_file.addEventListener(Event.SELECT, saveFileEventHandler);
		}
		
		private function saveFileEventHandler(e:Event):void 
		{
			trace("File name: " + _file.name);
			trace("File path: " + _file.nativePath);
			
			Resource.LevelNumber = _textBox1.text;				// номер уровня
			Resource.LevelType = _comboBox2.selectedItem.data;	// тип уровня
			Resource.CrystalType = _comboBox3.selectedItem.data;// тип кристала
			Resource.AmountCrystals = _textBox4.text;			// количество кристалов
			Resource.AmountScoreStar1 = _textBox5.text;			// количество очков на 1 звезду
			Resource.AmountScoreStar2 = _textBox6.text;			// количество очков на 2 звезды
			Resource.AmountScoreStar3 = _textBox7.text;			// количество очков на 3 звезды
			Resource.AmountTime = _textBox8.text;				// время на уровне
			Resource.AmountMoves = _textBox9.text;				// количество ходов
			
			var bytes:ByteArray = new ByteArray();
			
			bytes.writeMultiByte("<?xml ", "iso-8859-1");
			bytes.writeMultiByte("version=\"1.0\" encoding=\"UTF-8\"", "iso-8859-1");
			bytes.writeMultiByte("?>\n", "iso-8859-1");
			
			bytes.writeMultiByte("<Level>\n", "iso-8859-1");
				bytes.writeMultiByte("<LevelNumber>", "iso-8859-1");
				bytes.writeMultiByte(Resource.LevelNumber, "iso-8859-1");
				bytes.writeMultiByte("</LevelNumber>\n", "iso-8859-1");
				
				bytes.writeMultiByte("<LevelType>", "iso-8859-1");
				bytes.writeMultiByte(Resource.LevelType, "iso-8859-1");
				bytes.writeMultiByte("</LevelType>\n", "iso-8859-1");
				
				bytes.writeMultiByte("<CrystalType>", "iso-8859-1");
				bytes.writeMultiByte(Resource.CrystalType, "iso-8859-1");
				bytes.writeMultiByte("</CrystalType>\n", "iso-8859-1");
				
				bytes.writeMultiByte("<AmountCrystals>", "iso-8859-1");
				bytes.writeMultiByte(Resource.AmountCrystals, "iso-8859-1");
				bytes.writeMultiByte("</AmountCrystals>\n", "iso-8859-1");
				
				bytes.writeMultiByte("<AmountScoreStar1>", "iso-8859-1");
				bytes.writeMultiByte(Resource.AmountScoreStar1, "iso-8859-1");
				bytes.writeMultiByte("</AmountScoreStar1>\n", "iso-8859-1");
				
				bytes.writeMultiByte("<AmountScoreStar2>", "iso-8859-1");
				bytes.writeMultiByte(Resource.AmountScoreStar2, "iso-8859-1");
				bytes.writeMultiByte("</AmountScoreStar2>\n", "iso-8859-1");
				
				bytes.writeMultiByte("<AmountScoreStar3>", "iso-8859-1");
				bytes.writeMultiByte(Resource.AmountScoreStar3, "iso-8859-1");
				bytes.writeMultiByte("</AmountScoreStar3>\n", "iso-8859-1");
				
				bytes.writeMultiByte("<AmountTime>", "iso-8859-1");
				bytes.writeMultiByte(Resource.AmountTime, "iso-8859-1");
				bytes.writeMultiByte("</AmountTime>\n", "iso-8859-1");
				
				bytes.writeMultiByte("<AmountMoves>", "iso-8859-1");
				bytes.writeMultiByte(Resource.AmountMoves, "iso-8859-1");
				bytes.writeMultiByte("</AmountMoves>\n", "iso-8859-1");
			
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
			_labelMessage.text = "Save comlpite!";
		}
		/*=================================================================*/
		
		/* Очистка */
		private function clear():void 
		{
			dispatchEvent(new Event(Event.CLEAR));
		}
		
		/* Отобразить игровое поле */
		private function showField(_columns:uint, _rows:uint):void
		{
			/* i - столбец; j - строка */
			for (var i:uint = 0; i < _columns; i++) {
				for (var j:uint = 0; j < _rows; j++) {
					(Resource.MatrixCell[i][j] as FieldCell).x = 225 + (50 * i);
					(Resource.MatrixCell[i][j] as FieldCell).y = 50 + (50 * j);
					this.addChild(Resource.MatrixCell[i][j]);
				}
			}
		}
		
	}

}
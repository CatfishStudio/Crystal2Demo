package Crystal2.assets.resource 
{
	import Crystal2.assets.resource.Resource;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class FastLoadResource extends Sprite 
	{
		[Embed(source = '../media/atlas/crystal2_atlas_all.png')]
		private var AtlasAllImage:Class;
		[Embed(source = '../media/atlas/crystal2_atlas_all.xml', mimeType='application/octet-stream')]
		private var AtlasAllXML:Class;
		
		[Embed(source = '../media/atlas/crystal2_atlas_levels.jpg')]
		private var AtlasLevelsImage:Class;
		[Embed(source = '../media/atlas/crystal2_atlas_levels.xml', mimeType='application/octet-stream')]
		private var AtlasLevelsXML:Class;
		
		[Embed(source = '../media/atlas/crystal2_atlas_panel.png')]
		private var AtlasPanelImage:Class;
		[Embed(source = '../media/atlas/crystal2_atlas_panel.xml', mimeType='application/octet-stream')]
		private var AtlasPanelXML:Class;
		
		[Embed(source = '../media/atlas/crystal2_map.jpg')]
		private var AtlasMapImage:Class;
		
		[Embed(source = '../media/levels/crystal2_level_0.xml', mimeType='application/octet-stream')]
		private var Level0XML:Class;
		[Embed(source = '../media/levels/crystal2_level_1.xml', mimeType='application/octet-stream')]
		private var Level1XML:Class;
		[Embed(source = '../media/levels/crystal2_level_2.xml', mimeType='application/octet-stream')]
		private var Level2XML:Class;
		[Embed(source = '../media/levels/crystal2_level_3.xml', mimeType='application/octet-stream')]
		private var Level3XML:Class;
		[Embed(source = '../media/levels/crystal2_level_4.xml', mimeType='application/octet-stream')]
		private var Level4XML:Class;
		[Embed(source = '../media/levels/crystal2_level_5.xml', mimeType='application/octet-stream')]
		private var Level5XML:Class;
		
		public function FastLoadResource() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.alpha = 0.1;
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var contentfile:ByteArray;	// = new AtlasAllXML();
			var contentstr:String;		// = contentfile.readUTFBytes(contentfile.length);
			
			contentfile = new AtlasAllXML();
			contentstr = contentfile.readUTFBytes(contentfile.length);
			Resource.FileXML_AtlasAll = new XML(contentstr);
			Resource.Image_AtlasAll = new AtlasAllImage();
			
			contentfile = new AtlasLevelsXML();
			contentstr = contentfile.readUTFBytes(contentfile.length);
			Resource.FileXML_AtlasLevels = new XML(contentstr);
			Resource.Image_AtlasLevels = new AtlasLevelsImage();
			
			contentfile = new AtlasPanelXML();
			contentstr = contentfile.readUTFBytes(contentfile.length);
			Resource.FileXML_AtlasPanel = new XML(contentstr);
			Resource.Image_AtlasPanel = new AtlasPanelImage();
			
			
			Resource.Image_Map = new AtlasMapImage();
			
			contentfile = new Level0XML();
			contentstr = contentfile.readUTFBytes(contentfile.length);
			Resource.FilesXML_Levels.push(new XML(contentstr)); // массив уровней
			
			contentfile = new Level1XML();
			contentstr = contentfile.readUTFBytes(contentfile.length);
			Resource.FilesXML_Levels.push(new XML(contentstr)); // массив уровней
			
			contentfile = new Level2XML();
			contentstr = contentfile.readUTFBytes(contentfile.length);
			Resource.FilesXML_Levels.push(new XML(contentstr)); // массив уровней
			
			contentfile = new Level3XML();
			contentstr = contentfile.readUTFBytes(contentfile.length);
			Resource.FilesXML_Levels.push(new XML(contentstr)); // массив уровней
			
			contentfile = new Level4XML();
			contentstr = contentfile.readUTFBytes(contentfile.length);
			Resource.FilesXML_Levels.push(new XML(contentstr)); // массив уровней
			
			contentfile = new Level5XML();
			contentstr = contentfile.readUTFBytes(contentfile.length);
			Resource.FilesXML_Levels.push(new XML(contentstr)); // массив уровней
			
			dispatchEvent(new Event(Event.CLEAR));
		}
		
	}

}
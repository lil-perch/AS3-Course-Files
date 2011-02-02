package src
{
	public class PageAttributes
	{
		private var _fpsec:Number = 12;
		private var _isTocEntry:Boolean = true;
		private var _file:String;
		private var _loadPercentage:int = 0;
		private var _nonNavPage:Boolean = false;
		private var _title:String;
		private var _nType:String = "none";
		private var _pType:String;
		private var _mediaPath:String;
		private var _mediaFormat:String;
		private var _imageFile:String;
		private var _imgPos:String;
		private var _autoPlayMedia:Boolean = true;
		private var _id:String;
		private var _captivatePage:Boolean = false;
		private var _isRaptivity:Boolean = false;
		private var _engageSWF:Boolean = false;
		private var _sendPageComplete:Boolean = false;			//The default page type uses this attribute to indicate if page complete should be sent.
		private var _isAs2Movie:Boolean = false;				//Identifies the movie being loaded as AS2
		
		public function PageAttributes()
		{
			
		}
		
		public function updatePageAttributes(pageXML:XML):void
		{
			_fpsec = Number(pageXML.@fpsec);
			_isTocEntry = (pageXML.@isTocEntry.toString().toLowerCase() == "true");
			_file = pageXML.@file;
			_loadPercentage = int(pageXML.@loadPercentage);
			_nonNavPage = pageXML.@nonNavPage;
			_title = pageXML.@title;
			_nType = pageXML.@nType;
			_pType = pageXML.@pType;
			_mediaPath = pageXML.@mediaPath;
			_mediaFormat = pageXML.@mediaFormat;
			_imageFile = pageXML.@imageFile;
			_imgPos = pageXML.@imgPos;
			_autoPlayMedia = (pageXML.@autoPlayMedia.toString().toLowerCase() == "true");
			_id = pageXML.@id;
			_captivatePage = (pageXML.@captivatePage.toString().toLowerCase() == "true");
			_isRaptivity = (pageXML.@isRaptivity.toString().toLowerCase() == "true");
			_engageSWF = (pageXML.@engageSWF.toString().toLowerCase() == "true");
			_sendPageComplete = (pageXML.@sendPageComplete.toString().toLowerCase() == "true");
			_isAs2Movie = (pageXML.@isAS2File.toString().toLowerCase() == "true");
		}
		
		public function get fpsec():Number
		{
			return _fpsec;
		}
		
		public function get isTocEntry():Boolean
		{
			return _isTocEntry;
		}
		
		public function get file():String
		{
			return _file;
		}
		
		public function get loadPercentage():int
		{
			return _loadPercentage;
		}
		
		public function get nonNavPage():Boolean
		{
			return _nonNavPage;
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function get nType():String
		{
			return _nType;
		}
		
		public function get pType():String
		{
			return _pType;
		}
		
		public function get mediaPath():String
		{
			return _mediaPath;
		}
		
		public function get mediaFormat():String
		{
			return _mediaFormat;
		}
		
		public function get imageFile():String
		{
			return _imageFile;
		}
		
		public function get imgPos():String
		{
			return _imgPos;
		}
		
		public function get autoPlayMedia():Boolean
		{
			return _autoPlayMedia;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function get captivatePage():Boolean
		{
			return _captivatePage;
		}
		
		public function get isRaptivity():Boolean
		{
			return _isRaptivity;
		}
		
		public function get engageSWF():Boolean
		{
			return _engageSWF;
		}
		
		public function get sendPageComplete():Boolean
		{
			return _sendPageComplete;
		}
		
		public function get isAS2Movie():Boolean
		{
			return _isAs2Movie;
		}
	}
}
package src.classes
{
	public class Path
	{
		private var _scoxml:String;
		private var _quizxml:String;
		private var _glossaryxml:String;
		private var _toc:String;
		private var _mediacontrol:String;
		private var _glossaryswf:String
		private var _glossaryterm:String;
		private var _glossarycss:String;
		private var _narrationswf:String;
		private var _narrationcss:String;
		private var _courselogo:String;
		private var _noteicon:String;
		private var _tipicon:String;
		private var _warningicon:String;
		private var _as2loader:String;				//Path to as2 loader SWF for loading AS2 movies
		
		public function Path()
		{
			
		}
		
		//Setter and Getter Methods
		public function set scoXML(x:String):void
		{
			_scoxml = x;
		}
		
		public function get scoXML():String
		{
			return _scoxml;
		}
		
		public function set quizXML(x:String):void
		{
			_quizxml = x;
		}
		
		public function get quizXML():String
		{
			return _quizxml;
		}
		
		public function set glossaryXML(x:String):void
		{
			_glossaryxml = x;
		}
		
		public function get glossaryXML():String
		{
			return _glossaryxml;
		}
		
		public function set tocSWF(x:String):void
		{
			_toc = x;
		}
		
		public function get tocSWF():String
		{
			return _toc;
		}
		
		public function set controlSWF(x:String):void
		{
			_mediacontrol = x;
		}
		
		public function get controlSWF():String
		{
			return _mediacontrol;
		}
		
		public function set glossarySWF(x:String):void
		{
			_glossaryswf = x;
		}
		
		public function get glossarySWF():String
		{
			return _glossaryswf;
		}
		
		public function set glossaryTerm(x:String):void
		{
			_glossaryterm = x;
		}
		
		public function get glossaryTerm():String
		{
			return _glossaryterm;
		}
		
		public function set glossaryCSS(x:String):void
		{
			_glossarycss = x;
		}
		
		public function get glossaryCSS():String
		{
			return _glossarycss;
		}
		
		public function set narrationSWF(x:String):void
		{
			_narrationswf = x;
		}
		
		public function get narrationSWF():String
		{
			return _narrationswf;
		}
		
		public function set narrationCSS(x:String):void
		{
			_narrationcss = x;
		}
		
		public function get narrationCSS():String
		{
			return _narrationcss;
		}
		
		public function set courseLogo(x:String):void
		{
			_courselogo = x;
		}
		
		public function get courseLogo():String
		{
			return _courselogo;
		}
		
		public function set noteIcon(x:String):void
		{
			_noteicon = x;
		}
		
		public function get noteIcon():String
		{
			return _noteicon;
		}
		
		public function set tipIcon(x:String):void
		{
			_tipicon = x;
		}
		
		public function get tipIcon():String
		{
			return _tipicon;
		}
		
		public function set warningIcon(x:String):void
		{
			_warningicon = x;
		}
		
		public function get warningIcon():String
		{
			return _warningicon;
		}
		
		public function set as2Loader(x:String):void
		{
			_as2loader = x;
		}
		
		public function get as2Loader():String
		{
			return _as2loader;
		}
		
		
	}
}
package src.classes
{
	public class Settings
	{
		private var _useinterfacecolors:Boolean;
		private var _detatchedMenu:Boolean;
		private var _movejusttopictext:Boolean;
		private var _leftJustifiedHighlight:Boolean;
		private var _indexlocx:int;
		private var _indexlocy:int;
		private var _indexlocw:int;
		private var _indexloch:int;
		private var _glossmenux:int;
		private var _glossmenuy:int;
		private var _glossmenuspace:int;
		private var _indexendx:Number;
		private var _presentsizeh:Number;
		private var _presentsizew:Number;
		private var _mediaplayerspace:Number;
		private var _masklocationx:Number;						//Used to position the toc mask.
		private var _masklocationy:Number;						//Used to position the toc mask.
		private var _showpagetitle:Boolean;
		private var _indexeasing:String;
		private var _easingtime:Number;
		private var _autonavlatency:int;						//Used to determine how long to pause between pages when using auto Navigation.
		private var _reviewmargin:uint;							//Space around the review dialog box in a quiz.
		
		
		public function Settings()
		{
			
		}
		
		//Setter and Getter Methods
		public function set useInterfaceColors(p:Boolean):void
		{
			_useinterfacecolors = p;
		}
		
		public function get useInterfaceColors():Boolean
		{
			return _useinterfacecolors;
		}
		
		public function set moveJustTopicText(p:Boolean):void
		{
			_movejusttopictext = p;
		}
		
		public function get moveJustTopicText():Boolean
		{
			return _movejusttopictext;
		}
		
		public function set indexLocX(x:int):void
		{
			_indexlocx = x;
		}
		
		public function get indexLocX():int
		{
			return _indexlocx;
		}
		
		public function set indexLocY(x:int):void
		{
			_indexlocy = x;
		}
		
		public function get indexLocY():int
		{
			return _indexlocy;
		}
		
		public function set indexLocW(x:int):void
		{
			_indexlocw = x;
		}
		
		public function get indexLocW():int
		{
			return _indexlocw;
		}
		
		public function set indexLocH(x:int):void
		{
			_indexloch = x;
		}
		
		public function get indexLocH():int
		{
			return _indexloch;
		}
		
		public function set leftJustifiedHighlight(p:Boolean):void
		{
			_leftJustifiedHighlight = p;
		}
		
		public function get leftJustifiedHighlight():Boolean
		{
			return _leftJustifiedHighlight;
		}
		
		public function set glossaryMenuX(x:int):void
		{
			_glossmenux = x;
		}
		
		public function get glossaryMenuX():int
		{
			return _glossmenux;
		}
		
		public function set glossaryMenuY(x:int):void
		{
			_glossmenuy = x;
		}
		
		public function get glossaryMenuY():int
		{
			return _glossmenuy;
		}
		
		public function set glossaryMenuSpace(x:int):void
		{
			_glossmenuspace = x;
		}
		
		public function get glossaryMenuSpace():int
		{
			return _glossmenuspace;
		}
		
		public function set indexEndX(x:Number):void
		{
			_indexendx = x;
		}
		
		public function get indexEndX():Number
		{
			return _indexendx;
		}
		
		public function set detatchedMenu(p:Boolean):void
		{
			_detatchedMenu = p;
		}
		
		public function get detatchedMenu():Boolean
		{
			return _detatchedMenu;
		}
		
		public function set presentSizeH(x:Number):void
		{
			_presentsizeh = x;
		}
		
		public function get presentSizeH():Number
		{
			return _presentsizeh;
		}
		
		public function set presentSizeW(x:Number):void
		{
			_presentsizew = x;
		}
		
		public function get presentSizeW():Number
		{
			return _presentsizew;
		}
		
		public function set mediaPlayerSpace(x:Number):void
		{
			_mediaplayerspace = x;
		}
		
		public function get mediaPlayerSpace():Number
		{
			return _mediaplayerspace;
		}
		
		public function set maskLocationX(x:Number):void
		{
			_masklocationx = x;
		}
		
		public function get maskLocationX():Number
		{
			return _masklocationx;
		}
		
		public function set maskLocationY(x:Number):void
		{
			_masklocationy = x;
		}
		
		public function get maskLocationY():Number
		{
			return _masklocationy;
		}
		
		public function set showPageTitle(x:Boolean):void
		{
			_showpagetitle = x;
		}
		
		public function get showPageTitle():Boolean
		{
			return _showpagetitle;
		}
		
		public function set indexEasing(x:String):void
		{
			_indexeasing = x;
		}
		
		public function get indexEasing():String
		{
			return _indexeasing;
		}
		
		public function set easingTime(x:Number):void
		{
			_easingtime = x;
		}
		
		public function get easingTime():Number
		{
			return _easingtime;
		}
		
		public function set autoNavLatency(x:int):void
		{
			_autonavlatency = x;
		}
		
		public function get autoNavLatency():int
		{
			return _autonavlatency;
		}
		
		public function set reviewMargin(x:uint):void
		{
			_reviewmargin = x;
		}
		
		public function get reviewMargin():uint
		{
			return _reviewmargin;
		}
	}
}
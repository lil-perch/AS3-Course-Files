package src.classes
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.*;
	import flash.utils.Timer;

	public class Tooltip extends Sprite
	{
		private var _rootRef:DisplayObjectContainer;      		// A Reference to the containing clip of the application
    
	    private var _currentTipObj:DisplayObjectContainer;          // The handle the tooltip event is coming from.  
	    private var _tipWidth:int;            // The width of the tooltip movie clip
	    private var _tipHeight:int;           // The height of the tooltip movie clip
	    private var _tip:TextField;              // The reference to the textfield
		private var _tipText:String;			//Text to display in tip
		private var _currentFontSize; 			//Font size for tip.
		private var _timerWait;					//Timer object for wait time before displaying tooltip.
		private var _timerHide;					//Timer to determine if tooltip should be hidden.
		
		public function Tooltip(r:DisplayObjectContainer,f:int):void
		{
			//TODO: implement function
			_rootRef = r;
			_currentFontSize = f;
			
			_tip =  new TextField();
			_tip.x = _tip.y = 0;
			_tip.width = _tipWidth = 200;
			_tip.height = _tipHeight = 20;
			_tip.autoSize = TextFieldAutoSize.LEFT;
			_tip.border = true;
			_tip.background = true;
			_tip.backgroundColor = 0xFFFFFF;
			//Set up timer
			_timerWait = new Timer(500);
	        _timerWait.addEventListener(TimerEvent.TIMER,onWaitTime);
	        _timerHide = new Timer(100);
	        _timerHide.addEventListener(TimerEvent.TIMER,hideTip);
		}
		
		public function showTip(obj:DisplayObjectContainer, tooltip:String):void
	    {
	        _currentTipObj = obj;
	        _tipText = tooltip;
	        //trace(_tipText)
	        // WAIT // Wait for .5 secs
	        _timerWait.start();
	    }
	    
	    private function onWaitTime(e:TimerEvent):void
	    {
		     if (_currentTipObj.hitTestPoint(_rootRef.stage.mouseX, _rootRef.stage.mouseY, true))
		     {
		        actuallyShow(_rootRef.stage.mouseX,_rootRef.stage.mouseY + _tipHeight);
		        _timerWait.stop();
		     }

	    }
	    
	    private function actuallyShow(xpos:Number,ypos:Number):void
	    {
	        setText(); 
			if ( (xpos + _tipWidth) > _rootRef.stage.width )
				xpos -= _tipWidth;
			
			if ( (ypos + _tipHeight) > _rootRef.stage.height )
				ypos -= (_tipHeight + _currentTipObj.height);
			_tip.x = xpos;
			_tip.y = ypos;
	        _currentTipObj.stage.addChild(_tip);
	        _timerHide.start();
	    }
	    
	    private function setText():void
	    {
			var format1_fmt:TextFormat = new TextFormat();
			format1_fmt.font = "Arial";
			format1_fmt.size = _currentFontSize;
			
	        _tip.text = _tipText;
			_tip.setTextFormat(format1_fmt);
	    }
	    
	    private function hideTip(e:TimerEvent):void
	    {
	        if (!_currentTipObj.hitTestPoint(_rootRef.stage.mouseX, _rootRef.stage.mouseY, true))
		     {
		        _currentTipObj.stage.removeChild(_tip);
		        _timerHide.stop();
		     }
	    }
		
	}
}
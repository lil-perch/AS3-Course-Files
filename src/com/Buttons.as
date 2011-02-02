/*
	This class is linked to the buttons using linkage property of the symbols in Player.fla
*/
package src.com
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class Buttons extends MovieClip
	{
		private var _stateButton:Boolean; 	//A state button has more than a single button representation. For example the audio button looks one way when audio is on. Another when off. 
											//the state is a precursor to the labels of up over down and disable.
		private var _stateCode:String;		//The state prefix
		
		public function Buttons(state:Boolean = false)
		{
			_stateButton = state; 
			_stateCode = "";
			//trace("STATE: " + _stateButton);
			this.buttonMode = true;
			this.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			this.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			var frame:String;
			if (!value) 
			{
				frame = "disable";
				if (_stateButton) frame = _stateCode + "_" + frame;
				this.gotoAndStop(frame);
			} else {
				//WE need to check to see if the mouse is over the button or not.
				frame = "up";
				if (_stateButton) frame = _stateCode + "_" + frame;
				this.gotoAndStop(frame);
			}
		}
		
		public function onRollOver(e:MouseEvent = null):void
		{
			if (this.enabled)
			{
				var frame:String = "over";
				//trace("STATE CODE: " + _stateCode);
				if (_stateButton) frame = _stateCode + "_" + frame;
				this.gotoAndStop(frame);
			}
		}
		
		public function onRollOut(e:MouseEvent = null):void
		{
			if (this.enabled)
			{
				var frame:String = "up";
				if (_stateButton) frame = _stateCode + "_" + frame;
				this.gotoAndStop(frame);
			}
		}
		
		public function onMouseDown(e:MouseEvent = null):void
		{
			if (this.enabled)
			{
				var frame:String = "down";
				//trace("STATE CODE: " + _stateCode);
				if (_stateButton) frame = _stateCode + "_" + frame;
				this.gotoAndStop(frame);
			}
		}
		
		public function onMouseUp(e:MouseEvent = null):void
		{
			if (this.enabled)
			{
				var frame:String = "over";
				if (_stateButton) frame = _stateCode + "_" + frame;
				this.gotoAndStop(frame);
			}
		}
		
		//Setter and Getter Methods
		public function set stateCode(p:String):void
		{
			_stateButton = true;
			_stateCode = p;
		}
		
		public function get stateCode():String
		{
			return _stateCode;
		}
	}
}

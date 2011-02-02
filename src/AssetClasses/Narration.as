package src.AssetClasses
{
	import flash.display.MovieClip;
	
	import src.com.Buttons;
	import src.com.RiTextArea;
	import flash.text.StyleSheet; 

	public class Narration extends MovieClip
	{
		//Stage instances
		public var narration_txt:RiTextArea;
		public var close_btn:Buttons;
		
		
		public function Narration()
		{
			//trace("Narration is loaded!");
		}
		
		public function applyCss(css:StyleSheet):void
		{
			narration_txt.textField.styleSheet = css;
		}
		
		public function applyText(text:String):void
		{
			narration_txt.htmlText = text;
		}
	}
}
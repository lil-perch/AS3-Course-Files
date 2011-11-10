package src.pages.utils
{

	public class Format
	{
		// @Convert given secods in a String with format mm:ss
		public static function doFormat(time:Number):String
		{
			var str:String;
			var sec:Number = time % 60;
			var min:Number = Number(String(time / 60).split(".")[0]);// Get the integer part														
			if (String(sec).length == 1)
			{
				str = "0"+String(sec);				
			}
			else
			{
				str = String(sec);
			}
			
			if (String(min).length == 1)
			{
				str = "0" + String(min)+":"+str;								
			}
			else
			{
				str = String(min)+":"+str;
			}
			
			
			return str;
		}
	}
}
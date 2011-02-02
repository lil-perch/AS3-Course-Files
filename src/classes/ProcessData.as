package src.classes
{
	public class ProcessData
	{
		public function ProcessData()
		{
			
		}
		
		public function stripspaces(originalstring:String):String
		{
			var original:Array=originalstring.split(" ");
			return(original.join(""));
		}
		
		public function getSkipCacheString(local:Boolean):String
		{
			if(local){
				return "";
			}
			var dStr:String = "&timestamp="+new Date().getTime();
			return "?CacheBuster="+Math.random()+dStr;
		};
	}
}
package 
{
	import flash.display.MovieClip;
	
	public class TextWithScroll extends MovieClip
	{						
		public function set text(str :String)
		{			
			message_txt.htmlText = str;
			if (message_txt.textHeight > message_txt.height)
			{				
				scroll_mc.visible = true;				
			}
			else
			{				
				scroll_mc.visible = false;							
			}
		}
	}
}
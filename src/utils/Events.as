package  src.pages.utils {

	import src.pages.utils.*;
	import flash.display.*;
	import flash.events.*;

	public class Events {

		
		public static var color_over:String="0x333333";
		public static var color_out:String="0x999999";		
		
		
		public static function setColor(_color_over:String, _color_out:String)
		{			
			color_over = _color_over;
			color_out = _color_out;
		}
		
	
		public static function doEvents(_mc:MovieClip, _fx:Function)
		{						
			_mc.fx = _fx;						
			_mc.buttonMode = true;
			_mc.mouseChildren = false;
			
			if(_mc.color_out)
			{
				Colorize.doColor(_mc.base_mc,_mc.color_out);
			}
			else
			{
				Colorize.doColor(_mc.base_mc,color_out);
			}	
			
						
			_mc.addEventListener(MouseEvent.ROLL_OVER, function (e:MouseEvent){doOver(e,_mc);});
			_mc.addEventListener(MouseEvent.ROLL_OUT,  function (e:MouseEvent){doOut(e,_mc);});
			//_mc.addEventListener(MouseEvent.RELEASE_OUTSIDE, doOut);  
			_mc.addEventListener(MouseEvent.CLICK, function (e:MouseEvent){doClick(e,_mc);});										
		}
		
	
		
		private static function  doOver(e:MouseEvent,_mc:MovieClip)
		{
			//this.base_mc.gotoAndStop("over");					
			if(_mc.color_over)
			{
				Colorize.doColor(_mc.base_mc,_mc.color_over);
			}
			else
			{
				Colorize.doColor(_mc.base_mc,color_over);
			}
		}
		private static function doOut(e:MouseEvent,_mc:MovieClip)
		{
			//this.base_mc.gotoAndStop("out");
			if(_mc.color_out)
			{
				Colorize.doColor(_mc.base_mc,_mc.color_out);
			}
			else
			{
				Colorize.doColor(_mc.base_mc,color_out);
			}			
		}
		
		private static function  doClick(e:MouseEvent,_mc:MovieClip)
		{								
			//this.base_mc.gotoAndStop("out");
			if(_mc.color_out)
			{
				Colorize.doColor(_mc.base_mc,_mc.color_out);
			}
			else
			{
				Colorize.doColor(_mc.base_mc,color_out);
			}	
									
			MovieClip(_mc).fx.apply(MovieClip(_mc).parent,[MovieClip(_mc)]);			
			
			
		}
		
	}
	
}

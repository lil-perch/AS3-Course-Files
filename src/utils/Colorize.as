package src.pages.utils
{
	import flash.display.MovieClip;
	import flash.display.GradientType;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import flash.geom.Matrix;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;


	// Class with static methods to Colorize the elements on a page.
	public class Colorize
	{


		// Change the color to a MovieClip
		public static function doColor(_btn:MovieClip, _color:String):void
		{
			TweenMax.to(_btn,0,{tint:_color});
		}




		public static function FillLinear(_mc:MovieClip, colors:Array)
		{			
			var alphas:Array = [1,1];
			var ratios:Array = [0,255];
			var w:Number = _mc.width;
			var h:Number = _mc.height;			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(w, h,0);			
			var gradient:Shape = new Shape();
			gradient.graphics.lineStyle();
			gradient.graphics.beginGradientFill(GradientType.LINEAR,colors,alphas,ratios,matrix);
			gradient.graphics.drawRect(0,0,w,h);
			gradient.graphics.endFill();			
			_mc.addChild(gradient);
		}


		public static function FillRadial(_mc:MovieClip, colors:Array)
		{				
			var alphas:Array = [1,1];
			var ratios:Array = [0,255];
			var w:Number = _mc.width;
			var h:Number = _mc.height;			
			var matrix:Matrix = new Matrix();						 
			matrix.createGradientBox(w*2,h*2,0,-w/2,-h/2);
			var gradient:Shape = new Shape();
			gradient.graphics.lineStyle();									
			gradient.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,matrix);
			gradient.graphics.drawRect(0,0,w,h);
			gradient.graphics.endFill();			
			_mc.addChild(gradient);		
		}


			


	}


}
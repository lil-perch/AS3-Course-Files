package {

	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.greensock.events.*;
	import com.greensock.loading.*;
		
	import src.pages.utils.*;
	import flash.events.MouseEvent;
	
	import flash.display.*;
	
	
	public class AlertBox extends MovieClip
	{		
		private var _fx:Function;
	
		public function AlertBox()
		{			
			lock_mc.addEventListener(MouseEvent.CLICK, doLock);
			this.visible = false;			
			message_mc.start_btn.addEventListener(MouseEvent.CLICK,hideWindow)			
		}
		
		private function doLock(event:MouseEvent)
		{
			trace("LOCKED");
		}

		public function showWindow(_msg:String, fx:Function=null)
		{			
		
			var w = MovieClip(this.parent).presentSizeW;
			var h = MovieClip(this.parent).presentSizeH;
			lock_mc.width = w;
			lock_mc.height = h;
			message_mc.x = (w-message_mc.bg_mc.width)/2;
			message_mc.y = (h-message_mc.bg_mc.height)/2;
			trace(">> WWWWWW"+w)
		
			this.visible = true;
			this.alpha = 0;			
			_fx = fx
			message_mc.message_txt.text = _msg;			
			TweenMax.killTweensOf(this);
			TweenMax.to(this, 0, {alpha: 1});
		}
								
		public function hideWindow(event:MouseEvent)
		{
			TweenMax.to(this, 0, {autoAlpha: 0, onComplete:doEnd});
		}
		
		private function doEnd()
		{
			trace("FX??? "+_fx)
			if(_fx != null)
			_fx.apply();
		}
		
	}
	
	
}
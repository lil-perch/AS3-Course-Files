package  {
	
	import flash.display.MovieClip;	
    import flash.events.EventDispatcher;
    import flash.events.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	
	
	public class ZoomImage extends MovieClip {
		
									
		
		
		public  var _imgObj :Object = new Object();
		
		private var IMG_WIDTH :Number = 0;
		private var IMG_HEIGHT :Number = 0;
		
		private var _mainWidth :Number = 0;
		private var _mainHeight :Number = 0;
		private var _xOff :Number = 0;
		private var _yOff :Number = 0;
	
		private var _isZoom :Boolean = false;
	
	
	
		
		public function ZoomImage() {
			// constructor code
		}
		
		
		public function init( w :Number, h :Number, xOff :Number, yOff :Number)
		{
			_mainWidth = w;
			_mainHeight = h;
			_xOff = xOff;
			_yOff = yOff;
			IMG_WIDTH = this.width;
			IMG_HEIGHT = this.height;			
			
			//proportionalResize(holder_mc, IMG_WIDTH, IMG_HEIGHT);
			//centerClip(holder_mc, _xOff, _yOff, IMG_WIDTH, IMG_HEIGHT);
						
			
			
			//zoom_btn.x =  holder_mc.x +  holder_mc.width - zoom_btn.width - 5;
			//zoom_btn.y =  holder_mc.y +  holder_mc.height - zoom_btn.height - 5;												
			this.addEventListener(MouseEvent.CLICK,zoomImage);
		}
		
		
		// Zoom In
			
			
		public function zoomImage(event:MouseEvent)
		{
			if (!_isZoom)
			{
				MovieClip(this.parent.parent).lock_mc.visible = true;
				MovieClip(this.parent.parent).lock_mc.alpha = 1;
												 				
								
				proportionalResize(holder_mc, _mainWidth, _mainHeight);
				centerClip(holder_mc, _xOff, _yOff, _mainWidth, _mainHeight);
				
				
				var xTo :Number = holder_mc.x;
				var yTo :Number = holder_mc.y;
				var wTo :Number = holder_mc.width;
				var hTo :Number = holder_mc.height;
				
				
				holder_mc.x = _imgObj.x;
				holder_mc.y = _imgObj.y;
				holder_mc.width = _imgObj.width;
				holder_mc.height = _imgObj.height;
				
				TweenLite.to(holder_mc, 1, {x:xTo, y:yTo, width:wTo,  height:hTo, ease:Strong.easeOut});								
				
			
				zoom_btn.visible = false;
				_isZoom = true;				
				trace("W1:: "+_imgObj.width)
			}
			else
			{								
				TweenLite.to(holder_mc, 1, {x:_imgObj.x, y:_imgObj.y, width:_imgObj.width,  height:_imgObj.height, ease:Strong.easeOut, onComplete:backZoomComplete, onCompleteParams:[MovieClip(this)]});
				//TweenLite.to(_border_mc, 1, {x:_imgObj.x, y:_imgObj.y, width:_imgObj.width,  height:_imgObj.height, ease:Strong.easeOut});
				
				trace("W2:: "+_imgObj.width)				
				TweenLite.to(MovieClip(this.parent.parent).lock_mc, 1, {alpha:0, ease:Strong.easeOut});
				_isZoom = false;				
			}
		}
		
		public function backZoomComplete(main :MovieClip)
		{
			MovieClip(this.parent.parent).lock_mc.visible = false;						
			zoom_btn.visible = true;
		}
		
		public function proportionalResize(holder_mc :MovieClip, newWidth :Number, newHeight :Number)
		{
			var ratio_x = newWidth / holder_mc.width;
			var ratio_y = newHeight / holder_mc.height;
			
			if (ratio_x <= ratio_y) 
			{
				//if (ratio_x < 1) 
				{
					holder_mc.width = newWidth;
					holder_mc.scaleY = holder_mc.scaleX;
				}
			} else 
			{
				//if (ratio_y < 1) 
				{
					holder_mc.height = newHeight;
					holder_mc.scaleX = holder_mc.scaleY;
				}
			}
		}
		
		public function centerClip(clip_mc :MovieClip, x :Number, y :Number, width :Number, height :Number)
		{
			clip_mc.y = (height - clip_mc.height) / 2 + y;
			clip_mc.x = (width - clip_mc.width) / 2 + x;
		}
		
		
	}
	
}

package {
			
	import flash.display.*;		
	
	
	// LoaderMax	
	import com.greensock.*;
 	import com.greensock.events.*;
 	import com.greensock.loading.*;
	import com.greensock.loading.display.*;	
	import com.greensock.easing.*;
	
	import src.pages.utils.*;
	import flash.events.MouseEvent;
	
	public class BorderImage extends MovieClip
	{				
		//init img place and size
		private var _imgObj :Object = new Object();
		
		private var IMGwidth :Number = 0;
		private var IMG_HEIGHT :Number = 0;
		
		private var _mainWidth :Number = 0;
		private var _mainHeight :Number = 0;
		private var _xOff :Number = 0;
		private var _yOff :Number = 0;
		
		private var _isZoom :Boolean = false;
		
		private var _border_mc;
		
		private var me;
		
		// LoaderMAX
		private var queue:LoaderMax;
		
		public function BorderImage()
		{
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			queue = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});			
			
			me = this;
			
		}
		
		
		function progressHandler(event:LoaderEvent):void {
			trace("progress: " + event.target.progress+" >>>> "+event.target.rawProgress);
		}
		
		function completeHandler(event:LoaderEvent):void {		  
							
							
			me.proportionalResize(me.holder_mc, me.IMGwidth, me.IMG_HEIGHT);
			me.centerClip(me.holder_mc, 0, 0, me.IMGwidth, me.IMG_HEIGHT);
			
			trace(" IMG WIDTH: "+me.IMGwidth+" HEI: "+ me.IMG_HEIGHT+" me: "+me+" >>> holder. widht"+me.holder_mc.width)
			
			/*
			me._border_mc = me.attachMovie("image_boder", "border", 2);
			me._border_mc.x =me.holder_mc.x;
			me._border_mc.y = me.holder_mc.y;
			me._border_mc.width = me.holder_mc.width;
			me._border_mc.height = me.holder_mc.height;
			*/
			
			me.mask_mc.x = me.holder_mc.x;
			me.mask_mc.y = me.holder_mc.y;
			me.mask_mc.width = me.holder_mc.width;
			me.mask_mc.height = me.holder_mc.height;
			
			
			me.zoom_btn.x =  me.holder_mc.x +  me.holder_mc.width - me.zoom_btn.width - 5;
			me.zoom_btn.y =  me.holder_mc.y +  me.holder_mc.height - me.zoom_btn.height - 5;
			
			//me.zoom_btn.x = 0;
			//me.zoom_btn.y = 0;
			
			me._imgObj.x = me.holder_mc.x;
			me._imgObj.y = me.holder_mc.y;
			me._imgObj.width = me.holder_mc.width;
			me._imgObj.height = me.holder_mc.height;
																				
											
								/*
		  var image:ContentDisplay = LoaderMax.getContent("image");		  
		  if(image)
		  {
			  	  var w,h;
				  w = image.width;
				  h = image.height
				  trace("IMAGE LOADED")
		  }
		  */
		}
		 
		function errorHandler(event:LoaderEvent):void {
			trace("error occured with " + event.target + ": " + event.text);
		}
		 
				
		
		public function loadImage(url :String, w :Number, h :Number, xOff :Number, yOff :Number)
		{
			
			trace("== 1* "+url+" > "+this)
			if (url == "")
			{
				this.zoom_btn.visible = false;
				this.back_mc.visible = false;
				this.holder_mc.visible = false;
				
				/* BORRAR
				_border_mc.visible = false;
				*/
			}
			else
			{
				trace(zoom_btn+"-"+back_mc+"-"+holder_mc+"-"+_border_mc)
				
				this.zoom_btn.visible = true;
				this.back_mc.visible = true;
				this.holder_mc.visible = true;
				
				/* BORRAR
				_border_mc.visible = true;
				*/
			}			
			
			_mainWidth = w;
			_mainHeight = h;
			_xOff = xOff;
			_yOff = yOff;
			
			IMGwidth = this.width;
			IMG_HEIGHT = this.height;
			
			
			queue.empty();						
			//Get JPEG file					
			queue.append(new ImageLoader(url, {name:"image", container:holder_mc}));			
			queue.load();				
			
			
			
			
			this.buttonMode = true;
			this.mouseChildren = false;
			this.back_mc.alpha = 0;
						
						
			this.addEventListener(MouseEvent.CLICK,function()
				{								
					me.zoomImage();					
				}
			);
			
							
			
			
			
		}
		
		public function zoomImage()
		{
			trace("BEFORE:: x: "+holder_mc.x+" y:"+holder_mc.y+" width "+holder_mc.width+"  height: "+holder_mc.height)
			
			if (!_isZoom)
			{
				//LOCK
				//MovieClip(parent.parent).lock_mc.visible = true;
				//MovieClip(parent.parent).lock_mc.alpha = 1;
				
				/*
				_imgObj.x = holder_mc.x;
				_imgObj.y = holder_mc.y;
				_imgObj.width = holder_mc.width;
				_imgObj.height = holder_mc.height;
				*/
				
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
				
				TweenMax.to(holder_mc, 1, {x:xTo, y:yTo, width:wTo,  height:hTo, ease:Strong.easeOut});
				/* BORRAR
				TweenMax.to(_border_mc, 1, {x:xTo, y:yTo, width:wTo,  height:hTo, ease:Strong.easeOut});
				*/
				
				TweenMax.to(mask_mc, 1, {x:xTo, y:yTo, width:wTo,  height:hTo, ease:Strong.easeOut});
			
				zoom_btn.visible = false;
				_isZoom = true;
			}
			else
			{			
				TweenMax.to(holder_mc, 1, {x:_imgObj.x, y:_imgObj.y, width:_imgObj.width,  height:_imgObj.height, ease:Strong.easeOut, onComplete:backZoomComplete, onCompleteParams:[this]});
				/*
				TweenMax.to(_border_mc, 1, {x:_imgObj.x, y:_imgObj.y, width:_imgObj.width,  height:_imgObj.height, ease:Strong.easeOut});
				*/
				TweenMax.to(mask_mc, 1, {x:_imgObj.x, y:_imgObj.y, width:_imgObj.width,  height:_imgObj.height, ease:Strong.easeOut});
				
				//LOCK
				//TweenMax.to(MovieClip(parent.parent).lock_mc, 1, {_alpha:0, ease:Strong.easeOut});
				_isZoom = false;
				
	
			}
		}
		
		public function backZoomComplete(main :MovieClip)
		{
			main.zoom_btn.visible = true;
			
			//LOCK
			//MovieClip(main.parent.parent).lock_mc.visible = false;
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
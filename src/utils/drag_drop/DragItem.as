package src.pages.utils.drag_drop
{
	import flash.display.Stage;
	import flash.display.*;
	import flash.events.*;	
	import com.greensock.*;
	import com.greensock.easing.*;
	import src.pages.utils.drag_drop.*	


	//————————————       
	public class DragItem extends MovieClip
	{


		private var iniX:Number;// Get at onPress click
		private var iniY:Number;// Get at onPress click
		private var iniXI:Number;// Get at Constructor
		private var iniYI:Number;// Get at Constructor
		public  var drag:MovieClip = new MovieClip();
		public  var drop:DropItem;

		private var ref:DragItem;
		public  var isDragging:Boolean;
		private var _reset_time:Number;
		private var _enabled:Boolean = true;
		private var __stage:Stage;
		
		private var child:MovieClip;

		//————————————
		public function DragItem(__mc:MovieClip, _stage:Stage)
		{
			__stage = _stage;


			//UIEventDispatcher.initialize(this);
			ref = this;
			drag = __mc;
			iniXI = __mc.x;
			iniYI = __mc.y;
			_enabled = true;


			isDragging = false;
			_reset_time = 0.6;
			setEvents();



		}


		private function setEvents()
		{

			var hotspot:Sprite = new Sprite();
			hotspot.name = "hotspot";
			drag.addChild(hotspot);



			hotspot.graphics.lineStyle(1,0x00ff00);
			hotspot.graphics.beginFill(0x0000FF);
			hotspot.graphics.drawRect(0,0,1,1);
			hotspot.graphics.endFill();
			hotspot.alpha = 0;
			drag.ref = this;

			drag.addEventListener(MouseEvent.MOUSE_DOWN, onMouseClick);
			drag.addEventListener(MouseEvent.MOUSE_UP, onMouseRelease);						
			drag.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveItem);

			

			drag.useHandCursor = true;
		}


		private function onMouseClick(e:Event):void
		{
			child = MovieClip(e.currentTarget);
			__stage.addEventListener(MouseEvent.MOUSE_UP, onMouseRelease); 
	
	
			if (this.ref._enabled)
			{

				TweenMax.killTweensOf(e.currentTarget);
				e.currentTarget.ref.iniX = e.currentTarget.x;
				e.currentTarget.ref.iniY = e.currentTarget.y;
				e.currentTarget.ref.isDragging = true;
				e.currentTarget.getChildByName("hotspot").x = e.currentTarget.mouseX;
				e.currentTarget.getChildByName("hotspot").y = e.currentTarget.mouseY;
				e.currentTarget.startDrag();
			

				dispatchEvent(new CustomEvent(CustomEvent.ON_START_DRAG, e.currentTarget.ref))
		
				
			}
		}

		private function onMouseRelease(e:Event):void
		{
			trace(e.target.name+" >>>> "+drag.name)
			if (e.target.name == drag.name) {
				trace("Soltaste sobre el círculo");
			}else {
				trace("Soltaste fuera del círculo");
				drag.dispatchEvent(new Event(MouseEvent.MOUSE_UP))
				return;
			}
			__stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseRelease);
		
			
		


			if (this.ref._enabled)
			{
				
				
				
				e.currentTarget.stopDrag();

				e.currentTarget.ref.isDragging = false;
				
				e.currentTarget.getChildByName("hotspot").x = 0;
				e.currentTarget.getChildByName("hotspot").y = 0;
				
				dispatchEvent(new CustomEvent(CustomEvent.ON_STOP_DRAG, e.currentTarget.ref))

			}

		}



		private function onMouseMoveItem(e:Event)
		{
			if (e.currentTarget.ref._enabled && e.currentTarget.ref.isDragging == true)
			{
				dispatchEvent(new CustomEvent(CustomEvent.ON_MOVE_DRAG, e.currentTarget.ref))
			}
		}


		public function get enabledDrag():Boolean
		{
			return _enabled;
		}
		
		public function set enabledDrag(__enabled:Boolean):void
		{
			trace("set enabled");			
			dispatchEvent(new CustomEvent(CustomEvent.ON_ENABLED_CHANGE, this))
			_enabled = __enabled;
		}

		public function reset()
		{

			TweenMax.killTweensOf(drag);
			drag.tween = TweenMax.to(drag,_reset_time,{ease:Elastic.easeOut,x:iniX,y:iniY,onUpdate:updatePos,onUpdateParams:[drag.x,drag.y],onComplete:completeTween});
			dispatchEvent(new CustomEvent(CustomEvent.ON_RESET_DRAG, this))
		}

		public function resetI()
		{
			trace("RESET I " + iniXI);
			TweenMax.killTweensOf(drag);
			drag.tween = TweenMax.to(drag,_reset_time,{ease:Elastic.easeOut,x:iniXI,y:iniYI,onUpdate:updatePos,onUpdateParams:[drag],onComplete:completeTween, onCompleteParams:[drag]});			
			dispatchEvent(new CustomEvent(CustomEvent.ON_RESET_DRAG, this))
		}

		public function silentReset()
		{
			drag.x = iniX;
			drag.y = iniY;
		}

		public function restart()
		{
			trace("remove clp " + drag);
			removeChild(drag);			
		}


		public function updatePos(__drag)
		{			
			dispatchEvent(new CustomEvent(CustomEvent.ON_UPDATE_POS, this))
		}

		public function completeTween(__drag)
		{
			trace("complete tweeen " + this);						
			dispatchEvent(new CustomEvent(CustomEvent.ON_COMPLETE, this))
		}


	}
}
package src.pages.utils.drag_drop
{
	import flash.display.*;
	import flash.events.*;
	import flash.display.Stage;
	import com.greensock.*;
	import com.greensock.easing.*;
	import src.pages.utils.drag_drop.*;	

	//————————————
	public class DropItem extends MovieClip
	{

		public  var drop:MovieClip = new MovieClip();
		public var dragTarget:DragItem;
		private var isHold:Boolean;
		private var id:Number;
		private var _enabled:Boolean = true;

		private var fields:Number;
		private var stack:Array;// DragItem



		//————————————
		public function DropItem(__mc:MovieClip, _fields:Number=1)
		{
			_enabled = true;


			fields = _fields;

			stack = new Array();
			for (var i = 0; i < fields; i++)
			{
				stack[i] = undefined;
			}

			drop = __mc;
			isHold = false;
		}


		public function setDrag(__drag:DragItem)
		{
			dragTarget = __drag;
			isHold = true;
		}


		public function setID(__id:Number)
		{
			id = __id;
		}

		public function getID():Number
		{
			return id;
		}

		public function delDrag()
		{
			dragTarget = undefined;
			isHold = false;
		}

		public function getTarget()
		{
			return dragTarget;
		}

		public function getHold():Boolean
		{
			return isHold;
		}


		// Eval if __drag hits with this Drop movieelip
		public function evalHit(__drag)
		{
			var hit:Boolean = false;
			if (__drag.hitTestObject(this.drop))
			{
				return true;
			}

			return false;
		}

		// Checks if the Drop has an empty field in teh stack
		public function checkAvailable()
		{
			for (var i = 0; i < fields; i++)
			{
				if (stack[i] == undefined)
				{
					return true;
				}
			}
			return false;
		}

		// Clear one bussy position in the stack
		public function clearPosition(__drag:DragItem)
		{
			for (var i = 0; i < fields; i++)
			{
				if (stack[i] == __drag)
				{
					trace("Clear " + i);
					stack[i] = undefined;
					return;
				}
			}
		}

		// Mark one position  as busy in the stack
		public function addPosition(__drag:DragItem)
		{
			for (var i = 0; i < fields; i++)
			{
				if (stack[i] == undefined)
				{
					trace("add " + i);
					stack[i] = __drag;
					return;
				}
			}


		}

		// Ubicate the Drag in the correct position: THIS NEED TO BE AN IMPLEMENTATION
		public function reubicateDrag()
		{

			for (var i = 0; i < fields; i++)
			{
				if (stack[i] != undefined)
				{
					trace("REUBIC " + stack[i].drop.drop);

					TweenMax.to(stack[i].drag,0.3,{x:stack[i].drop.drop.x + stack[i].drop.drop.holder.x, y:stack[i].drop.drop.y + stack[i].drop.drop.holder.y + 35 * i});
					//stack[i].drag._y = stack[i].drop.drop._y+stack[i].drop.drop.holder._y+35*i;
					//stack[i].drag._x = stack[i].drop.drop._x+stack[i].drop.drop.holder._x;

				}

			}
		}

		public function restart()
		{
			for (var i = 0; i < fields; i++)
			{

				stack[i].restart();
				stack[i].drag.killMovieClip();
				trace("REstart: " + i + " -- " + stack[i]);
				delete stack[i];
				stack[i] = undefined;

			}

		}

		public function get enabledDrop():Boolean
		{
			return _enabled;
		}
		public function set enabledDrop(__enabled:Boolean):void
		{
			trace("Enabld Drop " + __enabled);
			//var evt:Object = {target:this, type:"onEnabledChange", value:__enabled};
			//dispatchEvent(evt);
			dispatchEvent(new CustomEvent(CustomEvent.ON_ENABLED_CHANGE,this, __enabled));
			_enabled = __enabled;
		}


	}
}
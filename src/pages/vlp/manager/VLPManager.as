/**
 * 
 **/
package src.pages.vlp.manager {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import src.pages.vlp.view.objects.ObjectView;
	import flash.geom.Matrix;
	import src.pages.vlp.view.objects.ImageView;
	import src.pages.vlp.view.objects.SwfView;

	public class VLPManager extends EventDispatcher {

		/** Normal scale mode **/
		public static const SCALE_NORMAL:String = "scaleNormal";

		/** Scale only <code>width</code> and <code>height</code> properties **/
		public static const SCALE_WIDTH_AND_HEIGHT:String = "scaleWidthAndHeight";
		
		private var _items:Array; 

		/** @private the parent of the items (they all must share the same parent!)**/
		private var _parent:DisplayObjectContainer; 

		public function VLPManager($vars:Object = null) {
			if ($vars == null) {
				$vars = {};
			}
			init($vars);
		}
		
		protected function init($vars:Object):void {
			_items = $vars.items || [];
			if ($vars.targetObjects != undefined) {
				addItems($vars.targetObjects);
			}
		}
		
		public function addItem($targetObject:DisplayObject, $scaleMode:String="scaleNormal", $hasSelectableText:Boolean=false):* {			
			_items.push($targetObject);
			return $targetObject;
		}
		
		public function addItems($targetObjects:Array, $scaleMode:String="scaleNormal", $hasSelectableText:Boolean=false):Array {
			var a:Array = [];
			for (var i:uint = 0; i < $targetObjects.length; i++) {
				a.push(addItem($targetObjects[i], $scaleMode, $hasSelectableText));
			}
			return a;
		}

		public function applyFullXML(xml:XML, defaultParent:DisplayObjectContainer, placeholderColor:uint=0xCCCCCC):Array {
			var node:XML, mc:DisplayObject;
			
			var parent:DisplayObjectContainer = _parent || defaultParent;
			var missing:Array = [];
			var all:Array = [];
			var isMissing:Boolean;
			var list:XMLList = xml.items[0].item;
			for each (node in list) {
				if(node.@oType != 'BackgroundAudio'){
					isMissing = Boolean(parent.getChildByName(node.@name) == null);
					mc = applyItemXML(node, parent, placeholderColor);
					all.push({level:Number(node.@level), mc:mc, node:node});
					if (isMissing) {
						missing.push(mc);
					}
				}
			}
			all.sortOn("level", Array.NUMERIC | Array.DESCENDING);
			var numChildren:uint = parent.numChildren;
			var i:int = all.length;
			
			while (i--) {
				if (all[i].level < numChildren && all[i].mc.parent == parent) {
					if (parent.hasOwnProperty("setElementIndex")) { //for Flex compatibility (spark)
						(parent as Object).setElementIndex(all[i].mc, all[i].level);
					} else {
						parent.setChildIndex(all[i].mc, all[i].level);
					}
				}
			}
			
			return missing;
		}
		
		public function applyItemXML(xml:XML, defaultParent:DisplayObjectContainer=null, placeholderColor:uint=0xCCCCCC):DisplayObject {
			var parent:DisplayObjectContainer = _parent || defaultParent;
			var mc:DisplayObject = parent.getChildByName(xml.@name);
			if (mc == null) {
				trace("Error: Could not find item");
			}
			if (xml.@scaleMode == VLPManager.SCALE_WIDTH_AND_HEIGHT) { 
				mc.width = Number(xml.@rawWidth);
				mc.height = Number(xml.@rawHeight);
			}
			var m:Matrix = mc.transform.matrix = new Matrix(Number(xml.@a), Number(xml.@b), Number(xml.@c), Number(xml.@d), Number(xml.@tx), Number(xml.@ty));
			if (parent.numChildren > xml.@level && mc.parent == parent) {
				if (parent.hasOwnProperty("setElementIndex")) { //for Flex compatibility (spark)
					(parent as Object).setElementIndex(mc, xml.@level);
				} else {
					parent.setChildIndex(mc, xml.@level);
				}
			}
			mc.transform.matrix = m;
			if(xml.@oType == 'Swf'){
				(mc as SwfView).loadSWF();
			}
			return mc;
		}
	}
}
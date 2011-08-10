package src.classes
{
	import fl.controls.ScrollBarDirection;
	import fl.controls.UIScrollBar;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import src.com.Alerts;


	public class InfoPanel extends Sprite
	{
		private var theStage:Stage;
		private var actKey:int;
		private var dialog:Sprite;
		private var bckgrnd:Shape;
		private var bc:Shape;
		private var _width:Number;
		private var _height:Number;
		private var txtField:TextField;
		private var isShown:Boolean = false;
		private var allInfo:Array;
		private var obj:Sprite;
		private var vScrollBar:UIScrollBar;
		
		private var developmentMode:Boolean = true;
		
		public function InfoPanel(st:Stage,wid:Number = 600,hi:Number = 400,activeKey:int = 192,tColor:int = 0x000000,bColor:int = 0xFFFFFF)
		{
			super()
			allInfo = new Array();
			theStage = st;
			actKey = activeKey;
			theStage.addEventListener(KeyboardEvent.KEY_UP, showDialog);
			_width = wid;
			_height = hi;
			obj = this;
			
			bckgrnd = new Shape();
			bckgrnd.graphics.clear();
			bckgrnd.graphics.beginFill(bColor);
			bckgrnd.graphics.drawRect(0, 0, _width + 13, _height + 35);
			bckgrnd.graphics.endFill();
			bckgrnd.alpha = 0.8;
			this.addChild(bckgrnd);
			
			dialog = new Sprite();
			var gr:Graphics = dialog.graphics;
			gr.lineStyle();
			gr.beginFill(0x000000,1);
			gr.drawRect(0, 0, _width + 13, 35);
			gr.endFill()
			this.addChild(dialog);
			
			
			txtField = new TextField();
			txtField.textColor = tColor;
			txtField.x = 2;
			txtField.y = 35;
			txtField.height = _height - 4;
			txtField.width = _width - 4;
			txtField.border = true;
			txtField.borderColor = tColor;
			txtField.defaultTextFormat = new TextFormat("Verdana", 12, tColor);
			this.addChild(txtField);
			
			vScrollBar = new UIScrollBar();
			vScrollBar.direction = ScrollBarDirection.VERTICAL;
			vScrollBar.move(txtField.x + txtField.width, txtField.y);
			vScrollBar.height = txtField.height;
			vScrollBar.scrollTarget = txtField;
			this.addChild(vScrollBar);
			
			dialog.addEventListener(MouseEvent.MOUSE_DOWN,startDragging);
			dialog.addEventListener(MouseEvent.MOUSE_UP,stopDragging);
			//theStage.addChild(this);
		}
		
		private function startDragging(e:MouseEvent):void
		{
			obj.startDrag(false);
		}
		
		private function stopDragging(e:MouseEvent):void
		{
			obj.stopDrag();
		}
		
		public function clearPanel():void
		{
			allInfo.push(txtField.text);
			txtField.text = "";
			vScrollBar.update();
		}
		
		public function updatePanel(info:String):void
		{
			txtField.text = txtField.text + "\n----------------------------------------------------------\n" + info;
			vScrollBar.update();
		}
		
		public function addToPreviousUpdate(info:String):void
		{
			txtField.text = txtField.text + "\n" + info;
			vScrollBar.update();
		}
		
		private function showDialog(e:KeyboardEvent):void
		{
			//trace(e.keyCode);
			if (e.keyCode == actKey && e.altKey == true && e.ctrlKey == true && e.shiftKey == true)
			{
				//trace("Cleared Info.....");
				showAllInfo();
			} else if (e.keyCode == actKey && e.ctrlKey == true && e.shiftKey == true) {
				if (isShown)
				{
					theStage.removeChild(this);
					isShown = false;
				} else {
					theStage.addChild(this);
					vScrollBar.update();
					isShown = true;
				}
			} else if (e.keyCode == actKey && developmentMode) {
				if (isShown)
				{
					theStage.removeChild(this);
					isShown = false;
				} else {
					theStage.addChild(this);
					vScrollBar.update();
					isShown = true;
				}
			}
		}
		
		private function showAllInfo():void
		{
			var lastStuff:String = txtField.text;
			txtField.text = "";
			if (allInfo.length > 0)
			{
				for (var i:Number = 0; i<allInfo.length;i++)
				{
					trace(i + " - " + allInfo[i])
					txtField.text = txtField.text + allInfo[i];
				}
			}
			trace(lastStuff);
			txtField.text = txtField.text + lastStuff;
		}
	}
}
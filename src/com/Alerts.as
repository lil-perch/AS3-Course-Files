package src.com
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.filters.GlowFilter;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.display.SpreadMethod;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import com.greensock.easing.*
	import com.greensock.*;

	public class Alerts extends Sprite
	{
		private var _aText:String;
		private var _rbText:String;
		private var _lbText:String;
		private var _bkgnd:Sprite;
		private var _stWidth:Number;
		private var _stHeight:Number;
		private var _lineColor:uint = 0xCCCCCC;
		private var _lineSize:uint = 1;
		private var _fillColor:uint = 0xFCFCFC;
		private var _glowColor:uint = 0xCCCCCC;
		private var _blurXY:uint = 30;
		private var _glowAlpha:Number = 0.6;
		private var _w:Number = 400;
		private var _h:Number = 150;
		private var _iwh:Number = 30; //Ellipse size for rounded corners on rectangle
		private var _rightBtn:AlertButton;
		private var _leftBtn:AlertButton;
		private var _txtCol:uint = 0x333333;
		private var _fntSize:uint = 14;
		private var _font:String = "Verdana";
		private var dialog:Sprite;
		private var _headText:String;
		private var _headHite:uint = 30;
		private var _headFontSz:uint = 16;
		private var _headFontColor:uint = 0xFFFFFF;//0xE3E3E3;
		
		public static const RIGHT_BUTTON_CLICK:String = "rightButtonClick";
		public static const LEFT_BUTTON_CLICK:String = "leftButtonClick";
		
		public function Alerts()
		{
			
		}
		
		public function set alertText(t:String):void
		{
			_aText = t;
		}
		
		public function set rightButtonText(t:String):void
		{
			_rbText = t;
		}
		
		public function set leftButtonText(t:String):void
		{
			_lbText = t;
		}
		
		public function set headerText(t:String):void
		{
			_headText = t;
		}
		
		public function showAlert():void
		{
			//First Create transparent background to block out all other clicks.
			_stWidth = stage.stageWidth;
			_stHeight = stage.stageHeight;
			trace(_stWidth + " - " + _stHeight);
			_bkgnd = new Sprite;
			var gr:Graphics = _bkgnd.graphics;
			gr.beginFill(0xFFFFFF,0.8);
			gr.drawRect(0,0,_stWidth,_stHeight);
			gr.endFill();
			this.addChild(_bkgnd);
			
			//Create the rectangle
			dialog = makeRectangle();
			var dx:Number = (_stWidth - _w)/2;
			var dy:Number = (_stHeight - _h)/2;
			dialog.x = dx;
			dialog.y = dy;
			
			//Make Header
			var header:Sprite = makeHeader();
			header.x = header.y = 0;
			dialog.addChild(header);
			
			var headTxt:TextField = makeHeaderText();
			headTxt.mouseEnabled = false;
			headTxt.x = 5;
			headTxt.y = 3;
			dialog.addChild(headTxt);
			
			_rightBtn = new AlertButton(80, 30, 10, 2, 0x00AEEF, 0x4092E1, _rbText, 0xFFFFFF, 0xCCCCCC);
			_rightBtn.x = _w -10 - _rightBtn.width;
			_rightBtn.y = _h - 5 - _rightBtn.height;
			_rightBtn.addEventListener(MouseEvent.CLICK,rightButtonClick);
			dialog.addChild(_rightBtn);
			if (_lbText != null) 
			{
				_leftBtn = new AlertButton(80, 30, 10, 2, 0x00AEEF, 0x4092E1, _lbText, 0xFFFFFF, 0xCCCCCC);//0x4092E1
				_leftBtn.x = _rightBtn.x - _leftBtn.width - 10;
				_leftBtn.y = _rightBtn.y;
				_leftBtn.addEventListener(MouseEvent.CLICK,leftButtonClick);
				dialog.addChild(_leftBtn);
			}
			
			var txt:TextField = makeTextField();
			txt.mouseEnabled = false;
			txt.y = 35;
			txt.x = 10;
			dialog.addChild(txt);
			//Add Events
			dialog.addEventListener(MouseEvent.MOUSE_DOWN,startDragging);
			dialog.addEventListener(MouseEvent.MOUSE_UP,stopDragging);
			dialog.alpha = 0;
			addChild(dialog);
			var indexTween:TweenLite = new TweenLite(dialog, 0.5, {alpha:1, ease:Strong.easeOut});
		}
		
		private function rightButtonClick(e:MouseEvent):void
		{
			hideDialog();
			dispatchEvent(new Event(Alerts.RIGHT_BUTTON_CLICK));
		}
		
		private function leftButtonClick(e:MouseEvent):void
		{
			hideDialog();
			dispatchEvent(new Event(Alerts.LEFT_BUTTON_CLICK));
		}
		
		private function hideDialog():void
		{
			dialog.removeEventListener(MouseEvent.MOUSE_DOWN,startDragging);
			dialog.removeEventListener(MouseEvent.MOUSE_UP,stopDragging);
			if (_rbText) _rightBtn.removeEventListener(MouseEvent.CLICK,rightButtonClick);
			if (_lbText) _leftBtn.removeEventListener(MouseEvent.CLICK,leftButtonClick)
			removeChild(dialog);
			removeChild(_bkgnd);
		}
		
		private function startDragging(e:MouseEvent):void
		{
			var rect:Rectangle = new Rectangle(0,0,_stWidth - e.target.width,_stHeight-e.target.height);
			dialog.startDrag(false,rect);
		}
		
		private function stopDragging(e:MouseEvent):void
		{
			dialog.stopDrag();
		}
		
		private function makeTextField():TextField
		{
			var txt:TextField = new TextField();
			txt.width = _w - 20;
			txt.height = 95;
			txt.multiline = true;
			txt.wordWrap = true;

			var format:TextFormat = new TextFormat();
			format.font = _font;
			format.color = _txtCol;
			format.size = _fntSize;
			format.bold = false;
			format.align = TextFormatAlign.LEFT;

			txt.defaultTextFormat = format;
			txt.text = _aText;
			txt.selectable = false;
			
			return txt;
		}
		
		private function makeRectangle():Sprite
		{
			//Create filter
			var gl:GlowFilter = new GlowFilter();
			gl.color = _glowColor;
			gl.blurX = gl.blurY = _blurXY;
			gl.alpha = _glowAlpha;
			
			//Create Gradient Fill
			var gradType:String = GradientType.LINEAR;
			var spread:String = SpreadMethod.PAD;
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(_w,_h,90*(Math.PI/180),0,0);
			var colors:Array = [0xFFFFFF,0xE7E7E7];
			var alphas:Array = [0.9,0.9];
			var ratios:Array = [0,255];
			
			var rect:Sprite = new Sprite();
			var gr:Graphics = rect.graphics;
			
			//gr.beginFill(_fillColor,1);
			gr.clear();
			gr.beginGradientFill(gradType,colors,alphas,ratios,matrix);
			gr.lineStyle(_lineSize,_lineColor,2);
			//gr.drawRect(50,50,400,200);
			
			//gr.drawRoundRect(0,0,_w,_h,_iwh,_iwh);
			var curveNum:Number = _iwh/2;
			gr.moveTo(curveNum,0);
			gr.lineTo(_w-curveNum,0);
			gr.curveTo(_w,0,_w,curveNum);
			gr.lineTo(_w,_h-curveNum);
			gr.curveTo(_w,_h,_w-curveNum,_h);
			gr.lineTo(curveNum,_h);
			gr.curveTo(0,_h,0,_h-curveNum);
			gr.lineTo(0,curveNum);
			gr.curveTo(0,0,curveNum,0);
			
			gr.endFill();
			
			rect.filters = [gl];
			
			return rect;
		}
		
		private function makeHeader():Sprite
		{
			var head:Sprite = new Sprite();
			
			//Create Gradient Fill
			var gradType:String = GradientType.LINEAR;
			var spread:String = SpreadMethod.PAD;
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(_w,_h,90*(Math.PI/180),0,0);
			var colors:Array = [0x999999,0xCCCCCC];//[0x555555,0x333333];
			var alphas:Array = [0.9,0.9];
			var ratios:Array = [0,255];
			
			var gr:Graphics = head.graphics;
			gr.clear();
			gr.beginGradientFill(gradType,colors,alphas,ratios,matrix);
			//gr.lineStyle(1,0x000000,1);
			gr.lineStyle(2,_lineColor,1);
			
			//Draw the header
			var curveNum:Number = _iwh/2;
			gr.moveTo(curveNum,0);
			gr.lineTo(_w-curveNum,0);
			gr.curveTo(_w,0,_w,curveNum);
			gr.lineTo(_w,_headHite);
			gr.lineTo(0,_headHite);
			gr.lineTo(0,curveNum);
			gr.curveTo(0,0,curveNum,0);
			gr.endFill();
			
			return head;
		}
		
		private function makeHeaderText():TextField
		{
			var txt:TextField = new TextField();
			txt.width = _w - 20;
			txt.height = _headHite;

			var format:TextFormat = new TextFormat();
			format.font = _font;
			format.color = _headFontColor;
			format.size = _headFontSz;
			format.bold = true;
			format.align = TextFormatAlign.LEFT;

			txt.defaultTextFormat = format;
			txt.text = _headText;
			txt.selectable = false;
			
			return txt;
		}
	}
}
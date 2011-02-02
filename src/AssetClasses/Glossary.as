package src.AssetClasses
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import src.CourseModel;
	import src.GlossaryModel;
	import src.com.Buttons;
	import src.com.RiTextArea; 
	
	import fl.containers.ScrollPane;
	import fl.events.ScrollEvent;
	import fl.controls.ScrollBarDirection;
	
	/*import fl.containers.ScrollPane;
	import fl.events.ScrollEvent;
	import fl.controls.ScrollBarDirection;*/

	public class Glossary extends MovieClip
	{
		//Stage instances
		public var term_txt:TextField;
		public var description_txt:RiTextArea;
		public var scrollPane:ScrollPane;
		public var close_btn:Buttons;
		public var title_bar_mc:Sprite;
		public var background_mc:Sprite;
		public var menuLetter_mc:MovieClip;
		
		private var _model:GlossaryModel;
		private var _courseModel:CourseModel;
		
		
		public function Glossary()
		{
			//trace("GLossary is here!");
		}
		
		public function setUpControls():void
		{
			//trace("setting up controls");
			close_btn.addEventListener(MouseEvent.CLICK,closeGlossary);
			title_bar_mc.buttonMode = true;
			title_bar_mc.addEventListener(MouseEvent.MOUSE_DOWN,startDragging);
			title_bar_mc.addEventListener(MouseEvent.MOUSE_UP,stopDragging);
			removeChild(menuLetter_mc);
			
			scrollPane.addEventListener(ScrollEvent.SCROLL, scrollHandler);
		}
		
		function scrollHandler(event:ScrollEvent):void {
		    /*switch (event.direction) {
		        case ScrollBarDirection.HORIZONTAL:
		            trace("horizontal scroll", event.position, "of", event.currentTarget.maxHorizontalScrollPosition);
		            break;
		        case ScrollBarDirection.VERTICAL:
		            trace("vertical scroll", event.position, "of", event.currentTarget.maxVerticalScrollPosition);
		            trace("Position: " + event.currentTarget.verticalScrollPosition);
		            break;
		    }*/
		    model.changeScrollPosition(event.position,false);
		}
		
		public function createMenuLetter(l:String,xPos:Number,yPos:Number,uColor:uint,oColor:uint,unLine:Boolean,scrollPos:Number,leftSizing:Boolean = false):void
		{
			var letter:MovieClip = new MenuLetter();
			letter.name = l+"_mc";
			letter.x = xPos;
			letter.y = yPos;
			letter.letter_txt.text = l;
			letter.upColor = uColor;
			letter.overColor = oColor;
			letter.underline = unLine;
			letter.scrollPos = scrollPos;
			if (leftSizing)
			{
				letter.letter_txt.autoSize = TextFieldAutoSize.LEFT;
			}
			addChild(letter);
		}
		
		public function closeGlossary(e:MouseEvent):void
		{
			courseModel.glossaryState = "hidden";
		}
		
		public function scrollGlossary(sPos:Number):void
		{
			//trace("SCROLL: " + sPos);
			model.changeScrollPosition(sPos,true);
			
		}
		
		private function startDragging(e:MouseEvent):void
		{
			MovieClip(this.parent.parent).startDrag(false)
		}
		
		private function stopDragging(e:MouseEvent):void
		{
			MovieClip(this.parent.parent).stopDrag()
		}
		
		//Since this control file is linked to a media_control.fla, we get the model using setters.
		public function set model(m:GlossaryModel):void
		{
			_model = m;
		}
		
		public function get model():GlossaryModel//This way the view class can be used with any model.
		{
			return _model;
		}
		
		public function set courseModel(m:CourseModel):void
		{
			_courseModel = m;
		}
		
		public function get courseModel():CourseModel//This way the view class can be used with any model.
		{
			return _courseModel;
		}
	}
}
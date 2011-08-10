package src.AssetClasses
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import src.CourseModel;

	public dynamic class TocPage extends MovieClip //We don't subclass Controller because this needs MovieClip elements. Model is stored in the parent.
	{
		private var _selectable:Boolean;
		private var _doToolTip:Boolean;
		private var _selected:Boolean;
		private var _highlightChange:Boolean; //Will mouseover color be different because it is highlighted.
		private var _index:int;						// Index for keeping track of page among all pages (even those not showig in the TOC).
		private var _arrayIndex:int;				//Index for keeping track of page in visited array and selected array
		private var _toc:Toc;
		private var _visited:String; 			// Either a "1" (visited) or a "0" (not visited).
		private var _selectValue:String;			// Either a "1" (able to be selected) or a "0" (can't select it)
		
		public function TocPage(p:Toc = null)
		{
			_toc = p;
			this.addEventListener(MouseEvent.CLICK,clicked);
			this.addEventListener(MouseEvent.ROLL_OVER,over);
			this.addEventListener(MouseEvent.ROLL_OUT,out);
			_highlightChange = false;
		}
		
		public function clicked(e:MouseEvent):void
		{
			if (_selectable)
			{
				var idx:int = this.index;
				_toc.courseModel.changeNormalPage(idx);
			}
		}
		
		public function over(e:MouseEvent):void
		{
			//trace("mouse: " + e.target.stage.mouseX + "-" + e.target.stage.mouseY + "-" + root.stage.mouseX + "-" + root.stage.mouseY);
			if (_selectable)
			{
				this.y = this.y-1;
				this.x = this.x+1;
				//trace("Color: " + parent.iOColor.toString(16));
				if (_toc.useInterfaceColor)
				{
					if (_highlightChange)
					{
						this.Page_txt.setTextFormat(_toc.highOFmt);
					} else {
					//Need to bring in color from the tool.
					}
				} else {
					if (_highlightChange)
					{
						this.Page_txt.setTextFormat(_toc.highOFmt);
					} else {
						this.Page_txt.setTextFormat(_toc.overFmt);
					}
				}
			}
			if (_doToolTip){
				_toc.toolTipObj.showTip(this,this.Page_txt.text);
			}
		}
		
		public function out(e:MouseEvent):void
		{
			if (_selectable)
			{
				this.y = this.y+1;
				this.x = this.x-1;
				if (_toc.useInterfaceColor)
				{
					if (_highlightChange)
					{
						this.Page_txt.setTextFormat(_toc.highFmt);
					} else {
						//Need to bring in color from the tool.
					}
					
				} else {
					if (_highlightChange)
					{
						this.Page_txt.setTextFormat(_toc.highFmt);
					} else {
						this.Page_txt.setTextFormat(_toc.pageFmt);
					}
				}
			}
		}
		//Setter and Getter Methods
		public function set selectable(b:Boolean):void
		{
			_selectable = b;
			if (b) 
				this.buttonMode = true;
			else
				this.buttonMode = false;
		}
		
		public function get selectable():Boolean
		{
			return _selectable;
		}
		
		public function set toolTip(b:Boolean):void
		{
			_doToolTip = b;
		}
		
		public function get toolTip():Boolean
		{
			return _doToolTip;
		}
		
		public function set selected(b:Boolean):void
		{
			_selected = b;
			if (_toc.useHighlightColor && b)
				_highlightChange = true;
			else
				_highlightChange = false;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set index(i:int):void
		{
			_index = i;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set visited(i:String):void
		{
			_visited = i;
		}
		
		public function get visited():String
		{
			return _visited;
		}
		
		public function set selectValue(i:String):void
		{
			_selectValue = i;
			if (i == "0") _selectable = false;
			else _selectable = true;
		}
		
		public function get selectValue():String
		{
			return _selectValue;
		}
		
		public function set arrayIndex(i:int):void
		{
			_arrayIndex = i;
		}
		
		public function get arrayIndex():int
		{
			return _arrayIndex;
		}
	}
}
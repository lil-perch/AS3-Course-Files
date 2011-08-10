package src.AssetClasses
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	
	import src.AssetClasses.TocPage;
	import src.AssetClasses.TocTopic;
	import src.CourseModel;
	import src.LmsCom;
	import src.Model;
	import src.classes.InfoPanel;
	import src.classes.Settings;
	import src.classes.Tooltip;
	
	public class Toc extends MovieClip
	{
		//The following are instances of symbols in the library merely for the purpose of determing height and width
		//They are eventually hidden.
		public var highlight_mc:Sprite;
		public var page_mc:MovieClip;
		public var checkmark_mc:Sprite;
		public var topic_mc:MovieClip;
		
		public var iTColor:uint;		//Topic Color
		public var iPColor:uint;		//Page Color
		public var iOColor:uint;		//Mousever Over color for page.
		public var iDColor:uint;		//Page disabled color
		public var useHighlightColor:Boolean; //Whether or not we should use highlight color;
		public var highlightTxtColor:uint; //Color text changes to when page is highlighted.
		public var useInterfaceColor:Boolean //Whether or not this style changes colors.
		public var moveJustTopicText:Boolean //Is the topic MC indented or just the text.
		public var leftJustifiedHighlight:Boolean //Is the highlight for the index always left justified?
		public var courseModel:CourseModel;
		public var toolTipObj:Tooltip;		//Instance of tooltip.
		
		public var topicFmt:TextFormat;
		public var pageFmt:TextFormat;
		public var overFmt:TextFormat;
		public var highFmt:TextFormat; 		//Format for text when page is highlighted.
		public var highOFmt:TextFormat;		//Used for mouseOver and highlight text change.
		public var disFmt:TextFormat; 		//disabled style for page.
		
		private var _feedbackPanel:InfoPanel;//For displaying data during runtime.
		private var _nX:Number;          	// The minimum X indent for the TOC items
		private var _nY:Number;          	// the Y location of the TOC item
		private var _nHeight:Number;         // height of a TOC page
		private var _ntHeight:Number;		//Height of toc topic
		private var _nCheckWidth:Number;   	// width of checkmark
		private var _highlightSize:Number;
		private var _nIndex:int;			// for naming pages.
		private var _tIndex:int;			// For naming topics
		private var _vIndex:int;			// For populating the visited array
		private var _nLevel:int;
		private var _settings:Settings;		// contains settings.
		private var _doToolTip:Boolean;		//Should we do tooltip?
		private var _lastSelectedPage:MovieClip; //Last selected page in index.
		private var _lmsLink:LmsCom;		//provides link to the LmsCom instance for LMS communication.
		private var _visited_array:Array;	//Keeps track of pages that have been visited.
		private var _selectable_array:Array	//Keeps track of pages that are selectable
		private var _maxSelectNode:Number = 0; //The maximum selectable node -- not currently used
		private var _currentTopic:MovieClip; //Keeps track of the current topic that is being built.
		private var _pageArray:Array = new Array(); 		//Keeps an array of pages in a specific topic.
		
		public function Toc():void
		{
			_nLevel = 0;
			_nX = 0;
			_nY = 5;
			_nHeight = page_mc.height;
			_ntHeight = topic_mc.height;
			_nCheckWidth = checkmark_mc.width;
			_highlightSize = highlight_mc.width;
			_nIndex = 0;
			_tIndex = 0;
			_vIndex = 0;
			//remove and hide instances
			this.removeChild(page_mc);
			this.removeChild(checkmark_mc);
			this.removeChild(topic_mc);
			highlight_mc.visible = false;
			toolTipObj = new Tooltip(this,12);
		}
		
		public function buildIndex(m:CourseModel,tc:uint,pc:uint,oc:uint,dc:uint,st:Settings,hc:uint):void
		{
			trace("CREATING TOPIC AND PAGES IN THE INDEX.");
			courseModel = m;
			_feedbackPanel = courseModel.feedbackPanel;
			_lmsLink = courseModel.lmsLink;
			iTColor = tc;
			iPColor = pc;
			iOColor = oc;
			iDColor = dc;
			topicFmt = new TextFormat();
			topicFmt.color = iTColor;
			pageFmt = new TextFormat();
			pageFmt.color = iPColor;
			pageFmt.underline = false;
			overFmt = new TextFormat();
			overFmt.color = iOColor;
			overFmt.underline = true;
			disFmt = new TextFormat();
			disFmt.color = iDColor;
			disFmt.underline = false;
	
			var bSelectable:Boolean = true; // this topic is selectable

			useHighlightColor = (!hc == 0);
			if (useHighlightColor)
			{
				highlightTxtColor = hc;
				highFmt = new TextFormat();
				highFmt.color = highlightTxtColor;
				highFmt.underline = false;
				highOFmt = new TextFormat();
				highOFmt.color = highlightTxtColor;
				highOFmt.underline = true;
			}

			_settings = st;
			useInterfaceColor = _settings.useInterfaceColors;
			moveJustTopicText = _settings.moveJustTopicText;
			leftJustifiedHighlight = _settings.leftJustifiedHighlight;
			_doToolTip = courseModel.courseAttributes.indexTooltip;
			
			//Read in state information
			var suspend_str:String = _lmsLink.apiGetState("toc");
			_visited_array = new Array();
			_selectable_array = new Array();
			// see if we have a suspend string
			if (suspend_str != null && suspend_str != "")
			{
				// there is, break it apart (visited array, current selection, maximum selection)
				var suspend_array:Array = suspend_str.split(":");
				_visited_array = suspend_array[0].split(",");
				_maxSelectNode = suspend_array[1] - 0;
				_selectable_array = suspend_array[2].split(",");
			}
			//Output results.
			courseModel.feedbackPanel.updatePanel("visit: " + _visited_array.toString() + " -seletable: " + _selectable_array.toString());
			
			for each (var item in m.topicAndPages) {
			   // trace("I: " + item.localName());
			    if (item.localName().toLowerCase() == "page" && item.@nonNavPage.toString().toLowerCase() != "true")
			    {
					if (item.@isTocEntry.toString().toLowerCase() != "false")
					{
						_pageArray = [];//Empties page array
						createPage(item,_nLevel,bSelectable);
					} else {
						item.@pageName = "Page"+_nIndex;
						_nIndex++;
					}
					
			    } else if (item.localName().toLowerCase() == "topic" && item.@showTopicPages.toString().toLowerCase() != "false") {
					_pageArray = [];//Empties page array
					createTopic(item,_nLevel,bSelectable);
			    	bSelectable = item.@nav.toString().toLowerCase() != "complete";
			    } else if (item.localName().toLowerCase() == "quiz") {
					_pageArray = [];
					//parseQuiz(item);
					if (item.@isTocEntry.toString().toLowerCase() != "false")
					{
						createPage(item,_nLevel,bSelectable);
					} else {
						item.@pageName = "Page"+_nIndex;
						_nIndex++;
					}
					//parseQuiz(item); //No longer needed.
				}
			}
			updateState();
		}
		
		public function createPage(p:XML,nLevel:int,bSelectable:Boolean):void
		{
			var this_mc:MovieClip = new TocPage(this);
			
			// set the X and Y locations
			this_mc.x = _nX + nLevel * _nCheckWidth;
			this_mc.y = _nY;
			this_mc.nLevel = nLevel;
	
			this_mc.name = "Page"+_nIndex;
			p.@pageName = this_mc.name;
			this_mc.index = _nIndex;
			this_mc.arrayIndex = _vIndex;
			
			//Set text
			this_mc.Page_txt.text = p.@title;
			if (useInterfaceColor)
			{
				//Need to bring in color from the tool.
			} else {
				this_mc.Page_txt.setTextFormat(pageFmt);
			}
			
			this_mc.mouseChildren = false; //Set this so hand cursor will show.
			//Is it selectable. If so set the selectable to true.
			this_mc.selectable = true;
			//Set tooltip
			this_mc.toolTip = _doToolTip;
			// increment the location for the next TOC entry
			_nY += _nHeight;
			
			// see if we have data in the visited array
			if (_visited_array[_vIndex] == undefined)
			{
				// we do not, initialize it to not visited
				_visited_array[_vIndex] = "0";
			} else if (_visited_array[_vIndex] == "1"){
				this_mc.visited = "1";
			}
			
			// see if we have data in the selectable array
			if (_selectable_array[_vIndex] == undefined)
			{
				// we do not, initialize it to the selectable value
				if (bSelectable)
					_selectable_array[_vIndex] = "1";
				else
					_selectable_array[_vIndex] = "0";
			}
			
			// create a user-defined property to remember if this node was visited
			this_mc.visited = _visited_array[_vIndex];
			
			// see if it has been visited
			if (_visited_array[_vIndex] != "0")
			{
				// it has been visited, set the checkmark
				setCheckmark(this_mc);
			}
			
			// create a user-defined property to indicate if this page is selectable
			this_mc.selectValue = _selectable_array[_vIndex];
			
			// see if this page is selectable
			if (_selectable_array[_vIndex] == "0")
			{
				// it's not, gray it out
				this_mc.Page_txt.setTextFormat(disFmt);
			}
			
			_nIndex++;
			_vIndex++;
			//Add to index.
			this.addChild(this_mc);
			
			//Add to array
			_pageArray[_pageArray.length] = this_mc.name;
		}
		
		public function createTopic(t:XML,nLevel:int,bSelectable:Boolean):void
		{
			var toc_mc:MovieClip = new TocTopic();
			
			//set the X and Y locations
			if (moveJustTopicText)
			{
				toc_mc.text_mc.x = toc_mc.text_mc.x + (_nX + _nCheckWidth + nLevel * _nCheckWidth);
				toc_mc.x = 0;
			} else {//Whole topic is indented.
				toc_mc.x = _nX + _nCheckWidth + nLevel * _nCheckWidth;
			}
			
			toc_mc.y = _nY;
			toc_mc.name = "Topic" + _tIndex;
			t.@topicName = toc_mc.name;
			_tIndex++;
			toc_mc.text_mc.Topic_txt.text = t.@title;
	
			if (useInterfaceColor)
			{
				//Need to bring in color from the tool.
			} else {
				toc_mc.text_mc.Topic_txt.setTextFormat(topicFmt);
			}
			//increment location of next TOC entry
			_nY += _ntHeight;
			
			//Current topic
			_currentTopic = toc_mc;
			
			//Tooltip
			
			//Add to index
			this.addChild(toc_mc);
			
			//Cycle through other tags
			_pageArray = [];//Empties page array
			for each (var it in t.elements()) {
			    //trace("I: " + item.localName());
			    if (it.localName().toLowerCase() == "page" && it.@nonNavPage.toString().toLowerCase() != "true")
			    {
			    	//trace("----" + it);
			    	
					
					if (it.@isTocEntry.toString().toLowerCase() != "false")
					{
						createPage(it,nLevel+1,bSelectable);
					} else {
						it.@pageName = "Page"+_nIndex;
						_nIndex++;
					}
					
			    } else if (it.localName().toLowerCase() == "topic" && it.@showTopicPages.toString().toLowerCase() != "false") {
			    	
			    	createTopic(it,nLevel+1,bSelectable);
			    	bSelectable = it.@nav.toString().toLowerCase() != "complete";
			    	//bSelectable = (it.@nav.toLowerCase() != "complete") ? true : false;
			    } else if (it.localName().toLowerCase() == "quiz") {
					
					if (it.@isTocEntry.toString().toLowerCase() != "false")
					{
						createPage(it,nLevel+1,bSelectable);
					} else {
						it.@pageName = "Page"+_nIndex;
						_nIndex++;
					}
					//parseQuiz(it); //No longer needed.
				}
			}
			//Add array of pages to parent topic.
			TocTopic(toc_mc).childPages = _pageArray;
			//trace("Page Array: " + _pageArray.toString());
		}
		
		public function markComplete(idx:int):void //Called from IndexView to mark the page completed
		{
			//Generate movie clip name
			var selected_mc:MovieClip = MovieClip(getChildByName("Page"+idx));
			// see if this page was previously selected
			if (selected_mc != null)
			{
				if (selected_mc.visited == "0")
				{
					// it was not, check it
					setCheckmark(selected_mc);
					
					// remember this selction in the visited array
					//trace("INDEX-----------" + selected_mc.index);
					_visited_array[selected_mc.arrayIndex] = "1";
					
					// this is a new selection so we need to update the state
					updateState();
				}
			}
			courseModel.checkCompletedTopic();
			//If using topic completion mark the next set of pages accessible.
			makeNextSelectable();
		}
		
		public function selectPage(idx:int):void //Generally called from the update method in IndexView.
		{
			//Generate movie clip name
			var selected_mc:MovieClip = MovieClip(getChildByName("Page"+idx));
		//trace("SELECTED MC: " + selected_mc);
			if (selected_mc != null)
			{
				//set selected state
				selected_mc.selected = true;
				if (_lastSelectedPage != null && _lastSelectedPage != selected_mc) {_lastSelectedPage.selected = false;}
				// put the highlight on top of the selected clip
				if (leftJustifiedHighlight){
					highlight_mc.x = 0;
				} else {
					highlight_mc.x = selected_mc.x;
				}
				highlight_mc.y = selected_mc.y;
				if (!leftJustifiedHighlight){
					highlight_mc.width = _highlightSize - (selected_mc.nLevel * _nCheckWidth);
				}
				//Show the highlight
				highlight_mc.visible = true;
				
				//Some styles require that the text change colors.
				if (useHighlightColor){
					selected_mc.Page_txt.setTextFormat(highOFmt);
					//changeIndexMouseOver(selected_mc);
					if (_lastSelectedPage != null && _lastSelectedPage != selected_mc){
						_lastSelectedPage.Page_txt.setTextFormat(pageFmt);
					}
				}
				_lastSelectedPage = selected_mc;
				
				//Set current page and topic MC in model
				var curTopic:XML = courseModel.currentTopic;	
				if (curTopic != null)
				{
					var topicName:String = curTopic.@topicName;
					var disObj:DisplayObject = this.getChildByName(topicName);
					courseModel.curTopicMC = MovieClip(disObj);
				} else {
					courseModel.curTopicMC = null;
				}
				courseModel.curPageMC = selected_mc;		//When the page is recorded, courseModel also checks to see if topic is complete and if so marks it as such.
			}
		}
		
		private function setCheckmark(pg:MovieClip):void
		{
			// mark it as selected
			pg.visited = "1";
			
			// create a movie clip for the chechmark and place it next to the page
			var check:MovieClip = new Check();
			var idx:int = pg.index;
			check.name = "Check" + idx;
			check.x = pg.x;
			check.y = pg.y;
			this.addChild(check);
		}
		
		//Used to enable pages in next topic if using topic restriction
		//Cycles through current topic to see if it is complete.
		private function makeNextSelectable():void
		{
			//trace("NAME: " + courseModel.currentTopic);
			//trace("LocalNAME: " + courseModel.currentTopic.localName());
			for (var curTopic:XML = courseModel.currentTopic;
		 		curTopic.localName() == "topic";
		 		curTopic = curTopic.parent())
			{
				//trace("inside loop");
				
				var topicName:String = curTopic.@topicName;
				var disObj:DisplayObject = this.getChildByName(topicName);
				//trace("O: " + disObj);
				//****************Instructional Code**************
				//trace("topic Name: " + disObj.name)//[curTopic.@topicName].name);
				
				var pageArray:Array = TocTopic(disObj).childPages;
				
				for (var i:int = 0;i < pageArray.length; i++)
				{
					var pgObj:DisplayObject = this.getChildByName(pageArray[i]);
					//trace("page name: " + pgObj.name);
					//trace("completed: " + TocPage(pgObj).visited);
				}
				
				//trace("next sib: " + curTopic.parent().children()[ curTopic.childIndex() + 1 ])
				//*****************Instructional Code*****************
				//trying to find equivalent to next sibling.
				//trace(":::" + curTopic);
				if (TocTopic(disObj).completed){
					//trace("topic is now completed");
					//trace("next sib: " + curTopic.parent().children()[ curTopic.childIndex() + 1 ])
					if (courseModel.nextSibOfTopic != null && courseModel.nextSibOfTopic.localName() == "topic")
					{
						makeTopicActive(courseModel.nextSibOfTopic);
					} else if (courseModel.nextSibOfTopic != null && courseModel.nextSibOfTopic.localName() == "page") {
						makePageActive(courseModel.nextSibOfTopic);
					}
				} /*else if (topicPageComplete(curTopic)){ //See if it is complete except for subtopics
					if (playerMain_mc.currentPage_xmlnode.nextSibling != null && isNavNextTopic(playerMain_mc.currentPage_xmlnode)) { 
							//activate next topic
							if (nextNavTopic != undefined) {
								makeSelectable(nextNavTopic,false);
							}
					}
				}*/
			}
			//For pages that are not inside a topic.
			if (courseModel.currentTopic.localName() == "topics" && courseModel.currentPage.localName() == "page")
			{
				//trace("nextSib: " + courseModel.nextSibOfTopic);
				if (courseModel.nextSibOfTopic != null && courseModel.nextSibOfTopic.localName() == "topic")
				{
					makeTopicActive(courseModel.nextSibOfTopic);
				} else if (courseModel.nextSibOfTopic != null && courseModel.nextSibOfTopic.localName() == "page") {
					makePageActive(courseModel.nextSibOfTopic);
				}
			}
		}
		
		private function makeTopicActive(currentNode:XML):void
		{
			//trace("XML: " + currentNode);
			var topicName:String = currentNode.@topicName;
			var disObj:TocTopic = TocTopic(this.getChildByName(topicName));
			var pgArray:Array = disObj.childPages;
			
			for (var k:int = 0; k < pgArray.length; k++)
			{
				var pgObj:TocPage = TocPage(this.getChildByName(pgArray[k]));
				makeMCActive(pgObj);
			}
		}
		
		private function makePageActive(currentNode:XML):void
		{
			var pageName:String = currentNode.@pageName;
			//trace("page name: " + pageName);
			var disObj:TocPage = TocPage(this.getChildByName(pageName));
			makeMCActive(disObj);
		}
		
		private function makeMCActive(disObj:TocPage):void
		{
			var index:int = disObj.arrayIndex;
			
			disObj.Page_txt.setTextFormat(pageFmt);
			
			_selectable_array[index] = "1";
			
			disObj.selectValue = "1";
		}
		
		// update the state information for the table of contents
		//
		private function updateState()
		{
			// save visited array : max selectable : selectable array
			_feedbackPanel.updatePanel("Updating state in toc: " + _selectable_array.join(","));
//trace("TOC: " + _visited_array.join(",") + ":" + _maxSelectNode + ":" + _selectable_array.join(","));
			_lmsLink.apiSetState("toc",_visited_array.join(",") + ":" + _maxSelectNode + ":" + _selectable_array.join(","));
		}

		
		// Used to synch state of index with teh state information.
		// Cycles through all the pages and sets the proper state.
		public function refreshIndex():void
		{
			//Read in state information
			var suspend_str:String = _lmsLink.apiGetState("toc");
			// see if we have a suspend string
			if (suspend_str != null && suspend_str != "")
			{
				// there is, break it apart (visited array, current selection, maximum selection)
				var suspend_array:Array = suspend_str.split(":");
				_visited_array = suspend_array[0].split(",");
				_maxSelectNode = suspend_array[1] - 0;
				_selectable_array = suspend_array[2].split(",");
			}
			
			for (var n:Number=0; n<_nIndex; n++)
			{
				var page_mc:MovieClip = MovieClip(getChildByName("Page"+n));
				if (page_mc != null)
				{
					// see if we have data in the visited array
					if (_visited_array[n] != undefined)
					{
						page_mc.visited = _visited_array[n];
					} else {
						_visited_array[n] = "0";
						page_mc.visited = _visited_array[n];
					}
					
					// see if we have data in the selectable array
					if (_selectable_array[n] != undefined)
					{
						page_mc.selectValue = _selectable_array[n];
					} else {
						_selectable_array[n] = "1";
						page_mc.selectValue = _selectable_array[n];
					}
					
					// see if it has been visited
					if (_visited_array[n] != "0")
					{
						// it has been visited, set the checkmark
						setCheckmark(page_mc);
					}
					
					// see if this page is selectable
					if (_selectable_array[n] == "0")
					{
						// it's not, gray it out
						page_mc.Page_txt.setTextFormat(disFmt);
					} else {
						page_mc.Page_txt.setTextFormat(pageFmt);
					}
				}
			}
			updateState();
		}
	}
}
package src
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import src.CourseModel;
	import src.com.Buttons;
	
	public class ButtonView extends View
	{
		private var _controller:ButtonController;
		private var _audioBtn:Buttons;
		private var _nextBtn:Buttons;
		private var _prevBtn:Buttons;
		private var _indexBtn:Buttons;
		private var _exitBtn:DisplayObject;
		private var _glossaryBtn:DisplayObject;
		
		public function ButtonView()
		{
			
		}
		
		override public function update(event:Event = null):void
		{
			//Update the next and back buttons and any other button that changes when the view changes.
			updateNavButtons();
		}
		
		//Override for Button View because it needs to subscribe to another event
		override public function set model(m:Model):void
		{
			super.model = m;
			model.addEventListener(CourseModel.AUDIO_CHANGED, updateAudioButton);
			model.addEventListener(CourseModel.INDEX_CHANGED, updateIndexButton);
		}
		
		private function updateNavButtons():void
		{
			
			var curIndx:int = model.currentIndex;
			//Enable as appropriate
			if (curIndx >= model.totalItems -1)
			{
				_nextBtn.enabled = false;
				_prevBtn.enabled = true;
			} else if (curIndx <= 0) {
				_prevBtn.enabled = false;
				_nextBtn.enabled = true;
			} else {
				_nextBtn.enabled = true;
				_prevBtn.enabled = true;
			}
			//Set the state of the buttons.
			if (_nextBtn.hitTestPoint(_nextBtn.stage.mouseX, _nextBtn.stage.mouseY, true))
		    {
		    	_nextBtn.onMouseUp();
		    } else {
		    	_nextBtn.onRollOut();
		    }
		    if (_prevBtn.hitTestPoint(_prevBtn.stage.mouseX, _prevBtn.stage.mouseY, true))
		    {
		    	_prevBtn.onMouseUp();
		    } else {
		    	_prevBtn.onRollOut();
		    }
		}
		
		public function updateAudioButton(e:Event = null):void
		{
			_audioBtn.stateCode = model.audioStatus;
			//Find out if mouse is over button.
			if (_audioBtn.hitTestPoint(_audioBtn.stage.mouseX, _audioBtn.stage.mouseY, true))
		     {
		        _audioBtn.onMouseUp();
		     } else {
		     	_audioBtn.onRollOut();
		     }
		}
		
		public function updateIndexButton(e:Event = null):void
		{
			_indexBtn.stateCode = model.indexState;
			//Find out if mouse is over button.
			if (_indexBtn.hitTestPoint(_indexBtn.stage.mouseX, _indexBtn.stage.mouseY, true))
		     {
		        _indexBtn.onMouseUp();
		     } else {
		     	_indexBtn.onRollOut();
		     }
		}
		
		public function setVisibleButtons():void
		{
			_audioBtn.visible = CourseModel(model).courseAttributes.audioButton;
			_indexBtn.visible = CourseModel(model).courseAttributes.narration;
			_glossaryBtn.visible = CourseModel(model).courseAttributes.glossary;
			_exitBtn.visible = CourseModel(model).courseAttributes.exitButton;
		}
		
		//The events in the Listeners are in the controller parent class Controller.
		public function addNextButton(btn:Buttons):void
		{
			btn.addEventListener(MouseEvent.CLICK,_controller.nextPage);
			_nextBtn = btn;
		}
		
		public function addPrevButton(btn:Buttons):void
		{
			btn.addEventListener(MouseEvent.CLICK,_controller.prevPage);
			_prevBtn = btn;
		}
		
		public function addAudioButton(btn:Buttons):void
		{
			btn.addEventListener(MouseEvent.CLICK,_controller.adjustAudio);
			_audioBtn = btn;
		}
		
		public function addGlossaryButton(btn:DisplayObject):void
		{
			btn.addEventListener(MouseEvent.CLICK,_controller.showGlossary);
			_glossaryBtn = btn;
		}
		
		public function addIndexButton(btn:Buttons):void
		{
			btn.addEventListener(MouseEvent.CLICK,_controller.onIndexClick);
			_indexBtn = btn;
		}
		
		public function addExitButton(btn:DisplayObject):void
		{
			btn.addEventListener(MouseEvent.CLICK,_controller.exitCourse);
			_exitBtn = btn;
		}
		
		public function addIndexTabButton(btn:DisplayObject):void
		{
			btn.addEventListener(MouseEvent.CLICK,_controller.slideIndex);
		}
		
		public function set controller(c:ButtonController):void
		{
			_controller = c;
		}
		
		public function get controller():ButtonController
		{
			return _controller;
		}
		
	}
}
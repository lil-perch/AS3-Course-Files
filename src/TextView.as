package src
{
	import flash.text.TextField;
	import flash.events.Event;
	import src.classes.Settings;
	
	public class TextView extends View
	{
		private var _title:TextField;
		private var _page:TextField;
		private var _counter:TextField;
		private var _settings:Settings;
		private var _showPgTitle:Boolean;
		
		public function TextView(sett:Settings)
		{
			_settings = sett;
			_showPgTitle = _settings.showPageTitle;
		}
		
		override public function update(event:Event = null):void
		{
			//Update the text fields.
			if (_showPgTitle) _page.text = model.currentTitle;
			else _page.text = "";
			_counter.text = (model.currentIndex + 1) + " of " + model.totalItems;
		}
		
		public function addTitleField(txt:TextField):void
		{
			_title = txt;
			txt.text = model.mainTitle;
		}
		
		public function addPageField(txt:TextField):void
		{
			_page = txt;
		}
		
		public function addPageCounter(txt:TextField):void
		{
			_counter = txt;
		}
	}
}
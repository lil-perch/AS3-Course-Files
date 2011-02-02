package src.com
{
	/**
	 * Updates the TextArea used in the Glossary.
    * @makes it possible to do textArea.textField.styleSheet
    * @author Tim de Jong - Dooping VOF 2008 - tim -AT- dooping.nl
    * @version 001
    */
	
	import fl.controls.TextArea;
	
	public class RiTextArea extends TextArea
	{
		public function RiTextArea()
		{
			super();
		}
		
		override protected function drawTextFormat():void {
            if(!this.textField.styleSheet) super.drawTextFormat();
            else {
                setEmbedFont();
                if(_html) textField.htmlText = _savedHTML;
            }
        }
	}
}
/*
	This class is linked to the buttons using linkage property of the symbols in Player.fla
*/
package src.com
{

	public class ShowHideIndexButton extends Buttons
	{
		
		public function ShowHideIndexButton(state:Boolean = false)
		{
			super(state);
			stop();
		}
	}
}

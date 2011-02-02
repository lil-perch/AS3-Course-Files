/*
	This class is linked to the buttons using linkage property of the symbols in Player.fla
*/
package src.com
{

	public class CloseButton extends Buttons
	{
		
		public function CloseButton(state:Boolean = false)
		{
			super(state);
			stop();
		}
	}
}

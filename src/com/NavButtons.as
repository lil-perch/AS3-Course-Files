/*
	This class is linked to the buttons using linkage property of the symbols in Player.fla
*/
package src.com
{

	public class NavButtons extends Buttons
	{
		
		public function NavButtons(state:Boolean = false)
		{
			super(state);
			stop();
		}
	}
}

/*
	This class is linked to the buttons using linkage property of the symbols in Player.fla
*/
package src.com
{

	public class RewindButton extends Buttons
	{
		
		public function RewindButton(state:Boolean = false)
		{
			super(state);
			stop();
		}
	}
}

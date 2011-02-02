/*
	This class is linked to the buttons using linkage property of the symbols in Player.fla
*/
package src.com
{

	public class PlayButton extends Buttons
	{
		
		public function PlayButton(state:Boolean = false)
		{
			super(state);
			stop();
		}
	}
}

/*
	This class is linked to the buttons using linkage property of the symbols in Player.fla
*/
package src.com
{

	public class AudioButton extends Buttons
	{
		
		public function AudioButton(state:Boolean = false)
		{
			super(state);
			stop();
		}
	}
}

package src.pages.utils
{

	public class Position
	{

		public function Position()
		{
			// constructor code
		}


		public static function getCenterV(a, b, _align:String):Number
		{

			var align = _align || "center";
			switch (align)
			{
				case "top" :
					return b.y + ((b.height/2 ));
					break;

				case "center" :

					return b.y + ((b.height - a.height)/2);
					break;

				case "bottom" :
					return b.y + ((b.height/2 ) - a.height);
					break;
			}
			
			return 0;
		}

		public static function getCenterH(a, b, _align:String):Number
		{

			var align = _align || "center";
			switch (align)
			{
				case "left" :
					return b.x + ((b.width /2 ));
					break;

				case "center" :					
					return b.x + ((b.width - a.width)/2);
					break;

				case "right" :
					return b.x + ((b.width /2 ) - a.width );
					break;
			}

			return 0;
		}

	}

}
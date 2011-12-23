package src.pages.utils.drag_drop
{



	import src.pages.utils.drag_drop.*;	


	public class DropList
	{
		private var _list:Array = new Array();



		// Begin Singleton
		private static var _instance:DropList;
		private static var creatingSingleton:Boolean = false;

		public function DropList()
		{
			if (! creatingSingleton)
			{
				throw new Error("Singleton and can only be accessed through Singleton.getInstance()");
			}
		}


		public static function getInstance():DropList
		{
			if (! _instance)
			{
				creatingSingleton = true;
				_instance = new DropList();
				creatingSingleton = false;
			}
			return _instance;
		}



		public function clear()
		{
			for (var i = 0; i < _list.length; i++)
			{
				_list[i].clear();
			}
			_list = new Array();
		}

		public function getItem()
		{
			return _list;
		}

		public function addItem(__item:DropItem)
		{
			_list.push(__item);
		}

		public function delItem(__item:DropItem)
		{
			for (var i = 0; i < _list.length; i++)
			{
				if (_list[i] == __item)
				{
					_list.splice(i,1);
				}
			}
		}

		public function checkAll()
		{
			for (var i = 0; i < _list.length; i++)
			{
				if (_list[i].dragTarget.getID() == undefined)
				{
					return false;
				}
			}
			return true;
		}

		public function evaluate()
		{
			var all:Boolean = true;
			for (var i = 0; i < _list.length; i++)
			{
				if (_list[i].getID() != _list[i].dragTarget.getID())
				{
					all = false;
					break;
				}
			}
			return all;
		}

	}

}
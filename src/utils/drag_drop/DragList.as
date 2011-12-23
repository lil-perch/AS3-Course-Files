package src.pages.utils.drag_drop
{

	import DragItem;
	import DropItem;


	public class DragList
	{
		private var _list:Array = new Array();

		// Begin Singleton
		private static var _instance:DragList;
		private static var creatingSingleton:Boolean = false;

		public function DragList()
		{
			if (! creatingSingleton)
			{
				throw new Error("Singleton and can only be accessed through Singleton.getInstance()");
			}
		}

		public  static function getInstance():DragList
		{
			if (!_instance)
			{
				creatingSingleton = true;
				_instance = new DragList();
				creatingSingleton = false;
			}
			return _instance;
		}
		//End Singleton


		public function getItem()
		{
			return _list;
		}

		public function addItem(__item:DragItem)
		{
			_list.push(__item);
		}

		public function clear()
		{
			for (var i = 0; i < _list.length; i++)
			{
				_list[i].clear();
			}
			_list = new Array();
		}



		public function delItem(__item:DragItem)
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

	}


}
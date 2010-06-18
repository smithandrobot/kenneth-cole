package com.smithandrobot.kennethcole.model 
{
	
	import com.smithandrobot.utils;
	
	public class AppDataVO 
	{
		
		private var _data : XML;
		private var _objectDrawers : Array = new Array();
		
		public function AppDataVO()
		{ 
			_data = null;
			_objectDrawers.push("kenneth_cole_object_palette.swf");
		}
		
		
		public function set data(d:XML) : void
		{
			_data = d;
		}
	}

}
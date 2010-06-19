package com.smithandrobot.kennethcole.model 
{
	
	public class AppDataVO 
	{
		
		private var _data : XML;
		private var _uiPieces : Array = new Array();
		
		public function AppDataVO()
		{ 
			_data = null;
			_uiPieces.push({name:"objectPalette", file:"kenneth_cole_object_palette.swf"});
			_uiPieces.push({name:"framePalette", file:"kenneth_cole_frames_panel.swf"});
		}
		
		
		public function set data(d:XML) : void
		{
			_data = d;
		}
		
		public function getFile(n:String) : String
		{
			for(var i in _uiPieces)
			{
				if(_uiPieces[i].name == n) return _uiPieces[i].file;
			}
			
			return null;
		}
	}

}
package com.smithandrobot.utils 
{

/**
 *	Class description.
 *
 *	@langversion ActionScript 3.0
 *	@playerversion Flash 9.0
 *	@author David Ford
 *	@since  17.03.2010
 */
	import flash.system.Capabilities;
	import flash.external.ExternalInterface;
	
	public class PathFinder 
	{

		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------


		public function PathFinder()
		{

		}

		public static function isLocal() : Boolean
		{
			var pt = Capabilities.playerType;
			var local = (pt == "StandAlone" || pt == "External" ) ? true : false;
			return true;
		}
		
		public static function inBrowser() : Boolean
		{
			var address = ExternalInterface.call("window.location.href.toString");
			if(address == null) return false;
			return true;
		}
		
	}

}


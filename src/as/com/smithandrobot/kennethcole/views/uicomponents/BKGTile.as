package com.smithandrobot.kennethcole.views.uicomponents 
{

	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *
	 *	@author David Ford
	 *	@since  22.06.2010
	 */
	
	import flash.display.*;
	
	public class BKGTile extends Sprite 
	{
		
		private var _tile 	: BitmapData;
		private var _bmp	: Bitmap;
		
		public function BKGTile(tileWidth, tileHeight)
		{
			super();
			_tile = new ConcreteTile(0,0);
			graphics.beginBitmapFill(_tile);
			graphics.drawRect(0,0,tileWidth,tileWidth);
			graphics.endFill();
		}
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
	
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		
	}

}


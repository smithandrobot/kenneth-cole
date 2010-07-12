package com.smithandrobot.kennethcole.views.uicomponents 
{

	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *
	 *	@author David Ford
	 *	@since  23.06.2010
	 */
	
	import flash.display.MovieClip;
	
	public class TrashIcon extends MovieClip 
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		
		
		/**
		 *	@constructor
		 */
		public function TrashIcon()
		{
			super();
			stop();
		}
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		public function remove() : void
		{
			
		}
		
		private function onAnimationDone()
		{
			stop();
			parent.removeChild(this);
		}
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


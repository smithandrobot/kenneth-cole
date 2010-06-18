package com.smithandrobot.kennethcole.views.uicomponents 
{

/**
 *	Class description.
 *
 *	@langversion ActionScript 3.0
 *	@playerversion Flash 9.0
 *	@author David Ford
 *	@since  17.06.2010
 */
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	import com.greensock.TweenNano;
	
	public class ObjectPaletteNavItem extends EventDispatcher 
	{

		private var _scope 		: MovieClip;
		private var _id			: int;
		private var _highlight	: MovieClip;
		private var _underline	: MovieClip;
		private var _selected	: Boolean;
		
		public function ObjectPaletteNavItem(scope)
		{
			_scope 		= scope;
			_highlight	= _scope.getChildByName("highlight") as MovieClip;
			_underline	= _scope.getChildByName("underline") as MovieClip;
			_highlight.alpha = 0;
			_underline.alpha = 0;
			toggleSelected(false);
			initBehaviors();
		}

		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		public function set id (i:int) : void
		{
			_id = i;
		}
		
		public function get id () : int
		{
			return _id;
		}
		
		public function set selected(b:Boolean) : void
		{
			_selected = b;
			toggleSelected(_selected);
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
		private function initBehaviors() : void
		{
			_scope.buttonMode 		= true;
			_scope.mouseChildren	= false;
			
			_scope.addEventListener(MouseEvent.MOUSE_OVER, handleMouse);
			_scope.addEventListener(MouseEvent.MOUSE_OUT, handleMouse);
			_scope.addEventListener(MouseEvent.CLICK, onClick);
		}


		private function handleMouse(e:MouseEvent) : void
		{
			if(e.type == MouseEvent.MOUSE_OVER)
			{
				toggleSelected(true);
			}
			
			if(e.type == MouseEvent.MOUSE_OUT)
			{
				if(_selected) return;
				toggleSelected(false);
			}
		}
		
		
		
		private function onClick(e:MouseEvent) : void
		{
			if(_selected) return;
			selected = true;
			dispatchEvent(new Event("paletteNavClick", true));
		}
		
		private function toggleSelected(b:Boolean) : void
		{
			var a = (b) ? 1 : 0;
			TweenNano.to(_highlight, .5, {alpha:a, overwrite:true});
			TweenNano.to(_underline, .5, {alpha:a, overwrite:true});
		}
	}

}


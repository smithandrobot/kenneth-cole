package com.smithandrobot.kennethcole.views.uicomponents 
{
	import flash.events.*;
	import flash.display.MovieClip;
	
	import com.greensock.TweenNano;
	
	public class PrintBtn extends EventDispatcher 
	{
		
		private var _scope 		: MovieClip;
		private var _enabled	: Boolean = false;
		
		public function PrintBtn(scope = null)
		{
			super();
			_scope = scope;
		}
		
		public function set enabled(b:Boolean) : void
		{
			if(_enabled == b) return;
			
			_enabled = b;
			
			if(_enabled) setBehavior(true);
			if(!_enabled) setBehavior(false);
		}
		
		
		private function setBehavior(b) : void
		{
			if(b)
			{
				_scope.buttonMode = true;
				_scope.addEventListener(MouseEvent.CLICK, onPrint);
				TweenNano.to(_scope, .5, {alpha:1, overwrite:true});
			}else{
				_scope.buttonMode = false;
				_scope.removeEventListener(MouseEvent.CLICK, onPrint);
				TweenNano.to(_scope, .5, {alpha:.5, overwrite:true});	
			}
		}
		
		private function onPrint(e:MouseEvent)
		{
			dispatchEvent(new Event("onPrint"));
		}
		
	}
}


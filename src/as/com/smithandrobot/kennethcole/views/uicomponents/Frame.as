package com.smithandrobot.kennethcole.views.uicomponents
{
	
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;
	
	import com.greensock.*;
	import com.greensock.plugins.*;
	
	
	public class Frame extends EventDispatcher 
	{
		
		private var _scope;
		private var _id 		: String;
		private var _frame 		: MovieClip;
		private var _frameTitle	: MovieClip;
		private var _selected	: Boolean = false;
		private var _bmpData	: String;
		
		public function Frame(scope = null)
		{
			super();
			_scope = scope;
			
			TweenPlugin.activate([TintPlugin]);
			if(_scope) init();
			if(_scope) initBehaviors();
		}
		
		
		public function set id(i:String) : void
		{
			_id = i;
		}
		
		
		public function get id() : String
		{
			return _id;
		}
		
		
		public function get selected() : Boolean
		{
			return _selected;
		}
		
		
		public function set selected(b:Boolean) : void
		{
			if(_selected == b) return;
			
			_selected = b;
			if(_frame) toggleSelectFrame(_selected);
			if(!_frame) toggleBlankBKG(_selected);
		}
		
		
		public function set bmpDataArray(a:Array) : void
		{
			for(var i in a)
			{

				if(a[i].id == _id) 
				{
					trace("found bmp data match")
					_bmpData = a[i].data;
				}
			}
			
			
		}
		
		
		public function get bmpData() : BitmapData
		{
			var DataInstance;
			
			if ( ApplicationDomain.currentDomain.hasDefinition(_bmpData) ) 
			{
				var Data:Class = getDefinitionByName( _bmpData ) as Class;
				DataInstance = new Data(854,1094) as BitmapData;
			}else {
				DataInstance = null;
			}

			return DataInstance;
		}
		
		
		private function initBehaviors()
		{
			_scope.buttonMode = true;
			_scope.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		
		private function init() : void
		{	
			_frame 		= _scope.getChildByName("frame");
			_frameTitle = _scope.getChildByName("frameTitle");
			if(_frame) _frame.alpha = 0;
		}
		
		
		private function onClick(e:MouseEvent) : void
		{
			dispatchEvent(new Event("onFrameSelected"))
		}
		
		
		private function toggleSelectFrame(state) : void
		{
			var a = (state) ? 1 : 0;
			var color = (state) ? 0x0662B9:0xFFFFFF;
			TweenLite.to(_frame, .5, {alpha:a, overwrite:true});
			TweenLite.to(_frameTitle, .5, {tint:color, overwrite:true});
		}
		
		private function toggleBlankBKG(state) : void
		{
			var a = (state) ? .5 : 1;
			TweenLite.to(_scope, .5, {alpha:a, overwrite:true});
		}
		
	}
}


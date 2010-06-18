package com.smithandrobot.kennethcole.views.uicomponents 
{
	
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.DisplayObject
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
		
	import com.senocular.display.DuplicateDisplayObject;
	
	public class PaletteObject extends EventDispatcher
	{
		
		private var _scope : MovieClip;
		private var _bmp	: Bitmap;
		private var _canvas	: MovieClip = null;
		private var _canvasObject;
		
		public function PaletteObject(scope)
		{
			_scope = scope;
			initBehaviors();
		}
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		public function get canvasObject() : MovieClip
		{
			return _canvasObject;
		}
		
		public function get scope() : MovieClip
		{
			return _scope;
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
		private function initBehaviors()
		{
			_scope.buttonMode = true;
			_scope.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_scope.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_scope.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseDown(e:MouseEvent) : void
		{
			_canvasObject = DuplicateDisplayObject(_scope);
			_canvasObject.addChild(getBMP());
			dispatchEvent(new Event("onPaletteObjectCreated", true));
		}
		
		
		private function onMouseUp(e:MouseEvent) : void
		{

		}
		
		
		private function getBMP() 
		{
			// Shape
			var ref = _scope.getChildAt(0);
			var bmd:BitmapData;
			var m = new Matrix();
			var bmp : Bitmap;
			
			if(ref.x>=0) m.translate((ref.width/2), ref.height/2);			
			bmd = new BitmapData(ref.width, ref.height, true, 0x00000000);
			bmd.draw(ref,m);
			bmp = new Bitmap(bmd);
			bmp.x = -(ref.width/2)
			bmp.y = -(ref.height/2);
			return bmp;
		}
		
		
		private function bringToTop()
		{
			var p = _scope.parent;
			var total = p.numChildren - 1;
			p.setChildIndex(_scope, total);
		}
	}

}


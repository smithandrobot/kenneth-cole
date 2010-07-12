package com.smithandrobot.kennethcole.views.uicomponents 
{
	
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.display.*;
	
	import com.greensock.TweenNano;
	
	import com.senocular.display.DuplicateDisplayObject;
	
	import com.smithandrobot.kennethcole.views.uicomponents.*;
	import com.smithandrobot.utils.CoordinateTools;
	
	public class CanvasObject extends EventDispatcher 
	{
		
		private var _scope;
		private var _canvas 	: * = null;
		private var _orgPt 		: Point;
		private var _overTarget : Boolean = false;
		private var _canvasInstructions : MovieClip;
		
		public function CanvasObject(scope)
		{
			super();
			_scope 			= scope;
			_scope.alpha 	= .5;
			_orgPt 			= new Point(_scope.x, _scope.y);
			
			initBehaviors();
			_scope.startDrag();
		}
		
		
		override public function toString() : String
		{
			return "Canvas Object";
		}
		
		
		public function set canvas(c:*) : void
		{
			 if(c) _canvas = c;
		}
		
		private function initBehaviors()
		{
			_scope.buttonMode = true;
			_scope.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_scope.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_scope.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove)
		}
		
		
		private function removeBehaviors() : void
		{
			if(!_scope) return;
			_scope.buttonMode = false;
			_scope.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_scope.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_scope.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove)
		}
		
		
		private function onMouseUp(e:MouseEvent) : void
		{
			var sx = e.stageX;
			var sy = e.stageY;
			
			_scope.stopDrag();
			
			if(checkBounds(sx, sy))
			{
				addObject();
			}else{
				animateBack();
			}
		}
		
		
		private function onMouseMove(e:MouseEvent)
		{
			var sx = e.stageX;
			var sy = e.stageY;
			
			if(checkBounds(sx, sy) == _overTarget) return;
			if(checkBounds(sx, sy))
			{
				_overTarget = true;
				toggleDisplay("canvas");
			}else{
				_overTarget = false;
				toggleDisplay("thumb");
			}
		}
		
		
		private function checkBounds(sx=0,sy=0) : Boolean
		{
			if(!_canvas) return false;
			var bkg = _canvas.getChildByName("bkg")
			if(bkg.hitTestPoint(sx,sy)) return true;
			return false;
		}
		
		
		private function addObject()
		{
			var canvasObject = DuplicateDisplayObject(_scope);
			var p = CoordinateTools.localToLocal(_scope, _canvas.objLayer);
			canvasObject.x = p.x;
			canvasObject.y = p.y;
			canvasObject.scaleX = canvasObject.scaleY = 1;
			canvasObject.alpha = 1;
			canvasObject.addChild(getBMP());
			_canvas.objLayer.addChild(canvasObject)
			remove();
		};
		
		
		private function animateBack()
		{
			TweenNano.to(_scope, .1, {x:_orgPt.x, y:_orgPt.y, onComplete:remove});
		}
		
		
		private function remove()
		{
			var p
			removeBehaviors();
			if(_scope) p = _scope.parent;
			if(p) p.removeChild(_scope);
			_scope = null;
			delete this;
		}
		
		
		private function toggleDisplay(state) : void
		{
			var a = (state == "canvas") ? 1 : .5;
			var s = (state == "canvas") ? .5 : .25;
			
			TweenNano.to(_scope, .5, {alpha:a, scaleX:s, scaleY:s, overwrite:true});
		}
		
		private function getBMP() 
		{
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
		
	}
}


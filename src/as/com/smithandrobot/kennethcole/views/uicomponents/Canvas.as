package com.smithandrobot.kennethcole.views.uicomponents 
{
	import flash.display.*;
	import flash.events.*;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOrientation;
	import flash.printing.PrintJobOptions;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.system.ApplicationDomain;
	import flash.utils.*;
	
	import com.greensock.TweenNano;
	
	import com.smithandrobot.kennethcole.transform.KennethColeTransformTool;
	import com.smithandrobot.kennethcole.views.uicomponents.TrashIcon;
	import com.smithandrobot.utils.*;
	
	import com.senocular.display.TransformTool;
	
	public class Canvas extends Sprite 
	{
		
		private var _printLayer : Sprite;
		private var _bkgLayer : Sprite;
		private var _bkgLayerBMP : Bitmap;
		private var _objLayer : Sprite;
		private var _transformTool : KennethColeTransformTool;
		private var _objectCount : int = 0;
		private var _instructions : Sprite
		private var _objectAdded : Boolean = false;
		private var _trashCan	: TrashIcon;
		private var _mouseDown	: Boolean = false;
		private var _currSelection;
		
		public function Canvas()
		{
			super();
			
			initTransformTool();
			setUpPrintLayer();
			addEventListener(MouseEvent.MOUSE_DOWN, select);
			stage.addEventListener(MouseEvent.MOUSE_UP, removeSelection);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpListener);
		}
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		public function get printLayer() : Sprite
		{
			return _printLayer;
		}
		
		
		public function get objLayer() : Sprite
		{
			return _objLayer;
		}
		
		public function get bkgLayerBMP() : Bitmap
		{
			return _bkgLayerBMP;
		}
		
		
		public function get objectCount() : int
		{
			return _objectCount;
		}
		
		
		public function hideTransformTool()
		{
			_transformTool.target = null;
		}
		
		// Public
		
		public function print():void {
            var pj:PrintJob = new PrintJob();
			var po = new PrintJobOptions();
			po.printAsBitmap = true;
			var sheet = parent.addChild(new Sprite());
			sheet.visible = false;
			
            if(pj.start()) {                
				var bmp = drawBMP(pj);
				sheet.addChild(bmp);
				var w = bmp.width;
				var h = bmp.height;
				try 
				{
					pj.addPage(sheet, new Rectangle(0,0, w, h), po, 0);
                 }
                  catch(e:Error) {
                      // do nothing
                  }
  				pj.send();
              }
			parent.removeChild(sheet);
        }


		//--------------------------------------
		//  Event Handlers
		//--------------------------------------
		
		
		private function drawBMP(pj)
		{	
			var scaleW = _printLayer.width/pj.pageWidth;
			var scaleH = _printLayer.height/pj.pageHeight;
			var scale = (scaleH<scaleW) ? scaleH-.015 : scaleW-.015;
			var m = new Matrix();
			m.scale(scale,scale);
			
			var msk = _printLayer.mask;
			_printLayer.mask = null;
			var bmd = new BitmapData(_printLayer.width*2, _printLayer.height*2, true, 0xAA000000);
			bmd.draw(_printLayer,m);
			var bmp = new Bitmap(bmd);
			bmp.smoothing = true;
			_printLayer.mask = msk;
			return bmp;
		}
		
		
		private function onObjectAdded(e:Event)
		{
			++_objectCount;
			_objectAdded = true;
			dispatchEvent(new Event("onObjectAddedToCanvas"));
			if(_instructions.alpha>0) 
			{
				TweenNano.to(_instructions, .5, {alpha:0});
			}
		}
		
		
		
		
		private function setUpPrintLayer()
		{
			_printLayer = addChild(new Sprite()) as Sprite;
			_printLayer.x = _printLayer.y = 8;
			_printLayer.name = "printLayer";
			
			_bkgLayer = _printLayer.addChild(new Sprite()) as Sprite;
			_bkgLayer.name = "_bkgLayer";
			_bkgLayerBMP = new Bitmap();
			_bkgLayer.addChild(_bkgLayerBMP);
			_bkgLayer.mouseEnabled = false;
			_bkgLayer.mouseChildren = false;
			
			setUpInstructionGraphics();
			
			_objLayer = _printLayer.addChild(new Sprite()) as Sprite;
			_objLayer.name = "objectLayer";
			
			_printLayer.scaleX = _printLayer.scaleY = .5;
			
			var m = makeMask();
			m.x = m.y = 8;
			addChild(m);
			_printLayer.mask = m;
			_objLayer.addEventListener(Event.ADDED, onObjectAdded);
		}
		
		
		private function makeMask()
		{
			var m = new Sprite();
			m.x = m.y = 8;
			m.graphics.beginFill(0xFF00FF, .25);
			m.graphics.drawRect(0,0, 427, 546);
			return m;
		}
		
		
		private function setUpInstructionGraphics() : void
		{
			var instructionScale = 2;
			if ( ApplicationDomain.currentDomain.hasDefinition("InstructionGraphic") ) 
			{
				var instructions:Class = getDefinitionByName("InstructionGraphic") as Class;
			}else {
				instructions = null;
			}
			_instructions = _printLayer.addChild(new Sprite()) as Sprite;
			_instructions.mouseEnabled = false;
			_instructions.mouseChildren = false;
			if(instructions) _instructions.addChild(new instructions()) as MovieClip;
			_instructions.scaleX = _instructions.scaleY = instructionScale;
			_instructions.x = 65*instructionScale;
			_instructions.y = 99*instructionScale;
		}
		
		
		private function initTransformTool() : void
		{
			_transformTool = new KennethColeTransformTool();
			_transformTool.moveNewTargets = true;
			_transformTool.moveEnabled = true;
			_transformTool.constrainScale = true;
			_transformTool.skewEnabled = false;
			_transformTool.customCursorsEnabled = false;
			_transformTool.setSkin(TransformTool.SCALE_TOP_LEFT, new Ellipse());
			_transformTool.setSkin(TransformTool.SCALE_TOP_RIGHT, new Ellipse());
			_transformTool.setSkin(TransformTool.SCALE_BOTTOM_LEFT, new Ellipse());
			_transformTool.setSkin(TransformTool.SCALE_BOTTOM_RIGHT, new Ellipse());
			_transformTool.setSkin(TransformTool.ROTATION_TOP_LEFT, new RotationTopLeft());
			_transformTool.setSkin(TransformTool.ROTATION_TOP_RIGHT, new RotationTopRight());
			_transformTool.setSkin(TransformTool.ROTATION_BOTTOM_RIGHT, new RotationBottomRight());
			_transformTool.setSkin(TransformTool.ROTATION_BOTTOM_LEFT, new RotationBottomLeft());
			_transformTool.setSkin(TransformTool.SCALE_TOP, new EmptyControl());
			_transformTool.setSkin(TransformTool.SCALE_RIGHT, new EmptyControl());
			_transformTool.setSkin(TransformTool.SCALE_BOTTOM, new EmptyControl());
			_transformTool.setSkin(TransformTool.SCALE_LEFT, new EmptyControl());
			addChild(_transformTool);
			var m = makeMask();
			addChild(m);
			_transformTool.mask = m;
		}
		
		
		private function select(event){
			_mouseDown = true;
			if (event.target == stage ||
			event.target == _printLayer || 
			event.target == getChildByName("bkg") || 
			event.target == _bkgLayer || 
			event.target == _instructions) {
				_transformTool.target = null;
			}else if (event.target is Sprite) {
				_transformTool.target = event.target as Sprite;
				toolInit();
			}
		}

		
		private function removeSelection(e:MouseEvent) : void
		{
			_mouseDown = false;
			if(_transformTool.target)
			{
				var bkg = getChildByName("bkg");
				if(!bkg.hitTestPoint(e.stageX, e.stageY))
				{
					_transformTool.target.parent.removeChild(_transformTool.target);
					_transformTool.target = null;
					_objectCount = _objLayer.numChildren;
					if(_trashCan)
					{
						_trashCan.gotoAndPlay(2);
						_trashCan = null;
					}
					dispatchEvent(new Event("onObjectRemovedFromCanvas"));
				}
			}else{
				
			}
		}
		
		
		public function checkSelected(obj) : void
		{
			var bkg = getChildByName("bkg");
			var sx = obj.x;
			var sy = obj.y;
			
			if(!bkg.hitTestPoint(sx, sy) && _transformTool.target  && _mouseDown)
			{
				if(!_trashCan) _trashCan = addChild(new TrashIcon()) as TrashIcon;
				var p = CoordinateTools.localToLocal(parent, this, new Point(sx, sy));
				_trashCan.x = p.x+10;
				_trashCan.y = p.y+10;
			}else{
				if(_trashCan)
				{
					removeChild(_trashCan);
					_trashCan = null;
				}
			}
		}
		
		
		private function toolInit():void 
		{
			// raise
			_transformTool.parent.setChildIndex(_transformTool, _transformTool.parent.numChildren - 1);
		}
		
		
		private function keyUpListener(e:KeyboardEvent) : void
		{
			var code = e.keyCode.toString();
			
			if(_transformTool.target && code == "8")
			{
				_transformTool.target.parent.removeChild(_transformTool.target);
				_transformTool.target = null;
				_objectCount = _objLayer.numChildren;
				dispatchEvent(new Event("onObjectRemovedFromCanvas"));
			}
		}
		
	}

}


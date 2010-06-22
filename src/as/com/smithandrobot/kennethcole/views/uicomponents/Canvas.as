package com.smithandrobot.kennethcole.views.uicomponents 
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;		
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOrientation;
	import flash.printing.PrintJobOptions;
	
	import flash.geom.Rectangle;
	
	import com.smithandrobot.kennethcole.transform.KennethColeTransformTool;
	import com.senocular.display.TransformTool;
	
	public class Canvas extends Sprite 
	{
		
		private var _printLayer : Sprite;
		private var _bkgLayer : Sprite;
		private var _bkgLayerBMP : Bitmap;
		private var _objLayer : Sprite;
		private var _transformTool : KennethColeTransformTool;
		private var _objectCount : int = 0;

		
		private var _currSelection;
		
		public function Canvas()
		{
			super();
			initTransformTool();
			setUpPrintLayer();
			addEventListener(MouseEvent.MOUSE_DOWN, select);
			stage.addEventListener(MouseEvent.MOUSE_UP, removeSelection);
			addEventListener(KeyboardEvent.KEY_UP,keyUpListener);
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
		
		public function print():void {
            var pj:PrintJob = new PrintJob();
			var po = new PrintJobOptions();
			po.printAsBitmap = true;
            if(pj.start()) {                

                try {
                    pj.addPage(this, new Rectangle(0,0, this.width, this.height), po, 0);
                }
                catch(e:Error) {
                    // do nothing
                }

				pj.send();
            }
        }
		//--------------------------------------
		//  Event Handlers
		//--------------------------------------
		
		private function onObjectAdded(e:Event)
		{
			trace("something is added");
			++_objectCount;
			dispatchEvent(new Event("onObjectAddedToCanvas"));
		}
		
		
		private function setUpPrintLayer()
		{
			_printLayer = addChild(new Sprite()) as Sprite;
			_printLayer.x = _printLayer.y = 8;
			_bkgLayer = _printLayer.addChild(new Sprite()) as Sprite;
			_bkgLayerBMP = new Bitmap();
			_bkgLayer.addChild(_bkgLayerBMP);
			
			_objLayer = _printLayer.addChild(new Sprite()) as Sprite;
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
		
		
		private function initTransformTool() : void
		{
			_transformTool = new KennethColeTransformTool();
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
			if (event.target == stage || event.target == getChildByName("bkg") || event.target == _bkgLayer) {
				_transformTool.target = null;
			}else if (event.target is Sprite) {
				_transformTool.target = event.target as Sprite;
				toolInit();
			}
		}

		
		private function removeSelection(e:MouseEvent) : void
		{
			if(_transformTool.target)
			{
				var bkg = getChildByName("bkg");
				trace("hit test: "+bkg.hitTestPoint(e.stageX, e.stageY))
				if(!bkg.hitTestPoint(e.stageX, e.stageY))
				{
					_transformTool.target.parent.removeChild(_transformTool.target);
					_transformTool.target = null;
					_objectCount = _objLayer.numChildren;
					dispatchEvent(new Event("onObjectRemovedFromCanvas"));
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
			trace("key code: "+e.keyCode.toString())
		}
		
	}

}


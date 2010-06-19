package com.smithandrobot.kennethcole.views.uicomponents 
{
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import com.smithandrobot.kennethcole.transform.KennethColeTransformTool;
	import com.senocular.display.TransformTool;
	
	public class Canvas extends Sprite 
	{
		
		private var _printLayer : Sprite;
		private var _bkgLayer : Sprite;
		private var _objLayer : Sprite;
		private var _transformTool : KennethColeTransformTool;
		private var _objectCount : int = 0;
		
		public function Canvas()
		{
			super();
			initTransformTool();
			setUpPrintLayer();
			addEventListener(MouseEvent.MOUSE_DOWN, select);
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
		
		public function get objectCount() : int
		{
			return _objectCount;
		}
		
		
		public function hideTransformTool()
		{
			_transformTool.target = null;
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
			_bkgLayer = _printLayer.addChild(new Sprite()) as Sprite;
			_objLayer = _printLayer.addChild(new Sprite()) as Sprite;
			_printLayer.scaleX = _printLayer.scaleY = .5;
			var m = makeMask();
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
			/*_transformTool.minScaleX = .2;
			_transformTool.minScaleY = .2;
			_transformTool.maxScaleX = 1.2;
			_transformTool.maxScaleY = 1.2;*/
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
			if (event.target == stage || event.target == getChildByName("bkg")) {
				_transformTool.target = null;
			}else if (event.target is Sprite) {
				_transformTool.target = event.target as Sprite;
				toolInit();
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


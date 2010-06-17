package com.smithandrobot.kennethcole.transform
{
	import com.senocular.display.TransformTool;
	import flash.geom.Matrix;
	
	public class KennethColeTransformTool extends TransformTool
	{
		
		protected var _minScaleX : Number = Infinity;
		protected var _minScaleY : Number = Infinity;
		
		public function KennethColeTransformTool()
		{
			super();
		}
		
		
		public function set minScaleY(n:Number) : void
		{
			_minScaleY = n;
		}
		
		public function set minScaleX(n:Number) : void
		{
			_minScaleX = n;
		}
		
		
		override protected function enforceLimits():void {
			
			var currScale:Number;
			var angle:Number;
			var enforced:Boolean = false;
			
			trace("enforcing")
			// use global matrix
			var _toolMatrix = super.toolMatrix;
			var _maxScaleX  = super.maxScaleX;
			var _maxScaleY  = super.maxScaleY;
			var _globalMatrix:Matrix = _toolMatrix.clone();
			_globalMatrix.concat(transform.concatenatedMatrix);
			
			// check current scale in X
			currScale = Math.sqrt(_globalMatrix.a * _globalMatrix.a + _globalMatrix.b * _globalMatrix.b);
			if (currScale > _maxScaleX) {
				// set scaleX to no greater than _maxScaleX
				angle = Math.atan2(_globalMatrix.b, _globalMatrix.a);
				_globalMatrix.a = Math.cos(angle) * _maxScaleX;
				_globalMatrix.b = Math.sin(angle) * _maxScaleX;
				enforced = true;
			}
			
			if (currScale < _minScaleX) {
				// set scaleX to no less than _minScaleX
				trace("less thtn min scale")
				angle = Math.atan2(_globalMatrix.b, _globalMatrix.a);
				_globalMatrix.scalea = Math.cos(angle) * _minScaleX;
				_globalMatrix.b = Math.sin(angle) * _minScaleX;
				enforced = true;
			}
			
			// check current scale in Y
			currScale = Math.sqrt(_globalMatrix.c * _globalMatrix.c + _globalMatrix.d * _globalMatrix.d);
			if (currScale > _maxScaleY) {
				// set scaleY to no greater than _maxScaleY
				angle= Math.atan2(_globalMatrix.c, _globalMatrix.d);
				_globalMatrix.d = Math.cos(angle) * _maxScaleY;
				_globalMatrix.c = Math.sin(angle) * _maxScaleY;
				enforced = true;
			}
			
			if (currScale < _minScaleY) {
				// set scaleY to no greater than _maxScaleY
				angle= Math.atan2(_globalMatrix.c, _globalMatrix.d);
				_globalMatrix.d = Math.cos(angle) * _minScaleY;
				_globalMatrix.c = Math.sin(angle) * _minScaleY;
				enforced = true;
			}
			
			
			// if scale was enforced, apply to _toolMatrix
			if (enforced) {
				super.toolMatrix = _globalMatrix;
				var current:Matrix = transform.concatenatedMatrix;
				current.invert();
				super.toolMatrix.concat(current);
			}
		}
	}
}
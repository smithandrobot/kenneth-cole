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
	}
}
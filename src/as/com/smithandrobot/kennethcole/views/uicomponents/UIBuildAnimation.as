package com.smithandrobot.kennethcole.views.uicomponents 
{
	
	import flash.display.Sprite;
	import com.greensock.TweenNano;
	import com.greensock.easing.*;
	import flash.events.Event;
	
	public class UIBuildAnimation extends Sprite 
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		
		protected var _scope : Sprite;
		/**
		 *	@constructor
		 */
		public function UIBuildAnimation(scope)
		{
			super();
			_scope = scope;
		}
		
		
		public function start() : void
		{
			var delay 	= .25;
			var orgX; var orgY;
			var canvas 	= _scope.getChildByName("canvas");
			var logo	= _scope.getChildByName("logo");
			var gc 		= _scope.getChildByName("getCreative");
			var ii 		= _scope.getChildByName("introInstructions");
			var pb 		= _scope.getChildByName("pickAbkg");
			var cb 		= _scope.getChildByName("clickBKG");
			var bb 		= _scope.getChildByName("blankBKG");			
			var ai 		= _scope.getChildByName("addItems");
			var di 		= _scope.getChildByName("dragItems");
			var pBtn	= _scope.getChildByName("printBtn");
			var nav		= _scope.getChildByName("nav");
			var navHome = nav.getChildByName("nav_home");
			var navSweeps = nav.getChildByName("nav_sweeps");
			var navShop = nav.getChildByName("nav_shop");
			
			orgY = logo.y;
			logo.y += 10;
			TweenNano.to(logo, .25, {alpha:1, y:orgY});
			
			orgX = gc.x;
			gc.x -= 5;
			TweenNano.to(gc, .25, {delay:delay, alpha:1, x: orgX});
			
			orgX = ii.x;
			ii.x -= 5;
			TweenNano.to(ii, .25, {delay:delay+.15, alpha:1, x: orgX});
			
			//canvas.scaleX = pBtn.scaleY = .1;
			TweenNano.to(canvas, .5, {delay:delay+.3, alpha:1});
			
			//navHome.alpha = navShop.alpha = navSweeps.alpha = 0;
			
			TweenNano.to(nav, .25, {delay: delay+.3, alpha:1});
			TweenNano.from(navHome, .25, {delay: delay+.3, alpha:0, scaleX:.1, scaleY: .1, ease:Back.easeOut});
			TweenNano.from(navSweeps, .25, {delay: delay+.5, alpha:0, scaleX:.1, scaleY: .1, ease:Back.easeOut});
			TweenNano.from(navShop, .25, {delay: delay+.7, alpha:0, scaleX:.1, scaleY: .1, ease:Back.easeOut});
			
			orgX = pb.x;
			pb.x -= 20;
			TweenNano.to(pb, .25, {delay:delay+.45, alpha:1, x: orgX, ease:Back.easeOut});
			
			orgX = cb.x;
			cb.x -= 10;
			TweenNano.to(cb, .25, {delay:delay+.6, alpha:1, x: orgX});

			pBtn.scaleX = pBtn.scaleY = .1;
			TweenNano.to(pBtn, .5, {delay:delay+.75, alpha:.5, scaleX:1, scaleY:1, ease:Back.easeOut, onComplete:onBuildDone});
			
			orgX = ai.x;
			ai.x += 20;
			TweenNano.to(ai, .25, {delay:delay+.55, alpha:1, x: orgX, ease:Back.easeOut});
			
			orgX = di.x;
			di.x += 10;
			TweenNano.to(di, .25, {delay:delay+.7, alpha:1, x: orgX});
			
		}
		
		private function onBuildDone()
		{
			trace("buidl done called")
			dispatchEvent(new Event("onUIAnimatedIn"));
		}
		
	}

}


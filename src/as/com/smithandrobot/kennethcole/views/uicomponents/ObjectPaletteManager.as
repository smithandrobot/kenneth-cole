package com.smithandrobot.kennethcole.views.uicomponents 
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;

	import com.smithandrobot.kennethcole.views.uicomponents.ObjectPaletteNavItem;
	import com.smithandrobot.kennethcole.views.uicomponents.PaletteObject;
	import com.smithandrobot.kennethcole.views.uicomponents.CanvasObject;
	import com.smithandrobot.kennethcole.views.uicomponents.Canvas;
	
	import com.smithandrobot.utils.CoordinateTools;
	
	public class ObjectPaletteManager extends Sprite 
	{
		private var _navSpace 		: ObjectPaletteNavItem;
		private var _navCity 		: ObjectPaletteNavItem;
		private var _navCharacters	: ObjectPaletteNavItem;
		private var _selectedID		: int;
		private var _nav			: Array = new Array();
		private var _palettes		: MovieClip;
		private var _canvas			: Canvas;
		private var _printLayer		: Sprite;
		private var _nextBtn		: MovieClip;
		private var _backBtn		: MovieClip;
		
		private static var START	: int 		= -13;
		private static var PWIDTH	: int 		= 280;
		private static var PADDING	: int 		= 20;
		private static var NUM_PALETTES : int	= 3;
		
		public function ObjectPaletteManager()
		{
			TweenPlugin.activate([AutoAlphaPlugin]);
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener("onPaletteObjectCreated", onPaletteObjectCreated);
		}


		public function set canvas(c:Canvas) : void
		{
			_canvas = c;
		}
		
		
		private function onAdded(e:Event = null) : void
		{
			setUpNav();
			_palettes = getChildByName("paletteContainer") as MovieClip;
			setUpMasking();
			init();
			initObjects();
			UIBuild();
		}
		
		
		private function UIBuild() : void
		{
			var obj;
			var delay = .08;
			var d;
			var container;
			var total;
			var j = 0;
			
			if(_palettes) TweenLite.from(_palettes, .5,{delay:.5, alpha:0});
			if(_navSpace)
			{
				TweenLite.from(getChildByName("navSpace"), .5, {y:"5",alpha:0});
				TweenLite.from(getChildByName("navCity"), .5, {y:"5", delay:.15, alpha:0});
				TweenLite.from(getChildByName("navCharacters"), .5, {y:"5", delay:.3, alpha:0});
			}
			
			if(_palettes)
			{
				container = _palettes.getChildAt(0);
				total = container.numChildren-1;
				for(j; j<=total; j++)
				{
					d = j*delay+.5;
					obj = container.getChildAt(j) as MovieClip;
					TweenLite.from(obj, .15, {alpha:0, delay:d, scaleX:.01, scaleY:.01, ease:Back.easeOut, easeParams:1.5});
				}
			}
		}
		
		
		private function init()
		{
			var defaultSelection = _navSpace;
			defaultSelection.selected = true;
			_selectedID = defaultSelection.id;
			handlePaletteChange(defaultSelection);
			
		}
		
		
		private function onNavClick(e:Event) : void
		{
			var id = e.target.id;
			_selectedID = id;
			handlePaletteChange(e.target)
		}
		
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		
		
		private function setUpNav() : void
		{
			_navSpace  			= new ObjectPaletteNavItem(getChildByName("navSpace") as MovieClip);
			_navSpace.id 		= 1;
			_nav.push(_navSpace);
			
			_navCity  			= new ObjectPaletteNavItem(getChildByName("navCity") as MovieClip);
			_navCity.id 		= 2;
			_nav.push(_navCity);
			
			_navCharacters  	= new ObjectPaletteNavItem(getChildByName("navCharacters") as MovieClip);
			_navCharacters.id	= 3;
			_nav.push(_navCharacters);
			
			_nextBtn = getChildByName("nextBtn") as MovieClip;
			_backBtn = getChildByName("backBtn") as MovieClip; 
			_nextBtn.buttonMode = _backBtn.buttonMode = true;
			
			_nextBtn.addEventListener(MouseEvent.CLICK, onPaginationClick);
			_backBtn.addEventListener(MouseEvent.CLICK, onPaginationClick);
			
			_navSpace.addEventListener("paletteNavClick", onNavClick);
			_navCity.addEventListener("paletteNavClick", onNavClick);
			_navCharacters.addEventListener("paletteNavClick", onNavClick);
		}
		
		
		private function handlePaletteChange(n) : void
		{
			var i = 0;
			var destX = START - ((_selectedID-1)*(PWIDTH+PADDING));
			for(i in _nav)
			{
				if(_nav[i] != n) _nav[i].selected = false
			}
			
			TweenLite.to(_palettes, .5, {x:destX, overwrite:true});
			updatePagNav();
		}
		
		
		private function onPaginationClick(e:MouseEvent) : void
		{
			var pagID = (e.target == _nextBtn) ? ++_selectedID : --_selectedID;
			pagID = (pagID > NUM_PALETTES) ? 1 : pagID;
			pagID = (pagID < 1) ? NUM_PALETTES : pagID;
			_selectedID = pagID;
			var navItem = _nav[_selectedID-1];
			navItem.selected = true;
			handlePaletteChange(navItem);
		}
		
		
		private function updatePagNav()
		{
			if(_selectedID == NUM_PALETTES) TweenLite.to(_nextBtn, .5, {autoAlpha:0});
			if(_selectedID == 1) TweenLite.to(_backBtn, .5, {autoAlpha:0});
			if(_selectedID > 1 && _backBtn.alpha < 1) TweenLite.to(_backBtn, .5, {autoAlpha:1});
			if(_selectedID < NUM_PALETTES && _nextBtn.alpha < 1) TweenLite.to(_nextBtn, .5, {autoAlpha:1});
		}
		
		
		private function setUpMasking() : void
		{
			var m = new PaletteContainerMask();
			m.x = START;
			addChild(m)
			_palettes.mask = m;
		}
		
		
		private function initObjects()
		{
			var i = 0;
			var j 	= 0;
			var total = 0;
			var container;
			var paletteTotal = _palettes.numChildren-1;
			var po : PaletteObject;
			
			for(i; i<=paletteTotal; i++)
			{
				j = 0;
				container = _palettes.getChildAt(i);
				total = container.numChildren-1;
				for(j; j<=total; j++)
				{
					po = new PaletteObject(container.getChildAt(j) as MovieClip);
					po.addEventListener("onPaletteObjectCreated", onPaletteObjectCreated);
				}
			}
		}
		
		
		private function onPaletteObjectCreated(e:Event)
		{
			var obj = e.target.canvasObject as MovieClip;
			var layer = (_canvas) ? _canvas : this;
			var p = CoordinateTools.localToLocal(e.target.scope, layer);
			obj.type = "canavsObject";
			var s = layer.addChild(obj);
			
			s.x = p.x;
			s.y = p.y;
			var co = new CanvasObject(s);
			co.canvas = _canvas;
		}
	}

}
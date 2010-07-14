package com.smithandrobot.kennethcole.views.uicomponents 
{
	
	import flash.display.*;
	import flash.events.*;
    import flash.net.*;

	import com.disney.tracking.AdServe;
	
	public class Navigation extends Sprite 
	{
		
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		
		private var _homeBtn 	: MovieClip;
		private var _sweepsBtn 	: MovieClip;
		private var _shopBtn 	: MovieClip;
		private var _adServe	: AdServe;
		
		public function Navigation()
		{
			_homeBtn 	= getChildByName("nav_home") as MovieClip;
			_sweepsBtn 	= getChildByName("nav_sweeps") as MovieClip;
			_shopBtn 	= getChildByName("nav_shop") as MovieClip;
			_adServe	= new AdServe("flashAd.html", true, true);
			
			initBehaviors();
		}
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
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
			_homeBtn.buttonMode = _sweepsBtn.buttonMode = _shopBtn.buttonMode = true;
			
			_homeBtn.addEventListener(MouseEvent.CLICK, onNavClick);
			_sweepsBtn.addEventListener(MouseEvent.CLICK, onNavClick);
			_shopBtn.addEventListener(MouseEvent.CLICK, onNavClick);
		}
		
		private function onNavClick(e:MouseEvent) : void
		{
			var id : int;
			
			if(e.target.name == "nav_home") id = 13;
			if(e.target.name == "nav_sweeps") id = 14;
			if(e.target.name == "nav_shop") id = 15;
			
			_adServe.clickAd(id);
		}
	}

}


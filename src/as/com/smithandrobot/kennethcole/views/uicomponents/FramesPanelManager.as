package com.smithandrobot.kennethcole.views.uicomponents
{

	import flash.display.Sprite;
	import flash.events.*;
	
	import com.greensock.TweenNano;
	import com.greensock.easing.*
	
	import com.smithandrobot.kennethcole.views.uicomponents.Frame;
	import com.smithandrobot.utils.RobotMath;
	
	public class FramesPanelManager extends Sprite 
	{
		private var _frames : Array;
		private var _selected;
		private var _bmpData;
		private var _canvas;
		
		public function FramesPanelManager()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		public function set canvas (c) : void
		{
			_canvas = c;
		}
		
		
		private function onAdded(e:Event) :void
		{
			UIBuild();
			init();
		}
		
		
		
		private function init() : void
		{
			var i = 0;
			var total = _frames.length-1;
			var f;
			var bmpDataArray = new Array
			(
				{id:"frame1", data:"Frame1"},
				{id:"frame2", data:"Frame2"},
				{id:"frameMars", data:"FrameMars"},
				{id:"frameDay", data:"FrameDay"},
				{id:"frameNight", data:"FrameNight"},
				{id:"frameEarth", data:"FrameEarth"},
				{id:"blankBKG", data:"FrameRegular"}
			)
			
			for(i; i<= total; i++)
			{
				f = _frames[i];
				f.bmpDataArray = bmpDataArray;
				f.addEventListener("onFrameSelected", onFrameSelected);
			}
			
			_selected = getFrameByID("blankBKG");
		}
		
		
		private function onFrameSelected(e:Event) : void
		{
			_selected = e.target;
			_bmpData = e.target.bmpData;
			setSelected();
			if(_bmpData && _canvas) _canvas.bkgLayerBMP.bitmapData = _bmpData;
		}
		
		
		private function setSelected()
		{
			var i = 0;
			var total = _frames.length -1;
			for(i; i<= total; i++)
			{
				if(_frames[i] == _selected) 
				{
								trace("setting selected")
								_frames[i].selected = true;
				}
				if(_frames[i] != _selected) _frames[i].selected = false;
			}
		}
		
		
		private function getFrameByID(id:String) : Frame
		{
			var i = 0;
			var total = _frames.length -1;
			
			for(i; i<= total; i++)
			{
				if(_frames[i].id == id) return _frames[i];
			}
			
			return null;
		}
		
		
		private function UIBuild()
		{
			var i = 0;
			var total = numChildren-1;
			var frame;
			var fClass;
			var delay = .1;
			var masterDelay = .5;
			var d;
			var f : Function;
			
			_frames = new Array();
			
			for(i; i<= total; i++)
			{
				frame = getChildAt(i);
				fClass = new Frame(frame);
				fClass.id = frame.name;	
				_frames.push(fClass);
				d = masterDelay+delay*i;
				f = (i==total) ? onUIin: null;
				TweenNano.from(frame, .25, {delay:d, alpha:0, scaleX:.1, scaleY:.1, ease:Back.easeOut, onComplete:f});
			}
		}
		
		private function onUIin()
		{
			setSelected();
			_bmpData = _selected.bmpData;
			if(_bmpData && _canvas) _canvas.bkgLayerBMP.bitmapData = _bmpData;
		}
	}
}


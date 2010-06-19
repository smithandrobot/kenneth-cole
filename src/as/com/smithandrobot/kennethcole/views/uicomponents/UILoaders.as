package com.smithandrobot.kennethcole.views.uicomponents 
{

	import flash.events.Event;	
	import flash.events.EventDispatcher;
	import flash.display.Sprite;
	
	import com.greensock.TweenNano;
	
	import com.smithandrobot.utils.FileLoader;
	import com.smithandrobot.events.FileLoaderEvent;
	import com.smithandrobot.kennethcole.views.uicomponents.ObjectPaletteManager;
	
	public class UILoaders extends EventDispatcher 
	{
		
		private var _frameLoaderSprite 	: Sprite;
		private var _objectLoaderSprite : Sprite;
		private var _objectPalette		: *;
		private var _framesPanel		: Sprite;
		private var _objectLoader		: FileLoader;
		private var _frameLoader		: FileLoader;
		
		public function UILoaders()
		{
			super();
		}
		
		public function loadFrames(s, file) : Sprite
		{
			_frameLoaderSprite = new LoadingBKGs();
			_frameLoaderSprite.alpha = 0;
			_frameLoaderSprite.x = 17;
			_frameLoaderSprite.y = 364+5;
			s.addChild(_frameLoaderSprite);
			TweenNano.to(_frameLoaderSprite, .5, {alpha:.5, y:364});
			_frameLoader = new FileLoader();
			_frameLoader.addEventListener(FileLoaderEvent.FILE_LOADED, onFramesLoaded);
			_frameLoader.file = file;
			return _frameLoaderSprite;
		}
		
		
		public function loadObjects(s, file) : Sprite
		{
			_objectLoaderSprite = new LoadingItems();
			_objectLoaderSprite.alpha = .5
			_objectLoaderSprite.x = 782;
			_objectLoaderSprite.y = 294+5;
			s.addChild(_objectLoaderSprite);
			TweenNano.to(_objectLoaderSprite, .5, {alpha:.5, y:294});
			_objectLoader = new FileLoader();
			_objectLoader.addEventListener(FileLoaderEvent.FILE_LOADED, onObjectsLoaded);
			/*_objectLoader.classType = ObjectPaletteManager;*/
			_objectLoader.file = file;
			return _objectLoaderSprite;
		}
		
		
		public function get objectPalette() : *
		{
			return _objectPalette;
		}
		
		public function get framesPanel() : Sprite
		{
			return _framesPanel;
		}
		
		
		private function onObjectsLoaded(e:FileLoaderEvent) : void
		{
			_objectPalette = e.data.content;
			TweenNano.to(_objectLoaderSprite, .25, {alpha:0, overwrite:true});
			dispatchEvent(new Event("onObjectsPaletteLoaded"));
		}
		
		
		private function onFramesLoaded(e:FileLoaderEvent) : void
		{
			//_framesPanel = e.data.content;
			dispatchEvent(new Event("onObjectsFramesLoaded"));
		}
		
	}
}




package com.smithandrobot.utils 
{

/**
 *	Class description.
 *
 *	@langversion ActionScript 3.0
 *	@playerversion Flash 9.0
 *	@author David Ford
 *	@since  13.04.2009
 */

	import flash.net.URLRequest;
	import flash.net.*;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;

	import com.smithandrobot.utils.PathFinder;	
	import com.smithandrobot.utils.Base64Encoder;
	import com.smithandrobot.events.FileLoaderEvent;
	
	public class FileLoader extends EventDispatcher 
	{


		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------

		private var _file 		: String;
		private var _loader 	: Loader;
		private var _files		: Array;
		private var _cacheFiles	: Boolean = false;
		private var _class 		: *;
		
		public function FileLoader()
		{
			if(_cacheFiles) _files = new Array();
		}

		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		
		public function set file(f:String) : void
		{
			if(f=="" || f==null) 
			{
				trace("No files passed to file loader!")
				return;
			}
			
			_file = f;
			var cachedFile;
			
			if(_cacheFiles)
			{
				if(cachedFile == checkIfFileLoaded(f))
				{
					dispatchEvent(new FileLoaderEvent(FileLoaderEvent.FILE_LOADED, {content:cachedFile}));
				}else{
					startLoad(f);

				}
			}else{
				startLoad(f);
			}
			
		}
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		public function set classType(c:Class) : void
		{
			_class = c;
		}
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		


		private function startLoad(f)
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.INIT, onCompleteHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR , onErrorHandler);
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
			_loader.load(new URLRequest(_file), context);
		}
		
		private function onOpen(loadEvent:Event)
		{
			var file = loadEvent.target.loader.contentLoaderInfo.url;
		}
		
		
		private function onCompleteHandler(loadEvent:Event)
		{
				var c = (_class) ? loadEvent.currentTarget.content as _class : loadEvent.currentTarget.content;
				_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
				if(_cacheFiles) _files.push({file:_file, content: c});
				dispatchEvent(new FileLoaderEvent(FileLoaderEvent.FILE_LOADED, {content:c}));
		}
		
		
		private function onProgressHandler(mProgress:ProgressEvent)
		{
			var percent:Number = mProgress.bytesLoaded/mProgress.bytesTotal;
		}
		
		
		private function checkIfFileLoaded(f)
		{
			for (var i in _files)
			{
				if(_files[i].file == f) return _files[i].file
			}
			
			return null;
		}
		
		private function onErrorHandler(e:IOErrorEvent)
		{
			trace("there is an error: "+e);
		}
		
		private function loadWithAuthentication(f)
		{
			_loader = new Loader();
			var _queryRequest:URLRequest = new URLRequest();
			_queryRequest.url = f;
			
			// POST is required for HTTP Auth headers to be passed
			_queryRequest.method = "POST"; 
			
			// Some type of POST data must be present for POST to happen in the first place
			_queryRequest.data = "dummy_data=needed_for_post_to_work"; 
			
			var encoder:Base64Encoder = new Base64Encoder();
			encoder.encode("jeep:tr1pc4st");
			
			var authString = "Basic " + encoder.toString();
			var _queryAuthorizationHeader:URLRequestHeader = new URLRequestHeader("Authorization", authString);
			_queryRequest.requestHeaders.push(_queryAuthorizationHeader);
			var _queryTypeHeader = new URLRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			_queryRequest.requestHeaders.push(_queryTypeHeader);
			_loader.contentLoaderInfo.addEventListener(Event.INIT, onCompleteHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR , onErrorHandler);
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
			_loader.load(_queryRequest);
			
		}
		
	}

}

